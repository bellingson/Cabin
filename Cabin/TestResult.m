//
//  TestResult.m
//  Cabin
//
//  Created by Ben Ellingson on 2/26/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "TestResult.h"

#import "NSDictionary+JSON.h"

@implementation TestResult

@synthesize filePath;

- (id) initWithSamples: (NSArray *) aSamples;
{
    self = [super init];
    if (self) {
        self.samples = aSamples;
        self.time = [NSDate date];
        [self tally];
        [self writeToFile];
    }
    return self;
}

- (void) tally {
    
    
    self.countCorrect = 0;
    self.countWrong = 0;
    
    for (TestSample *sample in self.samples) {

        if(sample.correct)
            self.countCorrect += 1;
        else
            self.countWrong += 1;
        
        self.totalResponseTime += sample.time;
    }
    
    self.percentAccurate = (int) (((float) self.countCorrect / self.samples.count) * 100);
    self.averageResponseTime = self.totalResponseTime / self.samples.count;
    
}

- (void) writeToFile {
    
    self.filePath = [self formatFilePath];
    NSLog(@"write to file: %@",filePath);

    
    NSDictionary *di = [self asDictionary];
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject: di options: NSJSONWritingPrettyPrinted error: &error];
    if (error) {
        NSLog(@"error formatting sample data: %@",error.localizedDescription);
    }
    
    [data writeToFile: filePath atomically: YES];
    
    //NSString *json = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    //NSLog(@"json: %@",json);
    
    
    
}

- (NSDictionary *) asDictionary {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = JSON_DATE_FORMAT;
    
    return [NSDictionary dictionaryWithObjectsAndKeys: [self samplesAsDictionaryValues], @"samples",
                                                        [df stringFromDate: self.time],@"time",
            nil];
    
}

- (NSArray *) samplesAsDictionaryValues {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (TestSample *sample in self.samples) {
        [array addObject: [sample asDictionary]];
    }
    
    
    return array;
    
    
}

- (NSString *) formatFilePath {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyyMMdd-HHmmss";
    
    NSString *name = [NSString stringWithFormat: @"session-%@.json",[df stringFromDate: self.time]];
    
    return  [DATA_FOLDER stringByAppendingFormat: @"/%@",name];
}

+ (NSArray *) loadResultsFromFile {
    
    NSMutableArray *r = [[NSMutableArray alloc] init];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *error;
    NSArray *files = [fm contentsOfDirectoryAtPath: DATA_FOLDER error: &error];
    if (error) {
        NSLog(@"error loading results: %@",error.localizedDescription);
    }
    
    for (NSString *name in files) {
        
        if ([name rangeOfString: @"session"].location == NSNotFound)
            continue;
        
        NSString *filePath = [DATA_FOLDER stringByAppendingFormat: @"/%@",name];
        //NSLog(@"file: %@",filePath);
        TestResult *testR = [self parseResultFromFile: filePath];
        if (testR) {
            [r addObject:testR];
        }
    }
    
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey: @"time" ascending: NO];
    [r sortUsingDescriptors: [NSArray arrayWithObject: sd]];
    
    return r;
}

+ (NSArray *) resultsToSync {
    
    NSMutableArray *r = [[NSMutableArray alloc] init];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *error;
    NSArray *files = [fm contentsOfDirectoryAtPath: DATA_FOLDER error: &error];
    if (error) {
        NSLog(@"error loading results: %@",error.localizedDescription);
    }
    
    for (NSString *name in files) {
        
        if ([name rangeOfString: @"session"].location == NSNotFound)
            continue;
        
        if ([name rangeOfString: @".sent"].location != NSNotFound)
            continue;
        
        NSString *filePath = [DATA_FOLDER stringByAppendingFormat: @"/%@",name];
        //NSLog(@"file: %@",filePath);
        
        TestResult *result = [self parseResultFromFile: filePath];
        [r addObject: result];
        
    }
    
    return r;
    
}

+ (TestResult *) parseResultFromFile: (NSString *) filePath {
    
    TestResult *result = [[TestResult alloc] init];
    result.filePath = filePath;

    NSData *data = [NSData dataWithContentsOfFile: filePath];
    
    NSError *error;
    NSDictionary *di = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingAllowFragments error: &error];
    if (error) {
        NSLog(@"error parsing result: %@",error.localizedDescription);
    }
    
    //NSLog(@"%@",di);
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = JSON_DATE_FORMAT;
    result.time = [df dateFromString: [di stringForKey: @"time"]];
    
    NSArray *samplesDi = [di objectForKey: @"samples"];
    
    NSMutableArray *samples = [[NSMutableArray alloc] init];

    for (NSDictionary *sdi in samplesDi) {
        TestSample *sample = [TestSample fromDictionary: sdi];
        [samples addObject: sample];
    }
    
    result.samples = samples;
    [result tally];

    return result;
}



@end
