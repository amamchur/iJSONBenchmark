//
//  IJBTestBenchmark.m
//  iJSONBenchmark
//
//  Created by admin on 4/18/13.
//  Copyright (c) 2013 Andrii Mamchur. All rights reserved.
//

#import "IJBTestBenchmark.h"

#import "JsonLiteAccumulator.h"
#import "SBJson.h"
#import "JSONKit.h"
#import "YAJL.h"

#import "mach/mach.h"

@implementation IJBParser

+ (id)parserWithName:(NSString *)name selector:(SEL)selector {
    IJBParser *p = [[IJBParser alloc] init];
    p.name = name;
    p.selector = selector;
    return [p autorelease];
}

- (void)dealloc {
    self.name = nil;
    [super dealloc];
}

@end

@implementation IJBTestBenchmarkResult

- (void)dealloc {
    self.name = nil;
    [super dealloc];
}

@end

@implementation IJBTestBenchmark

@synthesize payloads;
@synthesize results;

- (id)init {
    self = [super init];
    if (self != nil) {
        self.payloadCache = [[NSCache alloc] init];
        self.payloads = [[NSArray arrayWithObjects:
                          @"instruments",
                          @"nested",
                          @"update-center",
                          @"apache_builds",
                          @"mesh",
                          @"random",
                          @"truenull",
                          @"github_events",
                          @"mesh.pretty",
                          @"repeat",
                          @"twitter_timeline",
                          @"sample",
                          nil] sortedArrayUsingSelector:@selector(compare:)];
        self.parsers = [NSArray arrayWithObjects:
                        [IJBParser parserWithName:@"JsonLite" selector:@selector(goJsonLiteWithPayload:)],
                        [IJBParser parserWithName:@"JSONKit" selector:@selector(goJSONKitWithPayload:)],
                        [IJBParser parserWithName:@"YALJ" selector:@selector(goYAJLWithPayload:)],
                        [IJBParser parserWithName:@"SBJson" selector:@selector(goSBJsonWithPayload:)],
                        nil];
        
        // First iteration to create Objective-C methods' cache.
        self.results = [NSMutableDictionary dictionaryWithCapacity:13];
    }
    return self;
}

- (void)dealloc {
    self.payloads = nil;
    self.parsers = nil;
    self.results = nil;
    [super dealloc];
}

- (BOOL)compareNumber:(NSNumber *)n1 withNumber:(NSNumber *)n2 {
    double d1 = [n1 doubleValue];
    double d2 = [n2 doubleValue];
    double dx = fabs(d1 - d2);
    return dx <= 0.00000005;
}

