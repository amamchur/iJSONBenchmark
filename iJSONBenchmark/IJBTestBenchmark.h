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

#import <Foundation/Foundation.h>

@interface IJBParser : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) SEL selector;

@end

@interface IJBTestBenchmarkResult : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) long long timeNanoSec;

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
- (void)printNanoSecCVSPerParser;

@end
