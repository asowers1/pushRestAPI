//
//  RESTfulInterface.m
//  pushRestAPI
//
//  Created by Andrew Sowers on 6/30/14.
//  Copyright (c) 2014 Andrew Sowers. All rights reserved.
//

#import "RESTfulInterface.h"

@implementation RESTfulInterface

#pragma mark - singleton

+(instancetype)RESTAPI
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance =[[self alloc] init];
    });
    return _sharedInstance;
}

-(instancetype)init
{
    if (self == [super init]){
        return self;
    }
    return nil;
}

#pragma mark - RESTful data interface

-(NSDictionary *)getBeaconCredsFromUUID:(NSString*)uuid
{
    NSString *urlString = [NSString stringWithFormat:@"http://experiencepush.com/csp_portal/rest/?uuid=%@",uuid];
    NSData * data = [self synchronousRequestWithString:urlString];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(error){
        return nil;
    }
    return json;
}

#pragma mark - NSURLConnection synchronous methods

-(NSData*)synchronousRequestWithString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    [theRequest addValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPMethod:@"GET"];
    NSURLResponse* response = nil;
    NSError* error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    if(error){
        return nil;
    }
    return data;
}


#pragma mark - NSURLConnection asynchronous delegates

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    // Discard all previously received data.
    [mutableData setLength:0];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // add new data
    [mutableData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    // If we get any connection error we can manage it here…
    return;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // in the form of JSON
    HTTPResponse = [[NSString alloc] initWithData: mutableData encoding:NSUTF8StringEncoding];
}
@end
