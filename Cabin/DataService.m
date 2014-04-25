//
//  DataService.m
//  Cabin
//
//  Created by Ben Ellingson on 2/27/14.
//  Copyright (c) 2014 Northstar New Media. All rights reserved.
//

#import "DataService.h"

#import "NSDictionary+JSON.h"

#define DOMAIN_NAME @"test.blackrocks.com"



@implementation DataService

static DataService *svc;

+ (DataService *) instance {
    
    if (svc == nil) {
        svc = [[DataService alloc] init];
        svc.df = [[NSDateFormatter alloc] init];
        svc.df.dateFormat = JSON_DATE_FORMAT;
        [svc loadPatientNumber];
        
    }
    return svc;
}



- (BOOL) upload {
    
    NSArray *results = [TestResult resultsToSync];
    if (results.count == 0) {
        NSLog(@"no results to sync");
        return YES;
    }
    
    NSLog(@"results to sync: %lu",(unsigned long)results.count);
    
    for (TestResult *result in results) {
        [self uploadTestResult: result];
    }
    
    
    return YES;
}

- (NSURL *) formatUrl: (TestResult *) result {
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat: @"http://%@/cabin.php",DOMAIN_NAME]];
    
    return url;
    
}

- (void) uploadTestResult: (TestResult *) result {
    
    NSURL *url = [self formatUrl: result];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *data = [NSData dataWithContentsOfFile: result.filePath];
    
    [request setHTTPBody: data];
    
    NSHTTPURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *responseString = [[NSString alloc] initWithData: responseData encoding: NSUTF8StringEncoding];
    //NSLog(@"responseData: %@ : %@ : %d", responseString, err, response.statusCode);


    if (err == nil && response.statusCode == 200) {
        [self handleUploadComplete: result];
    }
    
    
    
}

- (void) handleUploadComplete: (TestResult *) result {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath: result.filePath]) {
        NSString *filePath = [NSString stringWithFormat: @"%@.sent", result.filePath];
        [fm moveItemAtPath: result.filePath toPath: filePath error: nil];
        NSLog(@"sync complete");
    }
    

}

- (NSString *) formatPatientFilePath {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyyMMdd-HHmmss";
    
    NSString *name = @"patient.json";
    
    return  [DATA_FOLDER stringByAppendingFormat: @"/%@",name];
}

- (void) loadPatientNumber {
    
    NSString *filePath = [self formatPatientFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath: filePath isDirectory: NO] == NO) {
        self.patientNumber = nil;
        return;
    }
    
    NSData *data = [NSData dataWithContentsOfFile: filePath];
    
    NSError *error;
    NSDictionary *di = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingAllowFragments error: &error];
    if (error) {
        NSLog(@"error parsing result: %@",error.localizedDescription);
        self.patientNumber = nil;
        return;
    }
    
    self.patientNumber = [di numberForKey: @"patient_number"];
    self.startDate = [self.df dateFromString: [di stringForKey: @"start_date"]];
    
}

- (void) writePatientNumber: (NSNumber *) pNumber {
    
    self.patientNumber = pNumber;
    
    NSString *filePath = [self formatPatientFilePath];
    
    if (self.patientNumber == nil) {
        [[NSFileManager defaultManager] removeItemAtPath: filePath error: nil];
        return;
    }
    
    self.startDate = [NSDate date];
        
    NSDictionary *di = [NSDictionary dictionaryWithObjectsAndKeys: self.patientNumber,@"patient_number",
                                                                   [self.df stringFromDate: self.startDate], @"start_date",
                                                                    nil];
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject: di options: NSJSONWritingPrettyPrinted error: &error];
    if (error) {
        NSLog(@"error formatting sample data: %@",error.localizedDescription);
    }
    
    [data writeToFile: filePath atomically: YES];
    
}



@end
