//
//  AccViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 4/7/14.
//
//

#import "AccViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AccViewController (){
    UITableView *section1;
    UITableView *section2;
    
    UIPickerView *picker;
    
    NSArray *pickerList;
}

@end

@implementation AccViewController

@synthesize username, usr, password, home, InterestedIn, profPic, email, firstName, lastName;

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
    
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    usr = [PFUser currentUser];
    
    [self.revealSideViewController setPanInteractionsWhenOpened:PPRevealSideInteractionNavigationBar | PPRevealSideInteractionContentView];
    [self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionContentView | PPRevealSideInteractionNavigationBar];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(edit)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(pushLeft)];
    pickerList = [[NSArray alloc]initWithObjects:@"Male",@"Female",@"Both", nil];
    
    //adding the image view
    profPic = [[UIImageView alloc]initWithFrame:CGRectMake(5, 69, 100, 100)];
    profPic.image = [UIImage imageNamed:@"sampleProf.png"];
    profPic.layer.borderWidth = .5;
    profPic.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:profPic];
    
    //adding the first table view
    section1 = [[UITableView alloc]initWithFrame:CGRectMake(110, 69, 205, 100)];
    section1.layer.cornerRadius = 3;
    section1.layer.borderWidth = .5;
    section1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    section1.separatorInset = UIEdgeInsetsZero;
    section1.scrollEnabled = NO;
    section1.delegate = self;
    section1.dataSource = self;
    [self.view addSubview:section1];
    
    //adding the second table view
    section2 = [[UITableView alloc]initWithFrame:CGRectMake(5, 200 , 310, 50 * 5)];
    section2.layer.cornerRadius = 3;
    section2.layer.borderWidth = .5;
    section2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    section2.separatorInset = UIEdgeInsetsZero;
    section2.scrollEnabled = NO;
    section2.delegate = self;
    section2.dataSource = self;
    [self.view addSubview:section2];
    
    self.title = @"My Profile";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Methods

- (void)pushLeft{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

- (void)edit{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(done)];
    self.editing = YES;
}

- (void)done{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(edit)];
    self.editing = NO;
    [section1 endEditing:YES];
    [section2 endEditing:YES];
}

#pragma mark - Table View Data Source and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == section1){
        return 2;
    }
    if (tableView == section2){
        return 5;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == section1) {
        NSString *name = usr[@"name"];
        NSArray *names = [name componentsSeparatedByString:@" "];
        switch (indexPath.row) {
            case 0:
                firstName = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, cell.bounds.size.width, cell.bounds.size.height)];
                firstName.placeholder = @"First Name";
                firstName.text = [names objectAtIndex:0];
                firstName.returnKeyType = UIReturnKeyDone;
                firstName.font = [UIFont fontWithName:@"Arial" size:20];
                firstName.delegate = self;
                [cell.contentView addSubview:firstName];
                break;
            case 1:
                lastName = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, cell.bounds.size.width, cell.bounds.size.height)];
                lastName.placeholder = @"Last Name";
                lastName.text = [names objectAtIndex:1];
                lastName.font = [UIFont fontWithName:@"Arial" size:20];
                lastName.returnKeyType = UIReturnKeyDone;
                lastName.delegate = self;
                [cell.contentView addSubview:lastName];
                break;
            default:
                break;
        }
    }
    if (tableView == section2) {
        switch (indexPath.row) {
            case 0:
                username = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, cell.bounds.size.width, cell.bounds.size.height)];
                username.placeholder = @"Username";
                username.text = usr[@"username"];
                username.font = [UIFont fontWithName:@"Arial" size:20];
                username.returnKeyType = UIReturnKeyDone;
                username.delegate = self;
                [cell.contentView addSubview:username];
                break;
            case 1:
                password = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, cell.bounds.size.width, cell.bounds.size.height)];
                password.secureTextEntry = YES;
                password.placeholder = @"Password";
                password.text = usr[@"password"];
                password.font = [UIFont fontWithName:@"Arial" size:20];
                password.returnKeyType = UIReturnKeyDone;
                password.delegate = self;
                [cell.contentView addSubview:password];
                break;
            case 2:
                home = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, cell.bounds.size.width, cell.bounds.size.height)];
                home.placeholder = @"Search For Your Home";
                //home.text = usr[@"home"];
                home.font = [UIFont fontWithName:@"Arial" size:20];
                home.returnKeyType = UIReturnKeyDone;
                home.delegate = self;
                [cell.contentView addSubview:home];
                break;
            case 3:
                email = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, cell.bounds.size.width, cell.bounds.size.height)];
                email.placeholder = @"Your Email Address";
                email.text = usr[@"email"];
                email.font = [UIFont fontWithName:@"Arial" size:20];
                email.returnKeyType = UIReturnKeyDone;
                email.delegate = self;
                [cell.contentView addSubview:email];
                break;
            case 4:
                InterestedIn = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, cell.bounds.size.width, cell.bounds.size.height)];
                break;
            default:
                break;
        }
    }
    return cell;
}

#pragma mark - UITextfieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.editing)
        return YES;
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == password || textField == username){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                       message:@"Username and password are final and cannot be changed"
                                                      delegate:nil
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles: nil];
    [alert show];
    [textField endEditing:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}

#pragma mark - UIPickerViewDelegate


@end
