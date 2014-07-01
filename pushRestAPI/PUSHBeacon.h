//
//  PUSHBeacon.h
//  pushRestAPI
//
//  Created by Andrew Sowers on 6/27/14.
//  Copyright (c) 2014 Andrew Sowers. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreBluetooth;
@import CoreLocation;

@interface PUSHBeacon : NSObject

#pragma mark - properties
@property (nonatomic, strong) NSUUID *proximityUUID;
@property (nonatomic, strong) NSNumber *major;
@property (nonatomic, strong) NSNumber *minor;
@property (nonatomic, strong) NSString *identifier;

#pragma mark - singleton
/**
 *  Creates a singleton object for the current device so that the device can monitor itself as an iBeacon.
 *
 *  @return BUOYDevice
 */
+ (instancetype)deviceBeacon;

#pragma mark - Create Beacon
/**
 *  Sets the beacon information to be transmitted. Each field is optional - the resulting beacon will use [NSUUID UUID] for the proximity UUID, @1 for major, @1 minor, and "kBUOYDeviceBeaconIdentifier" for the identifier.
 *
 *  @param uuid       NSUUID
 *  @param major      NSNumber
 *  @param minor      NSNumber
 *  @param identifier NSString
 */
- (void)setWithProximityUUID:(NSUUID *)uuid major:(NSNumber *)major minor:(NSNumber *)minor identifier:(NSString *)identifier;

#pragma mark - Transmitting
/**
 *  Starts transmitting. Must call setWithProximityUUID:major:minor:identifier before this method will work.
 */
- (void)startTransmitting;

/**
 *  Stops transmitting.
 */
- (void)stopTransmitting;


@end
