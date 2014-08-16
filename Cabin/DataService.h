//
//  DataService.h
//  Cabin
//
//  Created by Ben Ellingson on 2/27/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TestResult.h"

@interface DataService : NSObject

@property (strong, nonatomic) NSNumber *patientNumber;
@property (strong, nonatomic) NSDate *startDate;

@property (strong, nonatomic) NSDateFormatter *df;

+ (DataService *) instance;

- (BOOL) upload;

- (void) writePatientNumber: (NSNumber *) pNumber;

- (int) countOfTestsToday;

- (BOOL) canTakeTest;

@end
