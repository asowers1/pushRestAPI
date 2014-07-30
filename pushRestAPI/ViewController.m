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

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        /* process downloaded data in Concurrent Queue */
        //NSArray *data = [[RESTfulInterface RESTAPI]getUserFavorites:@"6461D97A-DC46-4E30-9FE5-F2F9C4BBBC06"];
        //NSArray *locations = [[RESTfulInterface RESTAPI]getAllListings];
        BOOL data = [[RESTfulInterface RESTAPI]addNewAnonUser:@"CE4C8880-AB84-4401-A8BD-9EA6790C5F3E"];
        
        NSLog(@"data: %d",data);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* update UI on Main Thread */

        });
    });
    
    
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
