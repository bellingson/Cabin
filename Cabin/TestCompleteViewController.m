//
//  TestCompleteViewController.m
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "TestCompleteViewController.h"

@interface TestCompleteViewController ()

@end

@implementation TestCompleteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
    [self showResults];
    
    
}

- (void) showResults {
    
    NSString *accurate = [NSString stringWithFormat: @"%d",self.result.percentAccurate];
    NSString *avgTime = [NSString stringWithFormat: @"%.2f",self.result.averageResponseTime];
    
    self.testResultLabel.text = [NSString stringWithFormat: @"You responded with %@ %% accuracy and had an average response time of %@ seconds.",accurate, avgTime];
    
    
    
}


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




@end
