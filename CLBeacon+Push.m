//
//  CLBeacon+Push.m
//  pushRestAPI
//
//  Created by Andrew Sowers on 6/27/14.
//  Copyright (c) 2014 Andrew Sowers. All rights reserved.
//

#import "CLBeacon+Push.h"


NSString * const kPushDistanceString[] = {
    [kPushUnitTypeFeet] = @"ft",
    [kPushUnitTypeMeters] = @"m",
    [kPushUnitTypeYards] = @"yd",
};

CGFloat const kPushDistanceModifier[] = {
    [kPushUnitTypeFeet] = 3.28084f,
    [kPushUnitTypeMeters] = 1.0f,
    [kPushUnitTypeYards] = 1.09361f,
};

@implementation CLBeacon (PUSH)

#pragma mark - String Formats
- (NSString *)accuracyStringWithUnitType:(kPushUnitType)type {
    return self.accuracy >= 0 ? [NSString stringWithFormat:@"%0.2f %@", [self accuracyWithUnitType:type], kPushDistanceString[type]] : @"N/A";
}

- (NSString *)majorString {
    return [self.major stringValue];
}

- (NSString *)minorString {
    return [self.minor stringValue];
}


#pragma mark - Distance Float
- (CGFloat)accuracyWithUnitType:(kPushUnitType)type {
    return self.accuracy * kPushDistanceModifier[type];
}

#pragma mark - Key for PUSH
- (NSString *)pushIdentifier {
    return [NSString stringWithFormat:@"PUSH:%@:%@:%@", self.proximityUUID.UUIDString, self.major, self.minor];
}

@end
