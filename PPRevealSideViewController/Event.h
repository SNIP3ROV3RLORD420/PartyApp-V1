//
//  Event.h
//  MyPartyApp
//
//  Created by Dylan Humphrey on 3/16/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <Parse/Parse.h>

@interface Event : PFObject<PFSubclassing>{
    
    //old
    /*NSString *eventName;
    NSString *eventDescription;
    NSString *eventLocation;                                //will consist of Address + City + Zipcode
    
    NSInteger *maxCapacity;                                 //if reached, event will dissappear from map
    
    NSDate *eventDate;
    
    NSMutableArray *invited;                                //list of invited people, figure out how to get attending
    NSMutableArray *hosts;                                  //the hosts of the party
    NSMutableArray *blacklist;                               //Party will not show for black listed people
    //NSMutableArray *comments --> IDK if implement here, but basically facebook wall in event
    NSMutableArray *arrived;
    
    
    BOOL *BYOB;                                             //Bring your own beer
    BOOL *Private;                                          //only friends can see the event
    BOOL *ageBased;                                         //if ageBased then only people of certain age see event
    BOOL *rolled;                                           //if event is over
    
    float priceN;
    float priceL;
    float priceM;
    float priceH;
*/
    
    int numberOfMales;                                     
    int numberOfFemales;
}


+ (NSString *)parseClassName;



@property float priceN, priceL, priceM, priceH;

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *eventLocation;

@property (nonatomic) NSInteger *maxCapacity;

@property (nonatomic, strong) NSDate *eventDate;

@property (nonatomic, strong) NSMutableArray *invited;
@property (nonatomic, strong) NSMutableArray *hosts;
@property (nonatomic, strong) NSMutableArray *blacklist;
@property (nonatomic, strong) NSMutableArray* arrived;


@property (nonatomic, getter = isBYOB) BOOL *BYOB;
@property (nonatomic, getter = isPrivate) BOOL *Private;
@property (nonatomic, getter = isAgeBased) BOOL *ageBased;
@property (nonatomic, getter = isRolled) BOOL *rolled;



- (void)addHost:(PFUser*)u;
- (void)removeHost:(PFUser*)u;

- (void)addGuest:(PFUser*)u;
- (void)removeGuest:(PFUser*)u;
- (void)blacklistGuest:(PFUser*)u;
- (void)removeGuestFromBlacklist:(PFUser*)u;

- (NSMutableArray*)presentGuests;                               //people who are at event
- (NSMutableArray*)notPresentGuests;                            //people who arent there yet

-(void)savEvent;

-(void)guestArrived:(PFUser *)u;

- (float)percentFemale;                                         //will return decimal percent of females

- (int)currentNumberOfGuests;

@end
