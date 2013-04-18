//
//  IJBAllocationParserViewController.m
//  iJSONBenchmark
//
//  Created by admin on 4/18/13.
//  Copyright (c) 2013 Andrii Mamchur. All rights reserved.
//

#import "IJBAllocationParserViewController.h"
#import "IJBTestBenchmark.h"

@interface IJBAllocationParserViewController ()

@end

@implementation IJBAllocationParserViewController

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
    [self.benchmark performTestWithIterations:1 forParser:p];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
