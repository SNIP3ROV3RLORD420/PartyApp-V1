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

@interface AccountViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <AccountViewControllerDelegate> delegate;

@property (nonatomic, retain) UITextField *username;
@property (nonatomic, retain) UITextField *password;
@property (nonatomic, retain) UITextField *email;
@property (nonatomic, retain) UITextField *name;

@property (nonatomic, retain) UIDatePicker *birthday;
@property (nonatomic, retain) UIPickerView *gender;
@property (nonatomic, retain) UIPickerView *interestedIn;

@end