- (BOOL)compareDictionary:(NSDictionary *)d1 withDictionary:(NSDictionary *)d2 {
    NSInteger c1 = [d1 count];
    NSInteger c2 = [d2 count];
    BOOL equal = c1 == c2;
    if (!equal) {
        return NO;
    }
    
    for (id key in d1) {
        id obj1 = [d1 objectForKey:key];
        id obj2 = [d2 objectForKey:key];
        if ([obj1 isKindOfClass:[NSArray class]] && [obj2 isKindOfClass:[NSArray class]]) {
            equal = [self compareArray:obj1 withArray:obj2];
            if (!equal) {
                return NO;
            }
            continue;
        }
        
        if ([obj1 isKindOfClass:[NSDictionary class]] && [obj2 isKindOfClass:[NSDictionary class]]) {
            [self compareDictionary:obj1 withDictionary:obj2];
            continue;
        }
        
        if ([obj1 isKindOfClass:[NSNumber class]] && [obj2 isKindOfClass:[NSNumber class]]) {
            equal = [self compareNumber:obj1 withNumber:obj2];
            if (!equal) {
                return NO;
            }
            continue;
        }
        
        if (obj1 != NULL && obj2 != NULL) {
            if (![obj1 isEqual:obj2]) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)compareArray:(NSArray *)a1 withArray:(NSArray *)a2 {
    NSInteger c1 = [a1 count];
    NSInteger c2 = [a2 count];
    BOOL equal = c1 == c2;
    if (!equal) {
        return NO;
    }
    
    for (NSInteger i = 0; i < c1; i++) {
        id obj1 = [a1 objectAtIndex:i];
        id obj2 = [a2 objectAtIndex:i];
        if ([obj1 isKindOfClass:[NSArray class]] && [obj2 isKindOfClass:[NSArray class]]) {
            equal = [self compareArray:obj1 withArray:obj2];
            if (!equal) {
                return NO;
            }
            continue;
        }
        
        if ([obj1 isKindOfClass:[NSDictionary class]] && [obj2 isKindOfClass:[NSDictionary class]]) {
            equal = [self compareDictionary:obj1 withDictionary:obj2];
            if (!equal) {
                return NO;
            }
            continue;
        }
        
        if ([obj1 isKindOfClass:[NSNumber class]] && [obj2 isKindOfClass:[NSNumber class]]) {
            equal = [self compareNumber:obj1 withNumber:obj2];
            if (!equal) {
                return NO;
            }
            continue;
        }
        if (![obj1 isEqual:obj2]) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)compareObject:(id)o1 withObject:(id)o2 {
    if (o1 == o2) {
        return YES;
    }
    
    if (o1 == NULL || o2 == NULL) {
        return NO;
    }
    
    if ([o1 isKindOfClass:[NSArray class]] || [o2 isKindOfClass:[NSArray class]] ) {
        return [self compareArray:o1 withArray:o2];
    }
    
    if ([o1 isKindOfClass:[NSDictionary class]] || [o2 isKindOfClass:[NSDictionary class]] ) {
        return [self compareDictionary:o1 withDictionary:o2];
    }
    
    return NO;
}

- (NSData *)dataForPayload:(NSString *)name {
    NSData *data = [self.payloadCache objectForKey:name];
    if (data == nil) {
        NSString *file = [[NSBundle mainBundle] pathForResource:name
                                                         ofType:@"json"
                                                    inDirectory:@"payload"];
        data = [NSData dataWithContentsOfFile:file];
        [self.payloadCache setObject:data forKey:name];
    }
    
    return data;
}

- (IJBTestBenchmarkResult *)resultForTest:(SEL)selector payload:(NSString *)name {
    NSData *data = [self dataForPayload:name];
    IJBTestBenchmarkResult *result = [[IJBTestBenchmarkResult alloc] init];
    result.name = name;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    struct rusage r;
    struct timeval bu, bs;
    
    getrusage(RUSAGE_SELF, &r);
    bu = r.ru_utime;
    bs = r.ru_stime;
    
    id obj = [self performSelector:selector withObject:data];
    BOOL success = obj != nil;
    
    [pool release];
    
    getrusage(RUSAGE_SELF, &r);
    
    long time = (r.ru_utime.tv_sec - bu.tv_sec) + (r.ru_stime.tv_sec - bs.tv_sec);
    time = time * 1000000;
    time += (r.ru_utime.tv_usec - bu.tv_usec) + (r.ru_stime.tv_usec - bs.tv_usec);
    result.timeNanoSec = success ? time : -1;
    return [result autorelease];
}

- (id)objectOfTest:(SEL)selector payload:(NSString *)name {
    NSData *data = [self dataForPayload:name];
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    id obj = [self performSelector:selector withObject:data];
    [obj retain];
    BOOL success = obj != nil;
    
    [pool release];
    [obj autorelease];
    return success ? obj : nil;
}

- (void)performPerformanceTestForSelector:(SEL)sel {
    NSString *methodName = NSStringFromSelector(sel);
    NSMutableArray *array = [results objectForKey:methodName];
    if (array == nil) {
        array = [NSMutableArray arrayWithCapacity:13];
        [results setObject:array forKey:methodName];
    }
    
    for (NSString *name in payloads) {
        IJBTestBenchmarkResult *r = [self resultForTest:sel
                                                payload:name];
        [array addObject:r];
    }
}

- (void)printNanoSecCSV {
    NSArray *methods = [[results allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *header = [NSMutableString string];
    for (NSString *name in methods) {
        [header appendFormat:@",min %@", name];
        [header appendFormat:@",avg %@", name];
        [header appendFormat:@",max %@", name];
    }
    
    NSMutableString *rows = [NSMutableString string];
    for (NSString *payload in payloads) {
        [rows appendFormat:@"\n%@", payload];
        
        for (NSString *name in methods) {
            NSMutableArray *array = [results objectForKey:name];
            NSInteger count = 0;
            long sum = 0;
            long min = LONG_MAX;
            long max = LONG_MIN;
            for (IJBTestBenchmarkResult *r in array) {
                if ([r.name isEqualToString:payload]) {
                    sum += r.timeNanoSec;
                    max = MAX(max, r.timeNanoSec);
                    min = MIN(max, r.timeNanoSec);
                    count++;
                }
            }
            
            [rows appendFormat:@",%ld", min];
            [rows appendFormat:@",%ld", (long)(sum / count)];
            [rows appendFormat:@",%ld", max];
        }
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@", header, rows];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    basePath = [basePath stringByAppendingPathComponent:@"nanosec.csv"];
    NSLog(@"%@", basePath);
    [str writeToFile:basePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"\n%@%@", header, rows);
}

- (void)printCompareReportForPayload:(NSString *)name withDict:(NSDictionary *)dict {
    NSArray *parsers = [[dict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *header = [NSMutableString string];
    for (NSString *parser in parsers) {
        [header appendFormat:@",%@", parser];
    }
    
    NSMutableString *rows = [NSMutableString string];
    for (NSString *p1 in parsers) {
        [rows appendFormat:@"\n%@", p1];
        NSDictionary *d = [dict objectForKey:p1];
        for (NSString *p2 in parsers) {
            id res = [d objectForKey:p2];
            [rows appendFormat:@",%@", res];
        }
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@", header, rows];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    basePath = [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"cmp_%@.csv", name]];
    NSLog(@"%@", basePath);
    [str writeToFile:basePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"\n%@%@", header, rows);
}

- (void)performTestWithIterations:(int)iterations forParser:(IJBParser *)p {
    self.results = [NSMutableDictionary dictionaryWithCapacity:13];
    for (int i = 0; i < iterations; i++) {
        [self performPerformanceTestForSelector:p.selector];
    }
}

- (void)performTestWithIterations:(int)iterations {
    self.results = [NSMutableDictionary dictionaryWithCapacity:13];
    for (int i = 0; i < iterations; i++) {
        for (IJBParser *p in self.parsers) {
            [self performPerformanceTestForSelector:p.selector];
        }
    }
}

- (void)performCompareTest {
    NSInteger count = [self.parsers count];
    for (NSString *payload in payloads) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:count];
        for (IJBParser *p1 in self.parsers) {
            NSMutableDictionary *d = [NSMutableDictionary dictionaryWithCapacity:count];
            [dict setObject:d forKey:p1.name];
            
            id object1 = [self objectOfTest:p1.selector payload:payload];
            for (IJBParser *p2 in self.parsers) {
                id object2 = [self objectOfTest:p2.selector payload:payload];
                BOOL equal = [self compareObject:object1 withObject:object2];
                [d setObject:[NSNumber numberWithBool:equal] forKey:p2.name];
            }
        }
        [self printCompareReportForPayload:payload withDict:dict];
        [pool release];
    }
}

- (id)goJsonLiteWithPayload:(NSData *)data {
    // nested.json has 10000 nested arrays + 1 for reserve.
    return [JsonLiteAccumulator objectFromData:data withMaxDepth:10001];
}

- (id)goSBJsonWithPayload:(NSData *)data {
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    parser.maxDepth = 10001;
    id obj = [[[parser objectWithData:data] retain] autorelease];
    [parser release];
    return obj;
}

- (id)goJSONKitWithPayload:(NSData *)data {
    return [data objectFromJSONData];
}

- (id)goYAJLWithPayload:(NSData *)data {
    NSError *error = nil;
    YAJLDocument *doc = [[[YAJLDocument alloc] initWithParserOptions:YAJLParserOptionsCheckUTF8
                                                            capacity:10001] autorelease];
    [doc parse:data error:&error];
    return error == nil ? doc.root : nil;
}


@end

