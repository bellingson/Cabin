//
//  TestViewController.h
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TestSample.h"

#import "TestViewDelegate.h"

@interface TestViewController : UIViewController  {
    
    dispatch_queue_t queue;
    
}

@property (strong, nonatomic) id<TestViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *word1;

@property (strong, nonatomic) IBOutlet UILabel *word2;

@property (strong, nonatomic) IBOutlet UIImageView *image1;
@property (strong, nonatomic) IBOutlet UIImageView *image2;


@property (strong, nonatomic) IBOutlet UIImageView *dotButton1;
@property (strong, nonatomic) IBOutlet UIImageView *dotButton2;

@property (strong, nonatomic) UITapGestureRecognizer *tap1;
@property (strong, nonatomic) UITapGestureRecognizer *tap2;

@property (strong, nonatomic) IBOutlet UIView *wrapperView1;
@property (strong, nonatomic) IBOutlet UIView *wrapperView2;

@property (strong, nonatomic) IBOutlet UIImageView *crossLabel;

@property (strong, nonatomic) NSMutableArray *samples;
@property (strong, nonatomic) TestSample *currentSample;

@property (strong, nonatomic) NSArray *fearFaces;
@property (strong, nonatomic) NSArray *neutralFaces;
@property int currentImageIndex;

@property int valueOfState;
@property int sampleCount;

@property double sampleStartTime;



@end
