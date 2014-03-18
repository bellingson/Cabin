//
//  TestViewDelegate.h
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TestViewDelegate <NSObject>

- (void) testComplete: (NSArray *) samples;

@end
