//
//  StringHelper.h
//  uber
//
//  Created by Ben Ellingson  - http://benellingson.blogspot.com/ on 4/7/10.
//  Copyright 2010 No Fluff Just Stuff. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StringHelper : NSObject {

}

+ (NSString *) trim: (NSString *) value;

+ (NSString *) stripHTML: (NSString *) html;

+ (NSNumber *) parseNumber: (NSString *) value;



@end
