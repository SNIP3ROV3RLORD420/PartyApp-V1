//
//  User.m
//  MyPartyApp
//
//  Created by Dylan Humphrey on 3/16/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize interest, gender, name, username, password, home, DOB, friendsList, pushCurrentLocation, locationManager;

- (BOOL)hasArrived:(Event *)selectedEvent{
    //if (self.getCurrentLocation == selectedEvent.location)
    //    return true;   need to write event class first
    return false;          // for now return false
}

- (int)getAge{
    NSDateComponents *ageComps = [[NSCalendar currentCalendar]
                                  components:NSYearCalendarUnit
                                  fromDate:self.getBirthday
                                  toDate:[NSDate date]
                                  options:0];
    return [ageComps year];
}

- (CLLocation*)getCurrentLocation{
    return locationManager.location;          //I have no idea if this works or not, but im gonna assume it does
}

- (void)addFriend:(User *)u{
    BOOL isAdded = NO;
    for (User* aUser in self.friendsList) {
        if ([u.username isEqualToString:aUser.username])
            isAdded = YES;
    }
    if (!isAdded)
        [friendsList insertObject:u atIndex:0];
}

- (void)removeFriend:(User *)u{               //should probably add some sort of error checking, but w/e
    [friendsList removeObject:u];
}

@end
