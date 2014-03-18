//
//  NSDictionary+JSONDate.m
//  NoFluff
//
//  Created by Ben Ellingson on 9/17/11.
//  Copyright 2011 Northstar New Media. All rights reserved.
//

#import "NSDictionary+JSON.h"

#import "StringHelper.h"

@implementation NSDictionary (JSON)

- (NSDate *) dateValueForKey: (id) key  dateFormatter: (NSDateFormatter *) df {
    
    NSString *value = [self objectForKey: key];
    
    if (value == nil)  return  nil;
    
    if ([value isKindOfClass: [NSString class]] == NO) return nil;
    
    if(df == nil) {
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat:JSON_DATE_FORMAT];    
    }
    
    NSDate *date = [df dateFromString: value];
    
    return date;
}

- (NSString *) stringForKey: (id) key {
    id value = [self objectForKey: key];
    if (value == nil) return nil;
    
    if ([value isKindOfClass: [NSString class]]) {
        return [StringHelper trim: (NSString *) value];
    }
    
    if ([value isKindOfClass: [NSNull class]]) {
        return nil;
    }
    
    if ([value isKindOfClass: [NSNumber class]]) {
        return [StringHelper trim: [NSString stringWithFormat: @"%@",value]];
    }
    
    return nil;
}

- (NSNumber *) numberForKey: (id) key {
    
    id value = [self objectForKey: key];
    if (value == nil) return nil;

    if ([value isKindOfClass: [NSNumber class]]) {
        return (NSNumber *) value;
    }
    
    return nil;
}

- (BOOL) boolForKey: (id) key {
    
    id value = [self objectForKey: key];
    if (value == nil)
        return NO;
    
    if ([value isKindOfClass: [NSNumber class]] == NO) 
        return NO;
    
    NSNumber *val = (NSNumber *) value;
    return  [val boolValue];    
}

- (NSNumber *) booleanForKey: (id) key {
    
    BOOL val = [self boolForKey: key];
    return [NSNumber numberWithBool: val];
}

- (NSString *) trueFalseStringForBooleanKey: (id) key {
    
    BOOL val = [self boolForKey: key];
    return  val == YES ? @"true" : @"false";
}

@end
