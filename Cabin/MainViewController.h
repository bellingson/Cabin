//
//  ViewController.h
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TestViewDelegate.h"
#import "TestViewController.h"

#import "TestCompleteViewController.h"
#import "SettingsViewController.h"

#import "DataService.h"

@interface MainViewController : UIViewController <TestViewDelegate>

@property (strong, nonatomic) DataService *dataService;


@end
