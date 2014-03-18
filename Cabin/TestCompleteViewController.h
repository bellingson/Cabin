//
//  TestCompleteViewController.h
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TestResult.h"
#import "DataService.h"

@interface TestCompleteViewController : UIViewController

@property (strong, nonatomic) TestResult *result;


@property (strong, nonatomic) IBOutlet UILabel *sessionCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *testResultLabel;

@property (strong, nonatomic) IBOutlet UILabel *sessionsToCompleteLabel;

@property (strong, nonatomic) IBOutlet UILabel *weeksToCompleteLabel;




- (IBAction)doneButtonTouched:(id)sender;

- (IBAction)contactButtonTouched:(id)sender;

- (IBAction)trainAgainButtonTouched:(id)sender;

@end
