//
//  LoginViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "Comms.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LoginViewController () <CommsDelegate>

@end

@implementation LoginViewController

@synthesize loginButton, createAccount, username, password, appTitle, logoIV, titleIV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //making the sub view
        UIView *vw =[[UIView alloc]initWithFrame:CGRectMake(20, 92, 280, 269)];
        vw.backgroundColor = [UIColor lightGrayColor];
        
        //the loginButton
        loginButton = [[UIButton alloc]initWithFrame:CGRectMake(44, 203, 192, 30)];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setTitle:@"Login" forState:UIControlStateNormal];
        loginButton.backgroundColor = UIColorFromRGB(0x34B085);
        loginButton.showsTouchWhenHighlighted = YES;
        [loginButton addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
        
        //the Create account button
        createAccount = [[UIButton alloc]initWithFrame:CGRectMake(64, 518, 192, 30)];
        [createAccount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
        createAccount.backgroundColor = UIColorFromRGB(0x34B085);
        createAccount.showsTouchWhenHighlighted = YES;
        [createAccount addTarget:self action:@selector(create:) forControlEvents:UIControlEventTouchUpInside];
        
        //the Username text field
        username = [[UITextField alloc]initWithFrame:CGRectMake(20, 127, 240, 30)];
        username.borderStyle = UITextBorderStyleBezel;
        username.backgroundColor = [UIColor whiteColor];
        username.placeholder = @"Username";
        username.delegate = self;
        
        //the password text field
        password = [[UITextField alloc]initWithFrame:CGRectMake(20, 165, 240, 30)];
        password.borderStyle = UITextBorderStyleBezel;
        password.backgroundColor = [UIColor whiteColor];
        password.placeholder = @"Password";
        password.secureTextEntry = YES;
        password.delegate = self;
        password.secureTextEntry = YES;
        
        //title label
        appTitle = [[UILabel alloc]initWithFrame:CGRectMake(84, 29, 135, 40)];
        appTitle.text = @"Our App Title";
        appTitle.textAlignment = NSTextAlignmentCenter;
        appTitle.adjustsFontSizeToFitWidth = YES;
        
        //the logo image
        logoIV = [[UIImageView alloc]initWithFrame:CGRectMake(84, 29, 135, 40)];
        
        //the title image
        titleIV = [[UIImageView alloc]initWithFrame:CGRectMake(85, 9, 110, 100)];
        
        //adding shit to the vw view
        [vw addSubview:loginButton];
        [vw addSubview:username];
        [vw addSubview:password];
        [vw addSubview:titleIV];
        
        //adding all this shit to the main view
        [self.view addSubview:vw];
        [self.view addSubview:logoIV];
        [self.view addSubview:createAccount];
        [self.view addSubview:appTitle];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    //Everytime u see the login view, user needs to logout
    //[PFUser logOut];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button methods


- (void)logIn:(id)sender{
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text block:^(PFUser *user, NSError *error) {
        if (user) {
            [self dismissViewControllerAnimated:YES completion:^{PPRSLog(@"Dismissed")}];
        } else {
            //Something bad has ocurred
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid username or password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

- (void)create:(id)sender{
    if ([username.text isEqualToString:@""] || [password.text isEqualToString:@""]){
        UIAlertView *errorView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter in a Username and password. Your account will be created with the Username and Password you enter" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorView show];
    }
    else{
        [createAccount setEnabled:NO];
        // Do the login
        [Comms createAccountWithFB:self: self.username.text : self.password.text];
    }
}

#pragma makr - Textfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
@end
