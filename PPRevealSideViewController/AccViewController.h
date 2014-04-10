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

@interface AccViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, strong) PFUser *usr;

//section 1
@property (nonatomic, strong) UIImageView *profPic;
@property (nonatomic, strong) UITextField *firstName;
@property (nonatomic, strong) UITextField *lastName;

//section 2
@property (nonatomic, strong) UITextField *home;
@property (nonatomic, strong) UITextField *email;
@property (nonatomic, strong) UITextField *InterestedIn;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UITextField *username;

//other things
@property (nonatomic, strong) UISearchDisplayController *homeSearch;

@end
