//
//  ResultListControllerViewController.h
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataService.h"

@interface ResultListController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSDateFormatter *df;
    
}

@property (strong, nonatomic) NSArray *tests;
@property (strong, nonatomic) DataService *dataService;

@property (strong, nonatomic) IBOutlet UITableView *table;

- (IBAction)doneButtonTouched:(id)sender;

@end
