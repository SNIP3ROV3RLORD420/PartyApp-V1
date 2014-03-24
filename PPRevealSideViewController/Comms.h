//
//  Comms.h
//  FBParse
//
//  Created by Jake Saferstein on 3/22/14.
//

#import <Foundation/Foundation.h>

@protocol CommsDelegate <NSObject>
@optional
- (void) commsDidLogin:(BOOL)loggedIn;
@end

@interface Comms : NSObject
+ (void) createAccountWithFB:(id<CommsDelegate>)delegate : (NSString*) userName: (NSString *) password;

@end