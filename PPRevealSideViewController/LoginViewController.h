//
//  LoginViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>


- (void)loginViewControllerDidFinish:(LoginViewController*)lv;

@end

@interface LoginViewController : UIViewController  <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)UIButton *loginButton;
@property (strong, nonatomic)UIButton *createAccount;

@property (strong, nonatomic)UITextField *username;
@property (strong, nonatomic)UITextField *password;

@property (weak, nonatomic)id <LoginViewControllerDelegate> delegate;

@end
