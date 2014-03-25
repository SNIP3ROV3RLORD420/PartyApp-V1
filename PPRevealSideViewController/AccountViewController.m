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

@synthesize username, password, email, home, name, birthday, gender, interestedIn;

#pragma mark - Class Methods

- (void)setCurrentUser{
    currentUser.username = [[PFUser currentUser] username];
    currentUser.password = [[PFUser currentUser] password];
    //currentUser.name =
    currentUser.home = @"";
    currentUser.DOB = [NSDate date];
    currentUser.interest = None;
    currentUser.gender = GenderNone;
}

- (void)updateCurrentUser{
    //use the User *currentUser to update the actual online user
    //this method will be called in the done method
    currentUser.username = username.text;
    currentUser.password = password.text;
    currentUser.name = name.text;
    currentUser.home = home.text;
    currentUser.emailAddress = email.text;
    currentUser.DOB = birthday.date;
    // currentUser.interest
    // currentUser.gender =
    // sets the parameters on the currentUser
    // later implement actually uploading part
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
    self.title = @"Profile";
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
            return 5;
            break;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 2 && editingMode)
        return 200;
    if (indexPath.section == 1 && indexPath.row == 3 && editingMode)
        return 200;
    if (indexPath.section == 1 && indexPath.row == 4 && editingMode)
        return 200;
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    //label for all the picker views
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 160, 20)];
    //label for all the picker views
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(250, 10, 50, 20)];
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
                    if (![currentUser username])
                        username.placeholder = @"Username";
                    else
                        username.text = [currentUser username];
                    [cell.contentView addSubview:username];
                    break;
                case 1:
                    cell = [[UITableViewCell alloc]init];
                    cell.textLabel.text = @"Password";
                    password = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    password.borderStyle = UITextBorderStyleRoundedRect;
                    password.delegate = self;
                    if (![currentUser password])
                        password.placeholder = @"Password";
                    else
                        password.text = [currentUser password];
                    [cell.contentView addSubview:password];
                    break;
                case 2:
                    cell = [[UITableViewCell alloc]init];
                    cell.textLabel.text = @"Email";
                    email = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    email.borderStyle = UITextBorderStyleRoundedRect;
                    email.delegate = self;
<<<<<<< HEAD
                    //if (![self.account emailAddress])
                      ///  email.placeholder = @"Email";
                    //else
                      //  email.text = [self.account emailAddress];
=======
                    if (![currentUser emailAddress])
                        email.placeholder = @"Email";
                    else
                        email.text = [currentUser emailAddress];
>>>>>>> FETCH_HEAD
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
                    if (![currentUser name])
                        name.placeholder = @"Your Name";
                    else
                        name.text = [currentUser name];
                    [cell.contentView addSubview:name];
                    break;
                case 1:
                    cell = [[UITableViewCell alloc]init];
                    cell.textLabel.text = @"Home";
                    home = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    home.borderStyle = UITextBorderStyleRoundedRect;
                    home.delegate = self;
                    home.placeholder = @"Address, Zipcode";
                    home.text = [currentUser home];
                    [cell.contentView addSubview:home];
                    break;
                case 2:
                    cell = [[UITableViewCell alloc]init];
                    label.text = @"Birthday";
                    birthday = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 10, 320, 100)];
                    birthday.datePickerMode = UIDatePickerModeDate;
                    if (!editingMode){
                        label1.text = [currentUser stringFromBirthday];
                        [cell.contentView addSubview:label1];
                    }
                    if (editingMode){
                        if (currentUser.getBirthday)
                            birthday.date = currentUser.getBirthday;
                        else
                            [cell.contentView addSubview:birthday];
                    }
                    [cell.contentView addSubview:label];
                    break;
                case 3:
                    cell = [[UITableViewCell alloc]init];
                    cell.textLabel.text = @"Gender";
                    break;
                case 4:
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
    [self.tableView performSelector:@selector(beginUpdates) withObject:nil afterDelay:0.5];
    [self.tableView reloadData];
    [self.tableView performSelector:@selector(endUpdates) withObject:nil afterDelay:0.5];
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
    [self.tableView performSelector:@selector(beginUpdates) withObject:nil afterDelay:0.5];
    [self.tableView reloadData];
    [self.tableView performSelector:@selector(endUpdates) withObject:nil afterDelay:0.5];
}

- (void)cancel{
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit)]);
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)]);
    editingMode = NO;
    [self.view endEditing:YES];
    [self.tableView performSelector:@selector(beginUpdates) withObject:nil afterDelay:0.5];
    [self.tableView reloadData];
    [self.tableView performSelector:@selector(endUpdates) withObject:nil afterDelay:0.5];
}

@end
