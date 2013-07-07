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

#import "IJBViewController.h"
#import "IJBTestBenchmark.h"
#import "IJBParsersViewController.h"

@interface IJBViewController()

@property (nonatomic, retain) IJBTestBenchmark *benchmark;

@end

@implementation IJBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.benchmark = [[[IJBTestBenchmark alloc] init] autorelease];
}

- (void)dealloc {
    self.benchmark = nil;
    [super dealloc];
}

- (IBAction)nonaSecTest:(id)sender {
    [self.benchmark performTestWithIterations:1];
    [self.benchmark performTestWithIterations:50];
    [self.benchmark printNanoSecCSV];
    [self.benchmark printNanoSecCVSPerParser];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Complete!"
                                                    message:@"See results in Documents directory. Use Organizer for download."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (IBAction)compareTest:(id)sender {
    [self.benchmark performCompareTest];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Complete!"
                                                    message:@"See results in Documents directory. Use Organizer for download."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (IBAction)testAllocation:(id)sender {
    IJBParsersViewController *vc = [[IJBParsersViewController alloc] initWithStyle:UITableViewStylePlain];
    vc.benchmark = self.benchmark;
    vc.selector = @selector(singleIteration:);
    [self.navigationController pushViewController:[vc autorelease] animated:YES];
}

@end
