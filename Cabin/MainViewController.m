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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: @"startTest"]) {
        TestViewController *child = (TestViewController *)[segue destinationViewController];
        child.delegate = self;
    }
    

    
}

- (void)testComplete:(NSArray *)samples {

    NSLog(@"test complete with: %d samples",samples.count);
    
    TestResult *result = [[TestResult alloc] initWithSamples: samples];
    
    TestCompleteViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier: @"testComplete"];
    ctrl.result = result;
    
    [self dismissViewControllerAnimated: NO  completion: ^{
        [self presentViewController: ctrl animated: NO completion: nil];
    }];
    

}


@end
