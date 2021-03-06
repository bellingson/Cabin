//
//  TestSample.h
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestSample : NSObject

@property int ordinal;
@property BOOL correct;
@property double time;
@property BOOL show_dot_on_neutral_face;

- (NSDictionary *) asDictionary;

+ (TestSample *) fromDictionary: (NSDictionary *) di;

@end
