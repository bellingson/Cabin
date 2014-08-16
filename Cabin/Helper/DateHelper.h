//
//  DateHelper.h
//  UberConf
//
//  Created by Ben Ellingson on 7/21/10.
//  Copyright 2010 No Fluff Just Stuff. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DateHelper : NSObject {

}

+ (NSDate *) plus: (NSDate *) date minutes: (NSInteger) m;

+ (NSDate *) plus: (NSDate *) date days: (NSInteger) d;

+ (NSDate *) convertToLocalTimeZone: (NSDate *) srcDate zone: (NSString *) srcZone;

+ (NSInteger) year: (NSDate *) date;

+ (NSDate *) setHour: (NSDate *) date hour: (int) hour;

+ (BOOL) isDate: (NSDate *) date before: (NSDate *) anotherDate;

+ (BOOL) isDate: (NSDate *) date after: (NSDate *) anotherDate;

+ (BOOL) isPast: (NSDate *) date;

+ (BOOL) isToday: (NSDate *) date;

+ (BOOL) isSameDay: (NSDate *) day1 day2: (NSDate *) day2;

+ (NSString *) sinceNow: (NSDate *) date;

+ (int) daysBetween: (NSDate *) firstDay day2: (NSDate *) secondDay;

+ (int) daysFromNow: (NSDate *) date;

+ (NSString *) durationString: (NSTimeInterval) duration;

+ (NSString *) formatTimeComponent: (int) v;

+ (NSDate *) startOfDay: (NSDate *) date;
+ (NSDate *) endOfDay: (NSDate *) date;


@end
