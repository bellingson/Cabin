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

+ (DataService *) instance;

- (BOOL) upload;

@end
