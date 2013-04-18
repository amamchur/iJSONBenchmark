//
//  IJBAllocationParserViewController.h
//  iJSONBenchmark
//
//  Created by admin on 4/18/13.
//  Copyright (c) 2013 Andrii Mamchur. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IJBTestBenchmark;
@class IJBParser;

@interface IJBParsersViewController : UITableViewController

@property (nonatomic, retain) IJBTestBenchmark *benchmark;
@property (nonatomic, assign) SEL selector;

- (void)singleIteration:(IJBParser *)parser;

@end
