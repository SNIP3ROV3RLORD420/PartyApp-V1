//
//  Comms.m
//  FBParse
//
//  Created by Jake Saferstein on 3/22/14.
//

#import "Comms.h"
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>

@implementation Comms

+(void) addFieldToUser: (NSString*) key : (NSObject*) object
{
    [[PFUser currentUser] addObject:object forKey:key];
}


+ (void) createAccountWithFB:(id<CommsDelegate>)delegate : (NSString*) userName : (NSString*) password
{
	// Basic User information and your friends are part of the standard permissions
	// so there is no reason to ask for additional permissions
	[PFFacebookUtils logInWithPermissions:nil block:^(PFUser *user, NSError *error) {
		// Was login successful ?
		if (!user) {
			if (!error) {
                NSLog(@"The user cancelled the Facebook login.");
            } else {
                NSLog(@"An error occurred: %@", error.localizedDescription);
            }
            
			// Callback - login failed
			if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
				[delegate commsDidLogin:NO];
			}
		} else {
			if (user.isNew) {
				NSLog(@"User signed up and logged in through Facebook!");
                [user setUsername:userName];
                [user setPassword:password];
                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                            if (!error) {
                                NSDictionary<FBGraphUser> *me = (NSDictionary<FBGraphUser> *)result;
                                NSString* temp = me.name;
                                [user setObject:me.id forKey:@"fbId"];
                                if([[me objectForKey:@"gender"] isEqualToString:@"male"])
                                    user[@"isMale"] = [NSNumber numberWithBool:YES];
                                else
                                    user[@"isMale"] = [NSNumber numberWithBool:NO];
                                user[@"name"] = temp;
                                [user saveInBackground];
                            }
                    }];
                }];
			} else {
				NSLog(@"User logged in through Facebook!");
			}
            
            if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
                    [delegate commsDidLogin:YES];
            }
		}
	}];
}

@end
