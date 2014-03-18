//
//  TestViewController.m
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "TestViewController.h"

#import "TestCompleteViewController.h"

#include <stdlib.h>

#define TEST_SAMPLE_SIZE 4

@interface TestViewController ()

@end

@implementation TestViewController

@synthesize valueOfState, sampleCount, samples, currentSample, delegate, tap1, tap2;

- (void)viewDidLoad
{
    [super viewDidLoad];

    queue = dispatch_queue_create("cabin", NULL);
    sampleCount = 0;
    self.samples = [[NSMutableArray alloc] init];
    
    CGRect frame = self.view.frame;
    
   // NSLog(@"size: %f : %f",frame.size.width, frame.size.height);
    
    CGRect w1fame = self.wrapperView1.frame;
    w1fame.origin.y = 100;
    self.wrapperView1.frame = w1fame;
    
    CGRect w2frame = self.wrapperView2.frame;
    w2frame.origin.y = frame.size.height - 220;
    self.wrapperView2.frame = w2frame;
    
    [self startSequence];
    
    self.tap1 = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(doTap1)];
    tap1.numberOfTapsRequired = 1;
    
    [self.wrapperView1 addGestureRecognizer: tap1];
    
    self.tap2 = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(doTap2)];
    tap2.numberOfTapsRequired = 1;
    
    [self.wrapperView2 addGestureRecognizer: tap2];
    
    [self disableTaps];
    
}

- (void) doTap1 {
    
    [self checkAnswer: 0];
    
}

- (void) doTap2 {
    
    [self checkAnswer: 1];
    
}

- (void) checkAnswer: (int) selection {
    
    double sampleStopTime = [NSDate timeIntervalSinceReferenceDate];
    double time = sampleStopTime - self.sampleStartTime;
    
    //NSLog(@"time: %f",time);
    
    [self disableTaps];
    
    [self hideDotButtons];
    
    UILabel *feedback = selection == 0 ? self.word1 : self.word2;
    
    TestSample *sample = [[TestSample alloc] init];
    sample.ordinal = samples.count;
    sample.time = sampleStopTime - self.sampleStartTime;
    [samples addObject: sample];
    
    if (selection == valueOfState) {
        feedback.text = @"Correct";
        sample.correct = YES;
    } else {
        feedback.text = @"Nope";
        sample.correct = NO;
    }
    
    feedback.hidden = NO;
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if(samples.count >= TEST_SAMPLE_SIZE) {
            [self.delegate testComplete: samples];
        } else {
            [self startSequence];
        }
    });
    
    
}


- (void) startSequence {
    
    self.word1.text = @"Word 1";
    self.word2.text = @"Word 2";
    
    [self hideDotButtons];
    [self hideWords];
    [self showCross];
    
    sampleCount++;
    
    self.valueOfState = arc4random() % 100 > 50 ? 1 : 0;
    
//    NSLog(@"random: %d : %d",valueOfState, sampleCount);
    
    self.sampleStartTime = [NSDate timeIntervalSinceReferenceDate];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self sequence2];
    });
    
    
}

- (void) sequence2 {

    [self hideCross];    
    [self showWords];

    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self sequence3];
    });
    
}

- (void) sequence3 {
    
    [self hideWords];
    
    if (valueOfState == 0) {
        self.dotButton1.hidden = NO;
    } else {
        self.dotButton2.hidden = NO;
    }
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self sequence4];
    });

    
}

- (void) sequence4 {
    
    [self hideDotButtons];
    
    [self enableTaps];
    
    
}


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

- (void) enableTaps {
 
    self.tap1.enabled = YES;
    self.tap2.enabled = YES;
    
}

- (void) disableTaps {
    
    self.tap1.enabled = NO;
    self.tap2.enabled = NO;
    
}


@end
