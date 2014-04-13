//
//  LeftViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 4/13/14.
//
//

#import "LeftViewController.h"
#import "LoginViewController.h"
#import "Event.h"
#import "ODRefreshControl.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LeftViewController (){
    UITableView *events;
    
    NSMutableArray *invitedTo;
    NSMutableArray *hosting;
    
    ODRefreshControl *refresh;
}

@end

@implementation LeftViewController

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
    
    self.usr = [PFUser currentUser];
    self.view.backgroundColor = UIColorFromRGB(0x4c4c4c);
    
//-----------------------------Creating the Table View-----------------------------------------------
    
    //creating the table view
    events = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, 320, 498) style:UITableViewStyleGrouped];
    events.separatorColor = [UIColor whiteColor];
    events.backgroundColor = UIColorFromRGB(0x323232);
    events.dataSource = self;
    events.delegate = self;
    
    [self.view addSubview:events];
    
    //creating the refresh control
    refresh = [[ODRefreshControl alloc]initInScrollView:events];
    refresh.tintColor = [UIColor whiteColor];
    [refresh addTarget:self action:@selector(getEvents) forControlEvents:UIControlEventValueChanged];
    
//-----------------------------Creating the Header View----------------------------------------------
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 50)];
    view.backgroundColor = UIColorFromRGB(0x323232);
    
    //making the left view
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    leftView.backgroundColor = UIColorFromRGB(0x323232);
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    image.image = [UIImage imageNamed:@"sampleProf.png"];
    [leftView addSubview:image];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 120, 40)];
    name.text = self.usr[@"name"];
    name.textColor = [UIColor whiteColor];
    if (!name.text) {
        name.text = @"Your Name";
    }
    name.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [leftView addSubview:name];
    
    [view addSubview:leftView];
    
    //making the right view
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(200, 0, 100, 50)];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    [button setImage:[UIImage imageNamed:@"logOut.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button];
    
    [view addSubview:rightView];
    
    [self.view addSubview:view];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View DataSource and Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        if (hosting.count == 0) {
            return 1;
        }
        return hosting.count;
    }
    if (section == 1){
        if (invitedTo.count == 0) {
            return 1;
        }
        return invitedTo.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0)
        return @"Hosting";
    if (section == 1)
        return @"Invited To";
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
        cell = [[UITableViewCell alloc]init];
    
    cell.backgroundColor = UIColorFromRGB(0x323232);
    
    if (indexPath.section == 0) {
        if (hosting.count == 0){
            cell.textLabel.text = @"Not Hosting Any :(";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else{
            cell.textLabel.text = [[hosting objectAtIndex:indexPath.row] eventName];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if (indexPath.section == 1) {
        if (invitedTo.count == 0){
            cell.textLabel.text = @"Not Invited To Any :(";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else{
            cell.textLabel.text = [[invitedTo objectAtIndex:indexPath.row] eventName];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}

#pragma mark - Refresher Methods

- (void)getEvents{
    [self performSelector:@selector(updateTable) withObject:self afterDelay:1.0];
}

- (void)updateTable{
    
    [self updateEventLists];
    [events reloadData];
    [refresh endRefreshing];
}

- (void)updateEventLists{
    //do some methods to update the current event database
}

#pragma mark - Button Methods

- (void)logOut{
    LoginViewController *lv = [[LoginViewController alloc]init];
    [self.revealSideViewController popViewControllerWithNewCenterController:lv animated:YES];
}

@end
