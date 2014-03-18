//
//  DataService.m
//  Cabin
//
//  Created by Ben Ellingson on 2/27/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "DataService.h"

@implementation DataService

static DataService *svc;

+ (DataService *) instance {
    
    if (svc == nil) {
        svc = [[DataService alloc] init];
    }
    return svc;
}

- (BOOL) upload {
    
    NSArray *results = [TestResult resultsToSync];
    if (results.count == 0) {
        NSLog(@"no results to sync");
        return YES;
    }
    
    NSLog(@"results to sync: %d",results.count);
    
    
    return YES;
}

@end
