//
//  TestViewController.m
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "TestViewController.h"

#import "TestCompleteViewController.h"
#import "DataService.h"

#include <stdlib.h>

#define TEST_SAMPLE_SIZE 10
#define TEST_SAMPLE_SIZE 200

@interface TestViewController ()

@end

@implementation TestViewController

@synthesize valueOfNeutralAndFearState, valueOfDot, sampleCount, samples, currentSample, delegate, tap1, tap2, fearFaces, neutralFaces, currentImageIndex, showDotOnNeutralFace;

@synthesize image1, image2;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initFaces];
    
    queue = dispatch_queue_create("cabin", NULL);
    sampleCount = 0;
    self.samples = [[NSMutableArray alloc] init];
    
/*
    CGRect frame = self.wrapperView.frame;
    frame.size.height = 480;
    self.wrapperView.frame = frame;
    
   // NSLog(@"size: %f : %f",frame.size.width, frame.size.height);
    
    CGRect w1fame = self.wrapperView1.frame;
    //w1fame.origin.y = 100;
    w1fame.origin.y = 20;
    self.wrapperView1.frame = w1fame;
    
    CGRect w2frame = self.wrapperView2.frame;
    //w2frame.origin.y = frame.size.height - 220;
    //w2frame.origin.y = frame.size.height - 270;
    w2frame.origin.y = frame.size.height - 220;
    self.wrapperView2.frame = w2frame;
    
    NSLog(@"w1: %f : %f",w2frame.origin.x, w2frame.origin.y);
*/
    
    [self step_1_reset_display];
    
    self.tap1 = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(doTap1)];
    tap1.numberOfTapsRequired = 1;
    
    [self.wrapperView1 addGestureRecognizer: tap1];
    
    self.tap2 = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(doTap2)];
    tap2.numberOfTapsRequired = 1;
    
    [self.wrapperView2 addGestureRecognizer: tap2];
    
    [self disableTaps];
    
}

- (void) initFaces {
    
    self.fearFaces = [NSArray arrayWithObjects: @"207Fcrop.jpg",
                      @"208Fcrop.jpg",
                      @"213Fcrop.jpg",
                      @"217Fcrop.jpg",
                      @"AF01AFS.jpg",
                      @"AF13AFS.jpg",
                      @"AF14AFS.jpg",
                      @"AF19AFS.jpg",
                      @"AF22AFS.jpg",
                      @"AF24AFS.jpg",
                      @"AF30AFS.jpg",
                      @"AF32AFS.jpg",
                      @"AM09AFS.jpg",
                      @"AM10AFS.jpg",
                      @"AM17AFS.jpg",
                      @"AM22AFS.jpg",
                      @"AM23AFS.jpg",
                      @"AM31AFS.jpg",
                      @"AM34AFS.jpg",
                      @"AM35AFS.jpg", nil];
    
    self.neutralFaces = [NSArray arrayWithObjects:@"207Ncrop.jpg",
                         @"208Ncrop.jpg",
                         @"213Ncrop.jpg",
                         @"217Ncrop.jpg",
                         @"AF01NES.jpg",
                         @"AF13NES.jpg",
                         @"AF14NES.jpg",
                         @"AF19NES.jpg",
                         @"AF22NES.jpg",
                         @"AF24NES.jpg",
                         @"AF30NES.jpg",
                         @"AF32NES.jpg",
                         @"AM09NES.jpg",
                         @"AM10NES.jpg",
                         @"AM17NES.jpg",
                         @"AM22NES.jpg",
                         @"AM23NES.jpg",
                         @"AM31NES.jpg",
                         @"AM34NES.jpg",
                         @"AM35NES.jpg", nil];
    
    // if even - randomize dot between neutral and fear
    // if odd - show dot on neutral face
    int patientNumber = [[[DataService instance] patientNumber] intValue];
    self.showDotOnNeutralFace = patientNumber % 2 != 0;
    // NSLog(@"show dot on neutral: %d : %d", patientNumber, self.  );
    
    
    
    
}

#pragma mark - handle response

- (void) doTap1 {
    
    [self checkAnswer: 0];
    
}

- (void) doTap2 {
    
    [self checkAnswer: 1];
    
}

