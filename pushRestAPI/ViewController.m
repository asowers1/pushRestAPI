//
//  ViewController.m
//  pushRestAPI
//
//  Created by Andrew Sowers on 6/25/14.
//  Copyright (c) 2014 Andrew Sowers. All rights reserved.
//

#import "ViewController.h"
#import "PUSH.h"

@interface ViewController ()
@property (nonatomic, weak) NSUUID * uuid;
@property (weak, nonatomic) IBOutlet UILabel *dataView;
@property (weak, nonatomic) IBOutlet UIButton *testButton;


@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * uuidNSString = @"AAAAAAAA-BBBB-BBBB-CCCC-CCCCDDDDDDDD";  // Kontakt uid
    NSUUID * myUUID = [[NSUUID alloc] initWithUUIDString:uuidNSString];
    NSArray *beacons = [NSArray arrayWithObjects:myUUID, nil];
    
    //[[PUSHBeacon deviceBeacon] setWithProximityUUID:[[NSUUID alloc] initWithUUIDString:uuidNSString] major:@1 minor:@1 identifier:@"PUSH"];
    
    //[[PUSHBeacon deviceBeacon] startTransmitting];
    
    //NSDictionary * dict = [[RESTfulInterface RESTAPI]getBeaconCredsFromUUID:uuidNSString];
    NSMutableDictionary *dict = [[RESTfulInterface RESTAPI]getAllListings];
    NSLog(@"%@",dict);
    
    // Listen for iBeacons
    

//    [[PUSHListener defaultListener] listenForBeaconsWithProximityUUIDs:beacons notificationInterval:1];
//    // Handle Beacon Notification
//    [[NSNotificationCenter defaultCenter] addObserverForName:kPUSHDidFindNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
//        NSLog(@"%@", note.userInfo);
//        if (note.userInfo[kPUSHBeacon]) {
//            CLBeacon *beacon = note.userInfo[kPUSHBeacon];
//            NSLog(@"%@", [beacon accuracyStringWithUnitType:kPushUnitTypeFeet]);
//        }
//    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
- (IBAction)testButtonEvent:(id)sender {
}

@end
