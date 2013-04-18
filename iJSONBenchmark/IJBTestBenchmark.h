//
//  IJBTestBenchmark.h
//  iJSONBenchmark
//
//  Created by admin on 4/18/13.
//  Copyright (c) 2013 Andrii Mamchur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IJBParser : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) SEL selector;

@end

@interface IJBTestBenchmarkResult : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) long timeNanoSec;

@end

@interface IJBTestBenchmark : NSObject

@property (nonatomic, retain) NSCache *payloadCache;
@property (nonatomic, copy) NSArray *payloads;
@property (nonatomic, copy) NSArray *parsers;
@property (nonatomic, retain) NSMutableDictionary *results;

- (void)performTestWithIterations:(int)iterations;
- (void)performTestWithIterations:(int)iterations forParser:(IJBParser *)p;
- (void)performCompareTest;

- (void)printNanoSecCSV;

@end
