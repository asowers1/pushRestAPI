//
//  PUSHBeacon.m
//  pushRestAPI
//
//  Created by Andrew Sowers on 6/27/14.
//  Copyright (c) 2014 Andrew Sowers. All rights reserved.
//

#import "PUSHBeacon.h"

NSString * const PUSHBeaconIdent = @"com.PUSH.BeaconRegionIdentifier";

@interface PUSHBeacon() <CBPeripheralManagerDelegate>
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@end

@implementation PUSHBeacon

#pragma mark - Singleton
+ (instancetype)deviceBeacon
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Init
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Create Beacon
- (void)setWithProximityUUID:(NSUUID *)uuid major:(NSNumber *)major minor:(NSNumber *)minor identifier:(NSString *)identifier
{
    
    // setup
    self.proximityUUID = uuid ? uuid : [NSUUID UUID];
    self.major = major ? major : @1;
    self.minor = minor ? minor : @1;
    self.identifier = identifier ? identifier : PUSHBeaconIdent;
    
    // Build Beacon Region
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.proximityUUID major:[self.major integerValue] minor:[self.minor integerValue] identifier:self.identifier];
}

#pragma mark - Transmitting
- (void)startTransmitting
{
    NSLog(@"startTransmitting");
    if(!self.proximityUUID) {
        NSLog(@"error - need proximity uuid");
        return;
    }
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}

-(void)stopTransmitting
{
    [self.peripheralManager stopAdvertising];
    self.peripheralManager = nil;
}

#pragma mark - Core Bluetooth
-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSLog(@"didUpdateState");
    if(peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        [peripheral startAdvertising:[self.beaconRegion peripheralDataWithMeasuredPower:@90]];
    }
    else if(peripheral.state == CBPeripheralManagerStatePoweredOff)
    {
        [peripheral stopAdvertising];
    }
}
@end
