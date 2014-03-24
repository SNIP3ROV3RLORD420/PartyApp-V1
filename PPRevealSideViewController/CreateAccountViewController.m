//
//  CreateAccountViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/21/14.
//
//

#import "CreateAccountViewController.h"
#import <Parse/Parse.h>
#import "Comms.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CreateAccountViewController () <CommsDelegate>

@end

@implementation CreateAccountViewController
@synthesize createAccount;
@synthesize username;
@synthesize password;
@synthesize navBar;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    navBar = PP_AUTORELEASE([[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 64)]);
    navBar.backgroundColor = UIColorFromRGB(0x34B085);
    UINavigationItem *navItem = PP_AUTORELEASE([[UINavigationItem alloc]initWithTitle:@"Create Account"]);
    navItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Create"
                                                                                style:UIBarButtonItemStyleDone
                                                                               target:self
                                                                               action:@selector(create:)]);
    navItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Cancel"
                                                                               style:UIBarButtonItemStyleDone
                                                                              target:self
                                                                              action:@selector(cancel)]);
    navBar.items = [NSArray arrayWithObject:navItem];
    
    [self.view addSubview:navBar];
    
    //the Username text field
    username = [[UITextField alloc]initWithFrame:CGRectMake(40, 220, 240, 30)];
    username.borderStyle = UITextBorderStyleBezel;
    username.backgroundColor = [UIColor whiteColor];
    username.placeholder = @"Username";
    
    //the password text field
    password = [[UITextField alloc]initWithFrame:CGRectMake(40, 260, 240, 30)];
    password.borderStyle = UITextBorderStyleBezel;
    password.backgroundColor = [UIColor whiteColor];
    password.placeholder = @"Password";
    
    createAccount = [[UIButton alloc]initWithFrame:CGRectMake(65, 300, 192, 30)];
    [createAccount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
    createAccount.backgroundColor = UIColorFromRGB(0x34B085);
    createAccount.showsTouchWhenHighlighted = YES;
    [createAccount addTarget:self action:@selector(create:) forControlEvents:UIControlEventTouchUpInside];
    
    //incase user is logged in
    [PFUser logOut];
    
    [self.view addSubview:createAccount];
    [self.view addSubview:username];
    [self.view addSubview:password];
}

- (void) commsDidLogin:(BOOL)loggedIn {
	[createAccount setEnabled:YES];
    
	if (loggedIn) {
        [self dismissViewControllerAnimated:YES completion:^{PPRSLog(@"Dismissed")}];
	} else {
		// Show error alert
		[[[UIAlertView alloc] initWithTitle:@"Login Failed"
                                    message:@"Facebook Login failed. Please try again"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button methods

- (void)create:(id)sender{
    // Disable the Login button to prevent multiple touches
    [createAccount setEnabled:NO];
    
    // Do the login
    [Comms createAccountWithFB:self: self.username.text : self.password.text];
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
