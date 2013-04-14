//
//  IJViewController.m
//  iJSONBenchmark
//
//  Created by admin on 4/14/13.
//  Copyright (c) 2013 Andrii Mamchur. All rights reserved.
//

#import "IJBViewController.h"

#import "JsonLiteAccumulator.h"
#import "SBJson.h"
#import "JSONKit.h"

#import "mach/mach.h" 

@interface IJBTestBenchmarkResult : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) long timeNanoSec;

@end

@implementation IJBTestBenchmarkResult

- (void)dealloc {
    self.name = nil;
    [super dealloc];
}

@end

@interface IJBViewController ()

@property (nonatomic, copy) NSArray *payloads;
@property (nonatomic, retain) NSMutableDictionary *results;

@end

@implementation IJBViewController

@synthesize payloads;
@synthesize results;

- (IJBTestBenchmarkResult *)resultForTest:(SEL)selector payload:(NSString *)name {
    NSString *file = [[NSBundle mainBundle] pathForResource:name
                                                     ofType:@"json"
                                                inDirectory:@"payload"];
    NSData *data = [NSData dataWithContentsOfFile:file];    
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

- (void)performTestForSelector:(SEL)sel {
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

- (void)printExcelCSV {
    NSArray *methods = [[results allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *header = [NSMutableString string];
    for (NSString *name in methods) {
        [header appendFormat:@",%@", name];
    }
        
    NSMutableString *rows = [NSMutableString string];
    for (NSString *payload in payloads) {
        [rows appendFormat:@"\n%@", payload];
        
        for (NSString *name in methods) {
            NSMutableArray *array = [results objectForKey:name];
            NSInteger count = 0;
            long sum = 0;
            for (IJBTestBenchmarkResult *r in array) {
                if ([r.name isEqualToString:payload]) {
                    sum += r.timeNanoSec;
                    count++;
                }
            }
            
            [rows appendFormat:@",%ld", (long)(sum / count)];
        }
    }
    
    NSLog(@"\n%@%@", header, rows);
}

- (void)performTest {
    self.results = [NSMutableDictionary dictionaryWithCapacity:13];
    for (int i = 0; i < 10; i++) {
        NSLog(@"Iteration %d finished", i);
        [self performTestForSelector:@selector(goJsonLiteWithPayload:)];
        [self performTestForSelector:@selector(goSBJsonWithPayload:)];
        [self performTestForSelector:@selector(goJSONKitWithPayload:)];
    }    
}

- (void)viewDidLoad {
    self.payloads = [NSArray arrayWithObjects:
                     @"instruments",
                     @"nested",
                     @"svg_menu",
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
                     nil];
    
    // First iteration to create Objective-C methods' cache.
    self.results = [NSMutableDictionary dictionaryWithCapacity:13];
    [self performTestForSelector:@selector(goJsonLiteWithPayload:)];
    [self performTestForSelector:@selector(goSBJsonWithPayload:)];
    [self performTestForSelector:@selector(goJSONKitWithPayload:)];
    
    [self performTest];
    [self printExcelCSV];
    
//    for (NSString *key in results) {
//        NSArray *array = [results objectForKey:key];
//        long time = 0;
//        for (IJBTestBenchmarkResult *result in array) {
//            time += result.timeNanoSec;
//        }
//        
//        NSLog(@"%@, %ld", key, time);
//    }
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    self.payloads = nil;
    self.results = nil;
    [super dealloc];
}

@end
