//
//  TestSample.m
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "TestSample.h"

#import "NSDictionary+JSON.h"

@implementation TestSample


- (NSDictionary *)asDictionary {
    
    return [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt: self.ordinal], @"ordinal",
                                                       [NSNumber numberWithInt: self.correct], @"correct",
                                                       [NSNumber numberWithDouble: self.time], @"time",
                                                        nil];
    
}

+ (TestSample *) fromDictionary: (NSDictionary *) di {

    TestSample *sample = [[TestSample alloc] init];
    sample.ordinal = [[di numberForKey: @"ordinal"] intValue];
    sample.correct = [[di numberForKey: @"correct"] boolValue];
    sample.time = [[di numberForKey: @"time"] doubleValue];
    
    //NSLog(@"correct: %@ : %d",[di numberForKey: @"correct"],sample.correct);
    
    return sample;
}


@end
