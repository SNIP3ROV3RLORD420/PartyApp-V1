//
//  LoginViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//
//

#import <UIKit/UIKit.h>

@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>

- (void)loginViewControllerDidFinish:(LoginViewController*)lv;

@end

@interface LoginViewController : UIViewController

@property (retain, nonatomic)UIButton *loginButton;
@property (retain, nonatomic)UIButton *createAccount;

@property (retain, nonatomic)UITextField *username;
@property (retain, nonatomic)UITextField *password;

@property (retain, nonatomic)UILabel *appTitle;
@property (retain, nonatomic)UILabel *logo;

@property (retain, nonatomic)UIImageView *logoIV;
@property (retain, nonatomic)UIImageView *titleIV;

@property (strong, nonatomic)id <LoginViewControllerDelegate> delegate;

@end
