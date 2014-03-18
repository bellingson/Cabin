//
//  TestResult.h
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TestSample.h"

@interface TestResult : NSObject

@property (strong, nonatomic) NSArray *samples;

@property (strong, nonatomic) NSDate *time;

@property int countCorrect;
@property int countWrong;
@property double totalResponseTime;

@property int percentAccurate;
@property double averageResponseTime;
@property (strong, nonatomic) NSString *averageResponseTimeString;

@property (strong, nonatomic) NSString *filePath;

- (id) initWithSamples: (NSArray *) aSamples;

+ (NSArray *) loadResultsFromFile;

+ (NSArray *) resultsToSync;

@end
