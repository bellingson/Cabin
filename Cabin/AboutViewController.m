//
//  AboutViewController.m
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: kCFBundleVersionKey];
    
    self.versionLabel.text = [NSString stringWithFormat:@"Version: %@",appVersion];
    
    
    
}



- (IBAction)doneButtonTouched:(id)sender {

    //NSLog(@"remove from parent: %@",self.parentViewController);
    
    //[self removeFromParentViewController];
    [self dismissViewControllerAnimated: YES completion: nil];

}


@end
