//
//  LoginViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//
//

#import "LoginViewController.h"
#import "RightViewController.h"
#import "MyEventsViewController.h"
#import "MapViewController.h"
#import <Parse/Parse.h>
#import "Comms.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LoginViewController () <CommsDelegate>

@end

@implementation LoginViewController

@synthesize loginButton, createAccount, username, password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.revealSideViewController setPanInteractionsWhenOpened:PPRevealSideDirectionNone];
    [self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideDirectionNone];
    
    self.view.backgroundColor = UIColorFromRGB(0x34B085);
    
    //creating the table view
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 230, 280, 88) style:UITableViewStylePlain];
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    tableView.scrollEnabled = NO;
    tableView.layer.cornerRadius = 4;
    tableView.layer.borderWidth = .5;
    tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //creating the login button
    loginButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 323, 280, 44)];
    loginButton.backgroundColor = UIColorFromRGB(0x5cbf9d);
    loginButton.layer.cornerRadius = 3;
    loginButton.layer.borderColor = UIColorFromRGB(0x5cbf9d).CGColor;
    [loginButton addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"Log In" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //creating the create account button
    createAccount = [[UIButton alloc]initWithFrame:CGRectMake(85, 480, 150, 30)];
    createAccount.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
    [createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
    [createAccount addTarget:self action:@selector(create:) forControlEvents:UIControlEventTouchUpInside];
    [createAccount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //creating the label
    UIButton *appTitle = [[UIButton alloc]initWithFrame:CGRectMake(80, 160, 165, 50)];
    appTitle.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:40.0];
    [appTitle setTitle:@"Our App" forState:UIControlStateNormal];
    [appTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [appTitle addTarget:self action:@selector(bypass) forControlEvents:UIControlEventTouchUpInside];
    
    //adding stuff to the view
    [self.view addSubview:appTitle];
    [self.view addSubview:tableView];
    [self.view addSubview:loginButton];
    [self.view addSubview:createAccount];
    
    [self.navigationController setNavigationBarHidden:YES];
    //Everytime u see the login view, user needs to logout
    [PFUser logOut];
}

- (void)preloadRight{
    MyEventsViewController *lv = [[MyEventsViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:lv];
    nav.navigationBar.hidden = YES;
    [self.revealSideViewController preloadViewController:nav forSide:PPRevealSideDirectionRight];
    PPRSLog(@"Preloaded Right View");
    PP_AUTORELEASE(nav);
}

- (void)preloadLeft{
    RightViewController *c = [[RightViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.revealSideViewController preloadViewController:c forSide:PPRevealSideDirectionLeft];
    PPRSLog(@"Preloaded Left View");
    PP_AUTORELEASE(c);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preloadRight) object:nil];
    [self performSelector:@selector(preloadRight) withObject:nil afterDelay:0.3];
    [self performSelector:@selector(preloadLeft) withObject:nil afterDelay:0.4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button methods

- (void)dismissKeyboard{
    [username resignFirstResponder];
    [password resignFirstResponder];
}

- (void)logIn:(id)sender{
    [loginButton setTitle:@"Logging in" forState:UIControlStateNormal];
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text block:^(PFUser *user, NSError *error) {
        if (user) {
            [self.delegate loginViewControllerDidFinish:self];
            [loginButton setTitle:@"Logged In" forState:UIControlStateNormal];
            
            MapViewController *mv = [[MapViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mv];
            [self.revealSideViewController popViewControllerWithNewCenterController:nav animated:YES completion:^{PPRSLog(@"Logged In")}];
            
        } else {
            //Something bad has ocurred
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid username or password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
            [loginButton setTitle:@"Log in" forState:UIControlStateNormal];
        }
    }];
}

- (void)create:(id)sender{
    if ([username.text isEqualToString:@""] || [password.text isEqualToString:@""]){
        UIAlertView *errorView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter in a Username and password. Your account will be created with the Username and Password you enter" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorView show];
    }
    else if (![self correctPassword]){
        UIAlertView *errorView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Password must be more than 5 characters long and contain 1 number" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorView show];
    }
    else{
        [createAccount setEnabled:NO];
        // Do the login
        [Comms createAccountWithFB:self: self.username.text : self.password.text];
    }
}

- (void)bypass{
    MapViewController *mv = [[MapViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mv];
    [self.revealSideViewController popViewControllerWithNewCenterController:nav animated:YES completion:^{PPRSLog(@"Bypassed")}];
}

#pragma makr - Textfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - Other methods

- (BOOL)correctPassword{
    NSString *temp = password.text;
    NSString *numbers = @"0123456789";
    int length = password.text.length;
    int numbersCount = 0;
    for (int i = 0; i < length; i++) {
        for (int x = 0; x < numbers.length; x++) {
            if ([temp characterAtIndex:i] == [numbers characterAtIndex:x]) {
                numbersCount++;
            }
        }
    }
    if (length >= 5 && numbersCount > 0) {
        return YES;
    }
    NSLog(@"Numbers in password: %i",numbersCount);
    return NO;
}

#pragma mark - Table View Data Source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = PP_AUTORELEASE([[UITableViewCell alloc]init]);
    }
    if (indexPath.row == 0) {
        //creating the username
        username = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, 260, 44)];
        username.placeholder = @"Username";
        username.delegate = self;
        username.clearButtonMode = UITextFieldViewModeWhileEditing;
        [cell.contentView addSubview:username];
    }
    if (indexPath.row == 1) {
        //creating the password
        password = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, 260, 44)];
        password.placeholder = @"Password";
        password.secureTextEntry = YES;
        password.delegate = self;
        password.clearButtonMode = UITextFieldViewModeWhileEditing;
        [cell.contentView addSubview:password];
    }
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
@end
