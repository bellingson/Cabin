//
//  TestCompleteViewController.m
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "TestCompleteViewController.h"

#import "TestResult.h"
#import "DateHelper.h"

#define TESTS_PER_WEEK 6
#define TOTAL_WEEKS 6

@interface TestCompleteViewController ()

@end

@implementation TestCompleteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
    [self showResults];
    
    
}

#pragma mark - results

- (void) showResults {
    
    NSString *accurate = [NSString stringWithFormat: @"%d",self.result.percentAccurate];
    NSString *avgTime = [NSString stringWithFormat: @"%.2f",self.result.averageResponseTime];
    
    self.tests = [TestResult loadResultsFromFile];
    NSArray *testThisWeek = [self testsThisWeek];
    int testThisWeekCount = (int)testThisWeek.count;
    int testToCompleteCount = TESTS_PER_WEEK - testThisWeekCount;
    if(testToCompleteCount < 0)
        testToCompleteCount = 0;
    
    int currentWeek = [self findCurrentWeekNumber];
    
   // NSLog(@"total test: %d \ttests this week: %d",self.tests.count, testThisWeekCount);
    
    self.sessionCountLabel.text = [NSString stringWithFormat:@"Congratulations! You have completed %d out of %d sessions for this week!",testThisWeekCount,TESTS_PER_WEEK];
    
    self.testResultLabel.text = [NSString stringWithFormat: @"You responded with %@ %% accuracy and had an average response time of %@ seconds.",accurate, avgTime];
    
    self.sessionsToCompleteLabel.text = [NSString stringWithFormat:@"You have %d sessions to complete this week.",testToCompleteCount];
    
    self.weeksToCompleteLabel.text = [NSString stringWithFormat: @"You are currently on week %d of %d weeks of training.", currentWeek, TOTAL_WEEKS];
    

}

- (NSArray *) testsThisWeek {
    
    NSMutableArray *r = [[NSMutableArray alloc] init];
    
    NSDate *firstDay = [self startOfWeek];
    NSDate *lastDay = [self endOfWeek];
    
    
//    NSLog(@"first: %@ \tlast: %@",firstDay, lastDay);
    
    for (TestResult *tr in self.tests) {

        if ([DateHelper isDate: tr.time after: firstDay] &&
            [DateHelper isDate: tr.time before: lastDay]) {
            [r addObject: tr];
        }
    }
    
    return r;
}

- (NSDate *) startOfWeek {
    
    NSDate *now = [NSDate date];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:NSWeekdayCalendarUnit fromDate: now];
    int weekday = (int)[comps weekday];
    
    int d = weekday * -1 + 1;
    
    NSDateComponents *offset = [[NSDateComponents alloc] init];
	[offset setDay:d];
    
	NSDate *r = [cal dateByAddingComponents: offset toDate: now options:0];
    return [DateHelper startOfDay:r];
    
}

- (NSDate *) endOfWeek {
    
    NSDate *now = [NSDate date];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:NSWeekdayCalendarUnit fromDate: now];
    int weekday = (int)[comps weekday];
    
    int d = 7 - weekday;
    
    NSDateComponents *offset = [[NSDateComponents alloc] init];
	[offset setDay:d];
    
	NSDate *r = [cal dateByAddingComponents: offset toDate: now options:0];
    return [DateHelper endOfDay:r];
}

- (int) findCurrentWeekNumber {
    
    NSDate *firstDay;
    for(TestResult *tr in self.tests) {
        if (firstDay == nil || [DateHelper isDate: tr.time before: firstDay]) {
            firstDay = tr.time;
        }
    }
    
    NSDate *now = [NSDate date];
    
    NSTimeInterval interval = [now timeIntervalSinceDate:firstDay];
    
    int days = (interval / (60 * 60 *24));
   
    int weekNumber = days / 7 + 1;
        
    return weekNumber;
}

#pragma mark -

- (IBAction)doneButtonTouched:(id)sender {
    
    [self dismissViewControllerAnimated: YES completion: nil];
    
}

- (IBAction)contactButtonTouched:(id)sender {
}

- (IBAction)trainAgainButtonTouched:(id)sender {
    
    [self.delegate testAgain];
    
}

- (BOOL)shouldAutorotate {
    return NO;
}

-  (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    //NSLog(@"will rotate: %d",toInterfaceOrientation);
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    //NSLog(@"did rotate: %d",fromInterfaceOrientation);
    
}



@end
