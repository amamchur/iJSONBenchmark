//
//  Copyright 2012-2013, Andrii Mamchur
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License


#import "IJBTestBenchmark.h"

#import "JsonLiteObjC/JsonLiteObjC.h"
#import "SBJson.h"
#import "JSONKit.h"
#import "YAJL.h"
#import "JPJson/JPJsonParser.h"

#import <mach/mach.h>
#import <mach/clock.h>

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

@synthesize name;
@synthesize timeNanoSec;

- (void)dealloc {
    self.name = nil;
    [super dealloc];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %lld", name, timeNanoSec];
}

@end

@implementation IJBTestBenchmark

@synthesize payloads;
@synthesize results;

- (id)init {
    self = [super init];
    if (self != nil) {
        self.payloads = [[NSArray arrayWithObjects:
                          @"apache_builds",
                          @"github_events",
                          @"instruments",
                          @"mesh",
                          @"mesh.pretty",
                          @"random",
                          @"repeat",
                          @"truenull",
                          @"twitter_timeline",
                          @"update-center",
                          nil] sortedArrayUsingSelector:@selector(compare:)];
        self.parsers = [NSArray arrayWithObjects:
                        [IJBParser parserWithName:@"JPjson" selector:@selector(goJPjsonWithPayload:)],
                        [IJBParser parserWithName:@"JSONKit" selector:@selector(goJSONKitWithPayload:)],
                        [IJBParser parserWithName:@"JsonLite" selector:@selector(goJsonLiteWithPayload:)],
                        [IJBParser parserWithName:@"NSJSONSerialization" selector:@selector(goJSONSerialization:)],
                        [IJBParser parserWithName:@"SBJson" selector:@selector(goSBJsonWithPayload:)],
                        [IJBParser parserWithName:@"YAJL" selector:@selector(goYAJLWithPayload:)],
                        nil];
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
    return dx <= 0.0000000005;
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
    NSString *file = [[NSBundle mainBundle] pathForResource:name
                                                     ofType:@"json"
                                                inDirectory:@"payload"];
    NSData *data = [NSData dataWithContentsOfFile:file];
    return data;
}

- (IJBTestBenchmarkResult *)resultForTest:(IJBParser *)parser
                                  payload:(NSString *)name
                                     data:(NSData *)data {
    IJBTestBenchmarkResult *result = [[IJBTestBenchmarkResult alloc] init];
    result.name = name;
    
    clock_serv_t cclock;
    mach_timespec_t start, end;
    host_get_clock_service(mach_host_self(), SYSTEM_CLOCK, &cclock);
    clock_get_time(cclock, &start);
    
    BOOL success = YES;
    @autoreleasepool {
        id obj = [self performSelector:parser.selector withObject:data];
        success = obj != nil;
    }
    
    clock_get_time(cclock, &end);

    long long time = (end.tv_sec - start.tv_sec) * 1000000000;
    time += (end.tv_nsec - start.tv_nsec);
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

- (void)performPerformanceTestForParser:(IJBParser *)parser
                                payload:(NSString *)name
                                   data:(NSData *)data {
    NSMutableArray *array = [results objectForKey:parser.name];
    if (array == nil) {
        array = [NSMutableArray arrayWithCapacity:13];
        [results setObject:array forKey:parser.name];
    }
    
    IJBTestBenchmarkResult *r = [self resultForTest:parser payload:name data:data];
    [array addObject:r];
}

- (void)appendString:(NSString *)str toStream:(NSOutputStream *)stream {
    @autoreleasepool {
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [stream write:[data bytes] maxLength:[data length]];
    }
}

- (void)printNanoSecCVSForParser:(NSString *)parser payload:(NSString *)payload {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *file = [NSString stringWithFormat:@"nanosec_%@_%@.csv", parser, payload];
    NSString *avgReportFile = [basePath stringByAppendingPathComponent:file];
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:avgReportFile
                                                                  append:NO];
    [stream open];
    NSMutableArray *array = [results objectForKey:parser];
    int iteration = 1;
    for (IJBTestBenchmarkResult *r in array) {
        if ([r.name isEqualToString:payload]) {
            [self appendString:[NSString stringWithFormat:@"%d, %lld\n", iteration++, r.timeNanoSec]
                      toStream:stream];
        }
    }
    [stream close];
}

- (void)printNanoSecCVSPerParser {
    for (NSString *name in results) {
        for (NSString *payload in payloads) {
            [self printNanoSecCVSForParser:name payload:payload];
        }
    }
}

- (void)printNanoSecCSV {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *avgReportFile = [basePath stringByAppendingPathComponent:@"nanosec_avg.csv"];
    NSString *minReportFile = [basePath stringByAppendingPathComponent:@"nanosec_min.csv"];
    NSString *maxReportFile = [basePath stringByAppendingPathComponent:@"nanosec_max.csv"];
    NSOutputStream *avgStream = [NSOutputStream outputStreamToFileAtPath:avgReportFile
                                                                  append:NO];
    NSOutputStream *minStream = [NSOutputStream outputStreamToFileAtPath:minReportFile
                                                                  append:NO];
    NSOutputStream *maxStream = [NSOutputStream outputStreamToFileAtPath:maxReportFile
                                                                  append:NO];    
    NSArray *methods = [[results allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *header = [NSMutableString string];
    for (NSString *name in methods) {
        [header appendFormat:@",%@", name];
    }
    
    [avgStream open];
    [minStream open];
    [maxStream open];
    [self appendString:header toStream:avgStream];
    [self appendString:header toStream:minStream];
    [self appendString:header toStream:maxStream];
    
    for (NSString *payload in payloads) {
        NSMutableString *avgRow = [NSMutableString stringWithFormat:@"\n%@", payload];
        NSMutableString *minRow = [NSMutableString stringWithFormat:@"\n%@", payload];
        NSMutableString *maxRow = [NSMutableString stringWithFormat:@"\n%@", payload];
       
        for (NSString *name in methods) {
            NSArray *array = [results objectForKey:name];
            NSPredicate *p = [NSPredicate predicateWithFormat:@"name == %@", payload];
            array = [array filteredArrayUsingPredicate:p];
            
            long long count = [array count];
            long long avg = 0;
            long long min = LLONG_MAX;
            long long max = LLONG_MIN;            
            
            for (IJBTestBenchmarkResult *r in array) {
                avg += (r.timeNanoSec / count);
                min = MIN(min, r.timeNanoSec);
                max = MAX(max, r.timeNanoSec);
            }
            
            [avgRow appendFormat:@",%lld", avg];
            [minRow appendFormat:@",%lld", min];
            [maxRow appendFormat:@",%lld", max];
        }
        
        [self appendString:avgRow toStream:avgStream];
        [self appendString:minRow toStream:minStream];
        [self appendString:maxRow toStream:maxStream];
    }
    
    [avgStream close];
    [minStream close];
    [maxStream close];
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
    [str writeToFile:basePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)performTestWithIterations:(int)iterations forParser:(IJBParser *)p {
    self.results = [NSMutableDictionary dictionaryWithCapacity:13];
    for (NSString *name in payloads) {
        NSData *data = [self dataForPayload:name];
        for (int i = 0; i < iterations; i++) {
            [self performPerformanceTestForParser:p payload:name data:data];
        }
    }
}

- (void)performTestWithIterations:(int)iterations {
    self.results = [NSMutableDictionary dictionaryWithCapacity:13];
    for (NSString *name in payloads) {
        @autoreleasepool {
            for (IJBParser *p in self.parsers) {
                NSData *data = [self dataForPayload:name];
                for (int i = 0; i < iterations; i++) {
                    [self performPerformanceTestForParser:p payload:name data:data];
                }
            }
        }
    }
}

- (void)performCompareTest {
    NSInteger count = [self.parsers count];
    for (NSString *payload in payloads) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:count];
        for (IJBParser *p1 in self.parsers) {
            NSMutableDictionary *d = [NSMutableDictionary dictionaryWithCapacity:count];
            [dict setObject:d forKey:p1.name];
            
            @autoreleasepool {
                id object1 = [self objectOfTest:p1.selector payload:payload];
                for (IJBParser *p2 in self.parsers) {
                    NSAutoreleasePool *nestedPool = [[NSAutoreleasePool alloc] init];
                    id object2 = [self objectOfTest:p2.selector payload:payload];
                    BOOL equal = [self compareObject:object1 withObject:object2];
                    [d setObject:[NSNumber numberWithBool:equal] forKey:p2.name];
                    [nestedPool release];
                }
            }
        }
        [self printCompareReportForPayload:payload withDict:dict];
        [dict release];
    }
}

- (id)goJsonLiteWithPayload:(NSData *)data {
    return [JsonLiteAccumulator objectFromData:data withMaxDepth:512];
}

- (id)goJPjsonWithPayload:(NSData *)data {
    id obj = [JPJsonParser parseData:data options:0 error:NULL];
    return obj;
}

- (id)goSBJsonWithPayload:(NSData *)data {
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    parser.maxDepth = 512;
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
                                                            capacity:512] autorelease];
    [doc parse:data error:&error];
    return error == nil ? doc.root : nil;
}

- (id)goJSONSerialization:(NSData *)data {
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    return error == nil ? object : nil;
}

@end
