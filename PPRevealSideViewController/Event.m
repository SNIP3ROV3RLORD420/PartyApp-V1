//
//  Event.m
//  MyPartyApp
//
//  Created by Dylan Humphrey on 3/16/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//

#import "Event.h"


@implementation Event


@dynamic eventName, eventDate, eventDescription, eventLocation, maxCapacity, invited, hosts, blacklist, BYOB, Private, ageBased, rolled, priceN, priceH, priceL, priceM, arrived;

#pragma mark - Event Initialization

//Use this method to initialize an Event from a specific list -->
//Enables user to have preset lists that they select, then at runtime the event is initialized with that list.
- (id)initWithSpecifiedList:(NSMutableArray*)list{
    self.invited = list;
    return self;
}

+ (NSString *)parseClassName {
    return @"Event";
}

#pragma mark - Event Class Methods

-(void)saveEvent
{
    [self saveInBackground];
}

- (void)addHost:(PFUser *)u{
    BOOL isAHost = NO;
    for (PFUser *aUser in self.hosts){
        if ([aUser.username isEqualToString:u.username]) {
            isAHost = YES;
        }
    }
    if (!isAHost) {
        [self.hosts insertObject:u atIndex:0];
    }
    else
        NSLog(@"Already a Host");
}

- (void)removeHost:(PFUser *)u{
    [self.hosts removeObject:u];
}

- (void)addGuest:(PFUser *)u{
    BOOL isInvited = NO;
    if([self.invited containsObject:u])
    {
        isInvited = YES;
    }
    
    if (!isInvited)
    {
        [self.invited insertObject:u atIndex:0];
        
        if(u[@"isMale"])
            numberOfMales++;
        else
            numberOfFemales++;
    }
    else
        NSLog(@"Already a Guest");
}

- (void)removeGuest:(PFUser *)u{
    [self.invited removeObject:u];
}

- (void)blacklistGuest:(PFUser *)u{
    BOOL isBlackListed = NO;
    if([self.blacklist containsObject:u])
    {
        isBlackListed = YES;
    }
    if (!isBlackListed) {
        [self.blacklist insertObject:u atIndex:0];
    }
    else
        NSLog(@"Already blacklisted");
}

- (void)removeGuestFromBlacklist:(User *)u{
    [self.blacklist removeObject:u];
}

-(void)guestArrived: (PFUser *)u
{
    [self.arrived addObject:u];
}

- (NSMutableArray*)presentGuests{
    return self.arrived.copy;
}

- (NSMutableArray*)notPresentGuests{
    NSMutableArray* notArrived = [[NSMutableArray alloc] init];
    for(User* temp in self.invited)    {
        if(![self.arrived containsObject:temp])
        {
            [notArrived addObject:temp];
        }
    }
    return notArrived;
}

- (float)percentFemale{
    return (float)numberOfFemales / (numberOfFemales + numberOfMales);
}

- (int)currentNumberOfGuests{
    return numberOfFemales + numberOfMales;
}

@end
