//
//  ResultListControllerViewController.m
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "ResultListController.h"

#import "TestResult.h"

@interface ResultListController ()



@end

@implementation ResultListController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataService = [DataService instance];
	
    df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"EEE MMM d h:mm aa";
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
    self.tests = [TestResult loadResultsFromFile];
    
    [self.dataService upload];
    
//    NSLog(@"tests: %d",self.tests.count);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell" forIndexPath:indexPath];

    TestResult *result = (TestResult *) [self.tests objectAtIndex: indexPath.row];
    
    NSString *accurate = [NSString stringWithFormat: @"%d %%", result.percentAccurate];
    NSString *avgTime = [NSString stringWithFormat: @"%.2f sec", result.averageResponseTime];

    
    UILabel *dateLabel = (UILabel *) [cell viewWithTag: 1];
    UILabel *accuracyLabel = (UILabel *) [cell viewWithTag: 2];
    UILabel *avgTimeLabel = (UILabel *) [cell viewWithTag: 3];
    
    dateLabel.text = [df stringFromDate: result.time];
    accuracyLabel.text = accurate;
    avgTimeLabel.text = avgTime;
    
    
    
    return cell;
}


- (IBAction)doneButtonTouched:(id)sender {
    
    [self dismissViewControllerAnimated: YES completion: nil];
    
}
@end
