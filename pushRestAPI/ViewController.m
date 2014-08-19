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
    
//    NSString * uuidNSString = @"AAAAAAAA-BBBB-BBBB-CCCC-CCCCDDDDDDDD";  // Kontakt uid
//    NSUUID * myUUID = [[NSUUID alloc] initWithUUIDString:uuidNSString];
//    NSArray *beacons = [NSArray arrayWithObjects:myUUID, nil];
    
    //[[PUSHBeacon deviceBeacon] setWithProximityUUID:[[NSUUID alloc] initWithUUIDString:uuidNSString] major:@1 minor:@1 identifier:@"PUSH"];
    
    //[[PUSHBeacon deviceBeacon] startTransmitting];
    
    //NSDictionary * dict = [[RESTfulInterface RESTAPI]getBeaconCredsFromUUID:uuidNSString];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* update UI on Main Thread */
            
        });
        
    });
    
    
    // use this code
    
    NSLog(@"registerTriggeredBeaconAction: %d",[[RESTfulInterface RESTAPI] registerTriggeredBeaconAction:@"33" :@"rental" :1 :@"FA6A3E2D-2D3E-4E37-AD1F-B2E9FDE36A3C"]);
    NSLog(@"getCampaignHasBeacon: %@",[[RESTfulInterface RESTAPI] getCampaignHasBeacon]);
    
    
//    NSArray *beacons = [[RESTfulInterface RESTAPI] getAllBeacons];
//    NSMutableArray *uuidArray = [[NSMutableArray alloc] init];
//    for (int i = 0; i<beacons.count; i++) {
//        [uuidArray addObject:[[NSUUID alloc] initWithUUIDString:beacons[i][2]]];
//    }
//    NSLog(@"data: %@",uuidArray);
//    [[PUSHListener defaultListener] listenForBeaconsWithProximityUUIDs:uuidArray notificationInterval:1];
//    // Handle Beacon Notification
//    [[NSNotificationCenter defaultCenter] addObserverForName:kPUSHDidFindNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
//        NSLog(@"%@", note.userInfo);
//        if (note.userInfo[kPUSHBeacon]) {
//            CLBeacon *beacon = note.userInfo[kPUSHBeacon];
//            NSLog(@"%@", [beacon accuracyStringWithUnitType:kPushUnitTypeFeet]);
//        }
//    }];
    
    // Listen for iBeacons
    



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
- (IBAction)testButtonEvent:(id)sender {
}

@end
