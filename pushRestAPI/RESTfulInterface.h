//
//  RESTfulInterface.h
//  pushRestAPI
//
//  Created by Andrew Sowers on 6/30/14.
//  Copyright (c) 2014 Andrew Sowers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RESTfulInterface : NSObject <NSURLConnectionDataDelegate>{
    NSMutableData *mutableData;
    NSString *HTTPResponse;
}

#pragma mark - singleton
/**
 *  Creates a singleton object for use of NSURL utilities that connect to the Push Interactive REST API
 *
 *  @return RESTAPI
 */
+(instancetype)RESTAPI;
-(NSDictionary*)getBeaconCredsFromUUID:(NSString*)uuid;
-(NSData*)synchronousRequestWithString:(NSString*)urlString;
@end