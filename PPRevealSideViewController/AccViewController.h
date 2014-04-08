//
//  AccViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 4/7/14.
//
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <Parse/Parse.h>

@interface AccViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) PFUser *usr;

//section 1
@property (nonatomic, strong) UIImageView *profPic;
@property (nonatomic, strong) UITextField *email;
@property (nonatomic, strong) UITextField *name;

//section 2
@property (nonatomic, strong) UITextField *home;
@property (nonatomic, strong) UIPickerView *interestedIn;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *username;

@end
