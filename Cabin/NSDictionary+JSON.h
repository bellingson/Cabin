//
//  NSDictionary+JSONDate.h
//  NoFluff
//
//  Created by Ben Ellingson on 9/17/11.
//  Copyright 2011 Northstar New Media. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (JSON)

- (NSDate *) dateValueForKey: (id) key dateFormatter: (NSDateFormatter *) df;

- (NSString *) stringForKey: (id) key;

- (NSNumber *) numberForKey: (id) key;

- (BOOL) boolForKey: (id) key;

- (NSNumber *) booleanForKey: (id) key;

- (NSString *) trueFalseStringForBooleanKey: (id) key;

@end
