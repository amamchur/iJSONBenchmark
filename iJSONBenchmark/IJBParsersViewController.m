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

#import "IJBParsersViewController.h"
#import "IJBTestBenchmark.h"

@interface IJBParsersViewController ()

@end

@implementation IJBParsersViewController

- (void)dealloc {
    self.benchmark = nil;
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.benchmark.parsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell autorelease];
    }
    IJBParser *p = [self.benchmark.parsers objectAtIndex:indexPath.row];
    cell.textLabel.text = p.name;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IJBParser *p = [self.benchmark.parsers objectAtIndex:indexPath.row];
    [self performSelector:self.selector withObject:p];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)singleIteration:(IJBParser *)parser {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self.benchmark performTestWithIterations:1 forParser:parser];
    [pool release];
}

@end
