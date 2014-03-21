//
//  Event.m
//  MyPartyApp
//
//  Created by Dylan Humphrey on 3/16/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//

#import "Event.h"


@implementation Event

@synthesize eventName, eventDate, eventDescription, eventLocation, maxCapacity, invited, hosts, blacklist, BYOB, Private, ageBased, rolled, price;

#pragma mark - Event Initialization

//Use this method to initialize an Event from a specific list -->
//Enables user to have preset lists that they select, then at runtime the event is initialized with that list.
- (id)initWithSpecifiedList:(NSMutableArray*)list{
    self.invited = list;
    return self;
}

#pragma mark - Event Class Methods

- (void)addHost:(User *)u{
    BOOL isAHost = NO;
    for (User *aUser in hosts){
        if ([aUser.username isEqualToString:u.username]) {
            isAHost = YES;
        }
    }
    if (!isAHost) {
        [hosts insertObject:u atIndex:0];
    }
    else
        NSLog(@"Already a Host");
}

- (void)removeHost:(User *)u{
    [hosts removeObject:u];
}

- (void)addGuest:(User *)u{
    BOOL isInvited = NO;
    if([invited containsObject:u])
    {
        isInvited = YES;
    }
    if (!isInvited) {
        [invited insertObject:u atIndex:0];
    }
    else
        NSLog(@"Already a Guest");
}

- (void)removeGuest:(User *)u{
    [invited removeObject:u];
}

- (void)blacklistGuest:(User *)u{
    BOOL isBlackListed = NO;
    if([blacklist containsObject:u])
    {
        isBlackListed = YES;
    }
    if (!isBlackListed) {
        [blacklist insertObject:u atIndex:0];
    }
    else
        NSLog(@"Already a User");
}

- (void)removeGuestFromBlacklist:(User *)u{
    [blacklist removeObject:u];
}

-(BOOL)guestArrived: (User *)u
{
    //called by the ViewController when a user gets to an event
    if(![u hasArrived:self])
    {
        //if the user isnt physically here => returns no
        return NO;
    }
    //else adds user to arrived, returns yes
    [arrived addObject:u];
    return YES;
}

- (NSMutableArray*)presentGuests{
    return arrived.copy;
}

- (NSMutableArray*)notPresentGuests{
    NSMutableArray* notArrived = [[NSMutableArray alloc] init];
    for(User* temp in invited)    {
        if(![arrived containsObject:temp])
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
