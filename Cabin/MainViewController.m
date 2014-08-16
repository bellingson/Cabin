//
//  ViewController.m
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.dataService = [DataService instance];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.dataService upload];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    [self displaySettingsViewIfNecessary];
}

- (void) displaySettingsViewIfNecessary {
    
    
    if (self.dataService.patientNumber == nil) {
        SettingsViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier: @"settings"];
        ctrl.delegate = self;
        ctrl.dataService = self.dataService;
        
        [self presentViewController: ctrl animated: YES completion: nil];        
    } else {
        NSLog(@"patient number is: %@",self.dataService.patientNumber);
    }

    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //NSLog(@"prep: %@ : %d",segue.identifier,[self.dataService canTakeTest]);
    
    if ([segue.identifier isEqualToString: @"startTest"]) {
        
        TestViewController *child = (TestViewController *)[segue destinationViewController];
        child.delegate = self;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString: @"startTest"]) {
            return [self.dataService canTakeTest];
    }
    
    return YES;
}





- (void)testComplete:(NSArray *)samples {

    NSLog(@"test complete with: %lu samples",(unsigned long)samples.count);
    
    TestResult *result = [[TestResult alloc] initWithSamples: samples];
    
    TestCompleteViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier: @"testComplete"];
    ctrl.result = result;
    ctrl.delegate = self;
    
    [self dismissViewControllerAnimated: NO  completion: ^{
        [self presentViewController: ctrl animated: NO completion: nil];
    }];
    

}

- (void) testAgain {
    
    if ([self.dataService canTakeTest] == NO)
        return;
    
    [self dismissViewControllerAnimated: NO completion: ^{
        [self performSegueWithIdentifier: @"startTest" sender: self];
    }];
    
}



@end
