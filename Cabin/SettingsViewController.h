//
//  SettingsViewController.h
//  Cabin
//
//  Created by Ben Ellingson on 4/18/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataService.h"

@interface SettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *patientNumberText;

@property (strong, nonatomic) UIViewController *delegate;

@property (strong, nonatomic) DataService *dataService;

- (IBAction)updateTouched:(id)sender;

@end
