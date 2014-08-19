//  The MIT License (MIT)
//
//  Copyright (c) 2014 Intermark Interactive
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "PUSHListener.h"

// Constant Strings
NSString * const kPUSHBeaconRangeIdentifier = @"com.PUSHBeacon.Region";
NSString * const kPUSHDidFindNotification = @"kPUSHDidFindBeaconNotification";
NSString * const kPUSHBeacon = @"kPUSHBeacon";
NSTimeInterval const kPUSHDefaultTimeInterval = 0;


// Interface
@interface PUSHListener() <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableDictionary *beaconRegions;

// Listening
@property (nonatomic) BOOL isListening;
@property (nonatomic) NSTimeInterval beaconInterval;
@property (nonatomic, strong) NSMutableDictionary *seenBeacons;
@end


// Implementation
@implementation PUSHListener

#pragma mark - Singleton
+ (instancetype)defaultListener {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}


#pragma mark - Init
- (instancetype)init {
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDelegate:self];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        self.beaconInterval = kPUSHDefaultTimeInterval;
        self.beaconRegions = [NSMutableDictionary dictionary];
        self.seenBeacons = [NSMutableDictionary dictionary];
    }
    
    return self;
}


#pragma mark - Start/Stop Listening
- (void)listenForBeacons:(NSArray *)beacons {
    // Register for region monitoring
    for (CLBeaconRegion *beaconRegion in beacons) {
        // Create the beacon region tohv be monitored.
        beaconRegion.notifyEntryStateOnDisplay = YES;
        
        // Register the beacon region with the location manager.
        [self.locationManager startMonitoringForRegion:beaconRegion];
        [self.locationManager requestStateForRegion:beaconRegion];
        [self.beaconRegions setObject:beaconRegion forKey:beaconRegion.proximityUUID.UUIDString];
    }
}

- (void)listenForBeacons:(NSArray *)beacons notificationInterval:(NSTimeInterval)seconds {
    self.beaconInterval = seconds;
    [self listenForBeacons:beacons];
}

- (void)stopListening {
    for (CLBeaconRegion *region in self.beaconRegions) {
        [self.locationManager stopMonitoringForRegion:region];
    }
}

- (void)stopListeningForBeaconsWithProximityUUID:(NSUUID *)uuid {
    if (self.beaconRegions[uuid.UUIDString]) {
        [self.locationManager stopMonitoringForRegion:self.beaconRegions[uuid.UUIDString]];
        [self.beaconRegions removeObjectForKey:uuid.UUIDString];
    }
}


#pragma mark - Notifications
- (void)setNotificationInterval:(NSTimeInterval)seconds {
    self.beaconInterval = seconds;
}

- (void)sendNotificationWithBeacon:(CLBeacon *)beacon {
    if ([self shouldSendNotificationForBeacon:beacon]) {
        [self addBeaconToSeenBeaconsDictionary:beacon];
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUSHDidFindNotification object:nil userInfo:@{kPUSHBeacon:beacon}];
    }
}

- (BOOL)shouldSendNotificationForBeacon:(CLBeacon *)beacon {
    if (self.seenBeacons[[beacon pushIdentifier]]) {
        return abs([[NSDate date] timeIntervalSinceDate:self.seenBeacons[[beacon pushIdentifier]]]) >= self.beaconInterval;
    }
    
    return YES;
}

- (void)addBeaconToSeenBeaconsDictionary:(CLBeacon *)beacon {
    [self.seenBeacons setObject:[NSDate date] forKey:[beacon pushIdentifier]];
}


#pragma mark - Location Manager Delegate
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"locationManager didRangeBeacons");
    // Notify for each Beacon found
    for (NSInteger b = 0; b < beacons.count; b++) {
        [self sendNotificationWithBeacon:beacons[b]];
    }
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    NSLog(@"locationManager didDetermineState");
    if ([region isKindOfClass:[CLBeaconRegion class]] && state == CLRegionStateInside) {
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
    else if ([region isKindOfClass:[CLBeaconRegion class]] && state == CLRegionStateOutside) {
        [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

@end
