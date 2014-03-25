//
//  AccountViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/22/14.
//
//

#import "AccountViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AccountViewController (){
    BOOL editingMode;
    User *currentUser;
}

@end

@implementation AccountViewController

@synthesize username, password, email, name, birthday, gender, interestedIn;

#pragma mark - Class Methods

- (void)setCurrentUser{
    currentUser.username = [[PFUser currentUser] username];
    currentUser.password = [[PFUser currentUser] password];
    //currentUser.name =
    currentUser.home = @"";
    currentUser.DOB = nil;
    currentUser.pushCurrentLocation = NO;
    currentUser.interest = None;
    currentUser.gender = GenderNone;
}

- (void)updateCurrentUser{
    //use the User *currentUser to update the actual online user
    //this method will be called in the done method
}

#pragma mark - View Methods

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.separatorColor = UIColorFromRGB(0x34B085);
        self.tableView.allowsSelection = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                    target:self
                                    action:@selector(edit)]);
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Back"
                                                                            style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(back)]);
    self.title = @"My Account";
    editingMode = NO;
    [self setCurrentUser];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 4;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1)
        return 200;
    if (indexPath.section == 1 && indexPath.row == 2)
        return 200;
    if (indexPath.section == 1 && indexPath.row == 3)
        return 200;
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell = [[UITableViewCell alloc]init];
                    cell.textLabel.text = @"Username";
                    username = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    username.borderStyle = UITextBorderStyleRoundedRect;
                    username.delegate = self;
                    if (![self.account username])
                        username.placeholder = @"Username";
                    else
                        username.text = [self.account username];
                    [cell.contentView addSubview:username];
                    break;
                case 1:
                    cell = [[UITableViewCell alloc]init];
                    cell.textLabel.text = @"Password";
                    password = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    password.borderStyle = UITextBorderStyleRoundedRect;
                    password.delegate = self;
                    if (![self.account password])
                        password.placeholder = @"Password";
                    else
                        password.text = [self.account password];
                    [cell.contentView addSubview:password];
                    break;
                case 2:
                    cell = [[UITableViewCell alloc]init];
                    cell.textLabel.text = @"Email";
                    email = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    email.borderStyle = UITextBorderStyleRoundedRect;
                    email.delegate = self;
                    //if (![self.account emailAddress])
                      ///  email.placeholder = @"Email";
                    //else
                      //  email.text = [self.account emailAddress];
                    [cell.contentView addSubview:email];
                    break;
                default:
                    cell = [[UITableViewCell alloc]init];
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell = [[UITableViewCell alloc]init];
                    cell.textLabel.text = @"Name";
                    name = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    name.borderStyle = UITextBorderStyleRoundedRect;
                    name.delegate = self;
                    if (![self.account name])
                        name.placeholder = @"Your Name";
                    else
                        name.text = [self.account name];
                    [cell.contentView addSubview:name];
                    break;
                case 1:
                    cell = [[UITableViewCell alloc]init];
                    cell.textLabel.text = @"Birthday";
                    birthday = [[UIDatePicker alloc]init];
                    birthday.datePickerMode = UIDatePickerModeDate;
                    [cell.contentView addSubview:birthday];
                    break;
                case 2:
                    cell = [[UITableViewCell alloc]init];
                    cell.textLabel.text = @"Gender";
                    break;
                case 3:
                    cell = [[UITableViewCell alloc]init];
                    cell.textLabel.text = @"Interested In";
                default:
                    cell = [[UITableViewCell alloc]init];
                    break;
            }
            break;
    }
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Account Information";
            break;
        case 1:
            return @"Personal Information";
    }
    return @"This shouldnt show up";
}

#pragma mark - UITexfield Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (editingMode)
        return YES;
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
#pragma mark - Managing Button Methods

- (void)edit{
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(done)]);
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)]);
    editingMode = YES;
}

- (void)back{
    [self.revealSideViewController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)done{
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit)]);
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)]);
        editingMode = NO;
    [self.view endEditing:YES];
    [self updateCurrentUser];
}

- (void)cancel{
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit)]);
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)]);
    editingMode = NO;
    [self.view endEditing:YES];
}

@end
