//
//  AccountViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/22/14.
//
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <Parse/Parse.h>

@class AccountViewController;

@protocol AccountViewControllerDelegate <NSObject>

- (void)AccountViewControllerDidFinish:(AccountViewController*)av withAccount:(User*)u;

@end

@interface AccountViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <AccountViewControllerDelegate> delegate;

@property (nonatomic, weak) PFUser* usr;


@property (nonatomic, strong) UITextField *username;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *email;
@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) UITextField *home;

@property (nonatomic, strong) UITextField *birthday;
@property (nonatomic, strong) UIPickerView *gender;
@property (nonatomic, strong) UIPickerView *interestedIn;

@end
