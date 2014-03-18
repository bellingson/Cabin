//
//  StringHelper.m
//  uber
//
//  Created by Ben Ellingson  - http://benellingson.blogspot.com/ on 4/7/10.
//  Copyright 2010 No Fluff Just Stuff. All rights reserved.
//

#import "StringHelper.h"




@implementation StringHelper



+ (NSString *) trim: (NSString *) value {
	
	if(value == nil || [value isKindOfClass:[NSNull class]]) return nil;
	
    value = [value stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
	if(value == nil || value.length == 0) return nil;    
    
    return value;
	
}

+ (NSString *) stripHTML: (NSString *) html{
	
	if(html == nil || [html isKindOfClass:[NSNull class]]) return nil;
	
    NSScanner *theScanner;
    NSString *text = nil;
	
    theScanner = [NSScanner scannerWithString:html];
	
    while ([theScanner isAtEnd] == NO) {
		
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
		
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
		
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
				[ NSString stringWithFormat:@"%@>", text]
											   withString:@" "];
		
    } // while //
    
    return html;	
}

+ (NSNumber *) parseNumber: (NSString *) value {
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    return [f numberFromString: value];    
    
}


@end
