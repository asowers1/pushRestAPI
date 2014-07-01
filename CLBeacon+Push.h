//
//  CLBeacon+Push.h
//  pushRestAPI
//
//  Created by Andrew Sowers on 6/27/14.
//  Copyright (c) 2014 Andrew Sowers. All rights reserved.
//

//
//  CLBeacon+Push.h
//  pushRestAPI
//
//  Created by Andrew Sowers on 6/27/14.
//  Copyright (c) 2014 Andrew Sowers. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, kPushUnitType){
    kPushUnitTypeMeters,
    kPushUnitTypeFeet,
    kPushUnitTypeYards
};
@interface CLBeacon (Push)

#pragma mark - Strings
/**
 * Return string formated with meters feet or yards
 *
 * @param type kPushUnitType
 *
 * @return NSString *
 */
- (NSString *)accuracyStringWithUnitType:(kPushUnitType)type;

/**
 * Returns the major number in string format
 *
 * @return NSString *
 */
-(NSString *)majorString;

/**
 * Returns the minor number in string format
 *
 * @return NSString;
 */
-(NSString *)minorString;

#pragma mark - Distance Float
/**
 *  returns the acuracy of the beacon using a given unit type
 *
 *  @param type kPushUnitType
 *
 *  @return NSString
 */
-(CGFloat)accuracyWithUnitType:(kPushUnitType)type;

#pragma mark - Key for PUSH
/**
 *  returns the identifier used by the PUSHListener to handle norifications/dates for each beacon
 *
 *  @return NSString
 */
-(NSString *)pushIdentifier;


@end
