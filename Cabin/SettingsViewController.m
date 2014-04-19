//
//  SettingsViewController.m
//  Cabin
//
//  Created by Ben Ellingson on 4/18/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "SettingsViewController.h"
#import "StringHelper.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)updateTouched:(id)sender {
    
    if ([self validate] == NO)
        return;
    
     NSNumber *patientNumber = [NSNumber numberWithInt: [self.patientNumberText.text integerValue]];

    [self.dataService writePatientNumber: patientNumber];
    
    [self.delegate dismissViewControllerAnimated: YES completion: nil];
    
}

- (BOOL) validate {
    
    if ([StringHelper trim:self.patientNumberText.text] == nil ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Patient # Required" message:@"Enter a patient number" delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [alert show];
        return false;
    }
    
    return true;
}


@end
