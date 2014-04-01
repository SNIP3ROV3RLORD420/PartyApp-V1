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
    
    UIDatePicker *date;
}

@end

@implementation AccountViewController

@synthesize username, password, email, home, name, birthday, gender, interestedIn, usr;

#pragma mark - Class Methods

- (void)updateCurrentUser{
    //use the User *currentUser to update the actual online user
    //this method will be called in the done method
    usr[@"username"] = username.text;
    usr[@"password"] = password.text;
    usr[@"name"] = name.text;
    //currentUser.home = home.text;
        //Have to set this up online before we add, but is this going to be an address? a location?
        //I think location would be best we just need a way to set it.
    usr[@"email"] = email.text;
    //usr[@"birthday"] = birthday.date;
    
    //usr[@"isInterestedInMale"] = [NSNumber numberWithBool:YES];
    //usr[@"isInterestedInMale"] = [NSNumber numberWithBool:NO];
        //Set up logic for this, IDK how pickers work

    
    // currentUser.gender =
        //I dont think this should be changeable...
}


#pragma mark - View Methods

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.tableView.allowsSelection = NO;
    usr = [PFUser currentUser];
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                    target:self
                                    action:@selector(edit)]);
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Back"
                                                                            style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(back)]);
    self.title = @"Profile";
    
    editingMode = NO;
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

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
        cell = PP_AUTORELEASE([[UITableViewCell alloc]init]);
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Username";
                    username = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    username.borderStyle = UITextBorderStyleRoundedRect;
                    username.delegate = self;
                    username.placeholder = @"Username";
                    username.text = usr[@"username"];
                    [cell.contentView addSubview:username];
                    break;
                case 1:
                {
                    cell.textLabel.text = @"Password";
                    password = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    password.borderStyle = UITextBorderStyleRoundedRect;
                    password.delegate = self;
                    password.text = @"(hidden)";
                    password.placeholder = @"Password";
                    password.secureTextEntry = YES;
                    [cell.contentView addSubview:password];
                    break;
                }
                case 2:
                    cell.textLabel.text = @"Email";
                    email = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    email.borderStyle = UITextBorderStyleRoundedRect;
                    email.delegate = self;
                    email.placeholder = @"Email";
                    email.text = usr[@"email"];
                    [cell.contentView addSubview:email];
                    break;
                default:
                    break;
            }
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Name";
                    name = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    name.borderStyle = UITextBorderStyleRoundedRect;
                    name.delegate = self;
                    name.placeholder = @"Your Name";
                    name.text = usr[@"name"];
                    [cell.contentView addSubview:name];
                    break;
                case 1:
                    cell.textLabel.text = @"Home";
                    home = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    home.borderStyle = UITextBorderStyleRoundedRect;
                    home.delegate = self;
                    home.placeholder = @"Address, Zipcode";
                    //home.text = usr[@"home"];
                    [cell.contentView addSubview:home];
                    break;
                case 2:
                    cell.textLabel.text = @"Birthday";
                    
                    birthday = [[UITextField alloc]initWithFrame:CGRectMake(130, 7, 180, 30)];
                    birthday.borderStyle = UITextBorderStyleRoundedRect;
                    birthday.placeholder = @"Date of Birth";
                    birthday.delegate = self;
                    
                    date = [[UIDatePicker alloc]init];
                    date.datePickerMode = UIDatePickerModeDate;
                    date.backgroundColor = [UIColor whiteColor];
                    [date addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
                    
                    [birthday setInputView:date];
                    if (!editingMode){
                        birthday.text = usr[@"birthday"];
                    }
                    if (editingMode){
                        if ( [PFUser currentUser][@"birthday"]  != nil)
                            birthday.text = usr[@"birthday"];
                    }
                    [cell.contentView addSubview:birthday];
                    break;
                case 3:
                    cell.textLabel.text = @"Gender";
                    break;
                case 4:
                    cell.textLabel.text = @"Interested In";
                default:
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
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.revealSideViewController popViewControllerAnimated:YES];
}

- (void)done{
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit)]);
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)]);
        editingMode = NO;
    [self.view endEditing:YES];
    [self updateCurrentUser];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)cancel{
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit)]);
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)]);
    editingMode = NO;
    [self.view endEditing:YES];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)updateTextField:(id)sender{
    UIDatePicker *picker = (UIDatePicker*)birthday.inputView;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    birthday.text = [formatter stringFromDate:picker.date];
}

@end