- (void) checkAnswer: (int) selection {
    
    double sampleStopTime = [NSDate timeIntervalSinceReferenceDate];
    //double time = sampleStopTime - self.sampleStartTime;
    
    //NSLog(@"time: %f",time);
    
    [self disableTaps];
    
    [self hideDotButtons];
    
    UILabel *feedback = selection == 0 ? self.word1 : self.word2;
    
    TestSample *sample = [[TestSample alloc] init];
    sample.ordinal = (int) samples.count;
    sample.time = sampleStopTime - self.sampleStartTime;
    sample.show_dot_on_neutral_face = self.valueOfNeutralAndFearState == valueOfDot;
    [samples addObject: sample];
    
    
    //NSLog(@"check answer: %d : %d : %d : %d",selection, valueOfDot, valueOfNeutralAndFearState, sample.show_dot_on_neutral_face);
    
    //if (selection == valueOfNeutralAndFearState) {
    if (selection == valueOfDot) {
        feedback.text = @"Correct";
        feedback.textColor = [UIColor greenColor];
        sample.correct = YES;
    } else {
        feedback.text = @"Incorrect";
        feedback.textColor = [UIColor redColor];
        sample.correct = NO;
    }
    
    feedback.hidden = NO;
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if(samples.count >= TEST_SAMPLE_SIZE) {
            [self.delegate testComplete: samples];
        } else {
            [self step_1_reset_display];
        }
    });
    
    
}

#pragma mark - steps

- (void) step_1_reset_display {
    
    self.currentImageIndex = [self selectRandomImageIndex];
    
    //NSLog(@"cimg: %d",self.currentImageIndex);

    UIImage *neutralImage = [UIImage imageNamed: [neutralFaces objectAtIndex: self.currentImageIndex]];
    UIImage *fearImage = [UIImage imageNamed: [fearFaces objectAtIndex: self.currentImageIndex]];
    
    
    //self.word1.text = @"Word 1";
    //self.word2.text = @"Word 2";
    
    [self hideDotButtons];
    [self hideWords];
    [self hideImages];
    [self showCross];
    
    sampleCount++;
    
    self.valueOfNeutralAndFearState = arc4random() % 100 > 50 ? 1 : 0;
    
   // NSLog(@"random: %d : %d",valueOfNeutralAndFearState, sampleCount);
    
    self.image1.image = valueOfNeutralAndFearState == 0 ? neutralImage : fearImage;
    self.image2.image = valueOfNeutralAndFearState == 0 ? fearImage : neutralImage;
    
    
    //self.sampleStartTime = [NSDate timeIntervalSinceReferenceDate];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self step_2_show_images];
    });
    
    
}

- (int) selectRandomImageIndex {
    
    float r = arc4random() % 20;
    
//    NSLog(@"random: %f", r);
    
    return (int) r;
    
}

#pragma mark - show images

- (void) step_2_show_images {

    //[self hideCross];
    //[self showWords];
    [self showImages];

    
    //double delayInSeconds = 10.0;
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
       [self step_3_show_dots];
    });
    
}

#pragma mark - show dots

- (void) step_3_show_dots {
    
   // [self hideWords];
    [self hideImages];
    
    self.sampleStartTime = [NSDate timeIntervalSinceReferenceDate];
    
    [self showDot];
    [self enableTaps];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self step_4_hide_dots];
    });

    
}

- (void) showDot {
    
    if (showDotOnNeutralFace) {
        [self do_showDotOnNeutralFace];
    } else {
        [self do_showDotOnRandomFace];
    }
    
    

}

- (void) do_showDotOnNeutralFace {
    
    self.valueOfDot = valueOfNeutralAndFearState;
    if (valueOfNeutralAndFearState == 0) {
        self.dotButton1.hidden = NO;
    } else {
        self.dotButton2.hidden = NO;
    }
    
}

- (void) do_showDotOnRandomFace {
    
    self.valueOfDot = arc4random() % 100 > 50 ? 1 : 0;
    if (valueOfDot == 0) {
        self.dotButton1.hidden = NO;
    } else {
        self.dotButton2.hidden = NO;
    }
    
}


#pragma mark - hide dots

- (void) step_4_hide_dots {
    
    [self hideDotButtons];
    
    //[self enableTaps];
    
    
}

#pragma mark - show / hide


- (void) showCross {
    self.crossLabel.hidden = NO;
}

- (void) hideCross {
    self.crossLabel.hidden = YES;
}

- (void) hideDotButtons {
    
    self.dotButton1.hidden = YES;
    self.dotButton2.hidden = YES;
    
}

- (void) showDotButtons {
    
    self.dotButton1.hidden = NO;
    self.dotButton2.hidden = NO;
    
}

- (void) showWords {
    self.word1.hidden = NO;
    self.word2.hidden = NO;
}

- (void) hideWords {
    self.word1.hidden = YES;
    self.word2.hidden = YES;
}

- (void) showImages {
    self.image1.hidden = NO;
    self.image2.hidden = NO;
}

- (void) hideImages {
    self.image1.hidden = YES;
    self.image2.hidden = YES;
}


- (void) enableTaps {
 
    self.tap1.enabled = YES;
    self.tap2.enabled = YES;
    
}

- (void) disableTaps {
    
    self.tap1.enabled = NO;
    self.tap2.enabled = NO;
    
}


- (BOOL)shouldAutorotate {
   // NSLog(@"should autorotate");
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}




@end
