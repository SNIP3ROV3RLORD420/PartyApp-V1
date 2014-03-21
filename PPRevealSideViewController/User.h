//
//  User.h
//  MyPartyApp
//
//  Created by Dylan Humphrey on 3/16/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@class Event;   //to avoid compiling issues :D

//What gender this user is interested in
enum{
    Male =   1,
    Female = 2,
    Both =   3,
};
typedef NSUInteger interestedIn;

//what gender this user is
enum{
    GenderMale =   1,
    GenderFemale = 2,
    GenderTranny = 3                          //lol
};
typedef NSUInteger Gender;

@interface User : NSObject{
    NSString *name;                           //actual name
    NSString *username;
    NSString *password;
    NSString *home;                           //used for Quick Host button
    
    CLLocationManager *locationManager;       //to get current location
    
    NSDate *DOB;                              //age --> make events more exclusive
    
    NSMutableArray *friendsList;              //make freinds
    
    BOOL *pushCurrentLocation;                //if user wants freinds to see where he/she is
    
    //add more stuff that I'm forgetting
}

@property (nonatomic, assign) interestedIn interest;
@property (nonatomic, assign) Gender gender;
/*
---------------Create Setters and Getters----------------------------------
 */
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *home;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, strong, getter = getBirthday) NSDate *DOB;

@property (nonatomic, strong) NSMutableArray *friendsList;

@property (nonatomic) BOOL *pushCurrentLocation;
/*
 ---------------Create Methods-------------------------------------
 */
- (BOOL)hasArrived:(Event*)selectedEvent;      //used to see whos at event

- (int)getAge;                                //for ease of getting users age based off DOB

- (CLLocation*)getCurrentLocation;            //needed to implement this...get rid of prop?

- (void)addFriend:(User*)u;                   //add a freind to your freind list

- (void)removeFriend:(User*)u;                //remove a freind :(

@end
