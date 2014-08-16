//
//  DateHelper.m
//  UberConf
//
//  Created by Ben Ellingson on 7/21/10.
//  Copyright 2010 No Fluff Just Stuff. All rights reserved.
//

#import "DateHelper.h"


@implementation DateHelper

+ (NSDate *) plus: (NSDate *) date minutes: (NSInteger) m {
    
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *offset = [[NSDateComponents alloc] init];
	[offset setMinute: m ];
	NSDate *result = [gregorian dateByAddingComponents: offset toDate: date options:0];	
	return result;
}


+ (NSDate *) plus: (NSDate *) date days: (NSInteger) d {

	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *offset = [[NSDateComponents alloc] init];
	[offset setDay:d];
	NSDate *result = [gregorian dateByAddingComponents: offset toDate: date options:0];	
	return result;
}

+ (NSDate *) convertToLocalTimeZone: (NSDate *) srcDate zone: (NSString *) srcZone {
	
	NSTimeZone* srcTimeZone = [NSTimeZone timeZoneWithAbbreviation: srcZone];
	NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
	
	NSInteger sourceGMTOffset = [srcTimeZone secondsFromGMTForDate:srcDate];
	NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:srcDate];
	NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
	
	NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:srcDate];
	
	return destinationDate;
}

+ (NSInteger) year: (NSDate *) date {
	NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		
	NSDateComponents *components = [cal components: NSYearCalendarUnit fromDate:date];	
	NSInteger y = [components year];
	return y;
}

+ (NSDate *) setHour: (NSDate *) date hour: (int) hour {
	
	NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setHour: hour];	
	
	return [cal dateByAddingComponents:components toDate:date  options:0];
}

+ (BOOL) isDate: (NSDate *) date before: (NSDate *) anotherDate {
    
    double time1 = [date timeIntervalSinceReferenceDate];
    double time2 = [anotherDate timeIntervalSinceReferenceDate];
    
    return time1 < time2;
}

+ (BOOL) isDate: (NSDate *) date after: (NSDate *) anotherDate {
    
    double time1 = [date timeIntervalSinceReferenceDate];
    double time2 = [anotherDate timeIntervalSinceReferenceDate];
    
    return time1 > time2;
}

+ (BOOL) isPast: (NSDate *) date {
    
    if ([date timeIntervalSinceNow] < 0) {
		return YES;		
	}
	return NO;
}

+ (BOOL) isToday: (NSDate *) date {
    
    return [DateHelper isSameDay: date day2: [NSDate date]];
}

+ (BOOL) isSameDay: (NSDate *) day1 day2: (NSDate *) day2 {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat: @"yyyy-MM-dd"];
    
    NSString *day1DS = [df stringFromDate: day1];
    
    NSString *day2DS = [df stringFromDate: day2];
    
    // NSLog(@"today: %@ : %@",todayDS,dateDS);
    
    return [day1DS isEqualToString: day2DS];
}


+ (NSString *) sinceNow: (NSDate *) date {
    
    if (date == nil)
        return nil;
    
    NSUInteger desiredComponents = NSYearCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *eu = [[NSCalendar currentCalendar] components:desiredComponents
                                                                         fromDate: date
                                                                           toDate:[NSDate date]
                                                                          options:0];
/*
    NSLog(@"second: %d",eu.second);
    NSLog(@"min: %d",eu.minute);
    NSLog(@"hour: %d",eu.hour);

    NSLog(@"day: %d",eu.day);    
    
    NSLog(@"year: %d",eu.year);
*/
    
    if(eu.year == 1)
        return @"1 year";
    
    if (eu.year)
        return [NSString stringWithFormat: @"%d years",eu.year];
    
    if (eu.day == 1)
        return @"1 day";
    
    if(eu.day)
        return [NSString stringWithFormat: @"%d days",eu.day];
    
    if (eu.hour == 1)
        return @"1 hour";
    
    if (eu.hour)
        return [NSString stringWithFormat: @"%d hours",eu.hour];
    
    if(eu.minute == 1)
        return @"1 minute";
    
    if (eu.minute)
        return [NSString stringWithFormat: @"%d minutes",eu.minute];

    if (eu.second == 1)
        return @"1 second";
    
    if (eu.second)
        return [NSString stringWithFormat: @"%d seconds",eu.second];
    
    return nil;

}

+ (int) daysBetween: (NSDate *) firstDay day2:(NSDate *) secondDay {
    
    NSLog(@"days between: %@ : %@",firstDay, secondDay);
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSDayCalendarUnit;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:secondDay
                                                  toDate:firstDay options:0];
    
    return [components day];
    
}

+ (int) daysFromNow: (NSDate *) date {
    
    return [DateHelper daysBetween: date day2: [NSDate date]];
    
}

+ (NSString *) durationString: (NSTimeInterval) duration {
    
    if(duration == 0)
        return @"00:00:00";
    
    int seconds = duration;
    
    int hour = 0;
    int min = 0;
    int sec = 0;
    
    if (seconds > 3600) {
        hour = seconds / 3600;
        seconds = seconds - (hour * 3600);
    }
    
    if (seconds > 60) {
        min = seconds / 60;
        seconds = seconds - (min * 60);
    }
    
    sec = seconds;
    
    return [NSString stringWithFormat: @"%@:%@:%@",
            [DateHelper formatTimeComponent: hour],
            [DateHelper formatTimeComponent: min],
            [DateHelper formatTimeComponent: sec]];
    
}

+ (NSString *) formatTimeComponent: (int) v {
    
    return v < 10 ? [NSString stringWithFormat: @"0%d",v] : [NSString stringWithFormat: @"%d",v];
    
}

+ (NSDate *) startOfDay: (NSDate *) date {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:NSWeekdayCalendarUnit fromDate: date];
    
    comps = [cal components:( NSMonthCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
    
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    
    return [cal dateFromComponents:comps];
}

+ (NSDate *) endOfDay: (NSDate *) date {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:NSWeekdayCalendarUnit fromDate: date];
    
    comps = [cal components:( NSMonthCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
    
    [comps setHour:23];
    [comps setMinute:59];
    [comps setSecond:59];
    
    return [cal dateFromComponents:comps];
}


@end
