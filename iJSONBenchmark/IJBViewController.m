//
//  IJViewController.m
//  iJSONBenchmark
//
//  Created by admin on 4/14/13.
//  Copyright (c) 2013 Andrii Mamchur. All rights reserved.
//

#import "IJBViewController.h"
#import "IJBTestBenchmark.h"
#import "IJBParsersViewController.h"

#import "JsonLiteAccumulator.h"
#import "SBJson.h"
#import "JSONKit.h"
#import "YAJL.h"

#import "mach/mach.h" 

@interface IJBViewController()

@property (nonatomic, retain) IJBTestBenchmark *benchmark;

@end

@implementation IJBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.benchmark = [[[IJBTestBenchmark alloc] init] autorelease];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    self.benchmark = nil;
    [super dealloc];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (IBAction)nonaSecTest:(id)sender {
    [self.benchmark performTestWithIterations:10];
    [self.benchmark printNanoSecCSV];
}

- (IBAction)compareTest:(id)sender {
    [self.benchmark performCompareTest];
}

- (IBAction)testAllocation:(id)sender {
    IJBParsersViewController *vc = [[IJBParsersViewController alloc] initWithStyle:UITableViewStylePlain];
    vc.benchmark = self.benchmark;
    vc.selector = @selector(singleIteration:);
    [self.navigationController pushViewController:[vc autorelease] animated:YES];
}

@end
