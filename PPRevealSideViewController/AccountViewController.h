//
//  AccountViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/22/14.
//
//

#import <UIKit/UIKit.h>
#import "User.h"

@class AccountViewController;

@protocol AccountViewControllerDelegate <NSObject>

- (void)AccountViewControllerDidFinish:(AccountViewController*)av withAccount:(User*)u;

@end

@interface AccountViewController : UITableViewController

@property (nonatomic, weak) id <AccountViewControllerDelegate> delegate;

@end
