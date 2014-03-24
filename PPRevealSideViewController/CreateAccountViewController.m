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

@interface CreateAccountViewController () <CommsDelegate>

@end

@implementation CreateAccountViewController
@synthesize createAccount;
@synthesize username;
@synthesize password;

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Create"
                                                                             style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(create:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel"
                                                                            style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(cancel:)];
    
#warning THESE DONT SHOW UP AND THERES NO WAY TO GO BACK TO THE LOGIN SCREEN BEFORE CREATING AN ACCOUNT
    
    //UIView *vw =[[UIView alloc]initWithFrame:CGRectMake(20, 92, 280, 269)];
    //vw.backgroundColor = [UIColor lightGrayColor];
    
    
    //the Username text field
    username = [[UITextField alloc]initWithFrame:CGRectMake(20, 127, 240, 30)];
    username.borderStyle = UITextBorderStyleBezel;
    username.backgroundColor = [UIColor whiteColor];
    username.placeholder = @"Username";
    
    //the password text field
    password = [[UITextField alloc]initWithFrame:CGRectMake(20, 165, 240, 30)];
    password.borderStyle = UITextBorderStyleBezel;
    password.backgroundColor = [UIColor whiteColor];
    password.placeholder = @"Password";
    
    createAccount = [[UIButton alloc]initWithFrame:CGRectMake(64, 200, 192, 30)];
    [createAccount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
    createAccount.backgroundColor = [UIColor greenColor];
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

//Table view shit???
/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
        cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = @"Testing AF";
    
    return cell;
}

#pragma mark - Managing Button Methods

- (void)create:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}*/

@end
