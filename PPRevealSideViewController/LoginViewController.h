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

@property (retain, nonatomic)UIButton *loginButton;
@property (retain, nonatomic)UIButton *createAccount;

@property (retain, nonatomic)UITextField *username;
@property (retain, nonatomic)UITextField *password;

@property (strong, nonatomic)id <LoginViewControllerDelegate> delegate;

@end
