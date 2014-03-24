//
//  Comms.m
//  FBParse
//
//  Created by Jake Saferstein on 3/22/14.
//

#import "Comms.h"
#import <Parse/Parse.h>

@implementation Comms


//ACTUALLY IS AUTHORIZE FACEBOOK
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
                [[PFUser currentUser] setUsername:userName];
                [[PFUser currentUser] setPassword:password];
			} else {
				NSLog(@"User logged in through Facebook!");
			}
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    NSDictionary<FBGraphUser> *me = (NSDictionary<FBGraphUser> *)result;
                    [[PFUser currentUser] setObject:me.id forKey:@"fbId"];
                    [[PFUser currentUser] saveInBackground];
                    NSLog(@"Test");
                    //later on can get birthday too, auto suggest throw b-day party??/

                }
                
                // Callback - login successful
                if ([delegate respondsToSelector:@selector(commsDidLogin:)]) {
                    [delegate commsDidLogin:YES];
                }
            }];
		}
	}];
}

@end
