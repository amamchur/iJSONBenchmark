//
//  IJBAllocationParserViewController.m
//  iJSONBenchmark
//
//  Created by admin on 4/18/13.
//  Copyright (c) 2013 Andrii Mamchur. All rights reserved.
//

#import "IJBParsersViewController.h"
#import "IJBTestBenchmark.h"

@interface IJBParsersViewController ()

@end

@implementation IJBParsersViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
