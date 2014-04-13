//
//  RightViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//
//

#import "RightViewController.h"
#import "AccViewController.h"
#import "SettingsViewController.h"
#import "MapViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface RightViewController (){
    NSMutableArray *hostEvents;
    NSMutableArray *invitedEvents;
}

@end

@implementation RightViewController

@synthesize usr;

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
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 320);
    
    self.view.backgroundColor = UIColorFromRGB(0x4c4c4c);
    self.tableView.backgroundColor = UIColorFromRGB(0x323232);
    
    self.tableView.separatorColor = [UIColor whiteColor];
    
    usr = [PFUser currentUser];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    [refresh setTintColor:[UIColor whiteColor]];
    [refresh addTarget:self action:@selector(getEvents) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    /*
     
     NSMutableArray *allEvents = some method or online database of events
     hostEvents = [self getEventsHostOf:allEvents];
     invitedEvents = [self getEventsInvitedTo:allEvents];
     
     */
    NSLog(@"Loaded Side View");
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self performSelector:@selector(hide) withObject:self afterDelay:.1];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return .5;
    }
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }
    return 22;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        if (hostEvents.count == 0) {
            return 1;
        }
        return hostEvents.count;
    }
    if (section == 2) {
        if (invitedEvents.count == 0) {
            return 1;
        }
        return invitedEvents.count;
    }
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        //customizing the initial view
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 50)];
        view.backgroundColor = UIColorFromRGB(0x323232);
        
        //making the left view
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        leftView.backgroundColor = UIColorFromRGB(0x323232);
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        image.image = [UIImage imageNamed:@"sampleProf.png"];
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 120, 40)];
        name.text = usr[@"name"];
        name.textColor = [UIColor whiteColor];
        if (!name.text) {
            name.text = @"Your Name";
        }
        name.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [leftView addSubview:image];
        [leftView addSubview:name];
        
        [view addSubview:leftView];
        
        //making the right view
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(200, 0, 100, 50)];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        [button setImage:[UIImage imageNamed:@"logOut.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        
        [rightView addSubview:button];
        [view addSubview:rightView];
        
        return view;
    }
    return nil;
}


- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"Hosting";
    }
    if (section == 2) {
        return @"Invited To";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = PP_AUTORELEASE([[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 200, 50)]);
    }
    
    UIView *bc = [[UIView alloc]initWithFrame:CGRectMake(5, 0, 100, 50)];
    bc.backgroundColor = UIColorFromRGB(0x191919);
    
    if (indexPath.section == 1) {
        if (hostEvents.count == 0) {
            cell.textLabel.text = @"Not Hosting Any";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = UIColorFromRGB(0x323232);
        }
        else{
            cell.textLabel.text = [[hostEvents objectAtIndex:indexPath.row] eventName];
            cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
            cell.backgroundColor = UIColorFromRGB(0x323232);
        }
    }
    if (indexPath.section == 2) {
        if (invitedEvents.count == 0) {
            cell.textLabel.text = @"Not Invited to Any";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = UIColorFromRGB(0x323232);
        }
        else{
            cell.textLabel.text = [[invitedEvents objectAtIndex:indexPath.row] eventName];
            cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
            cell.backgroundColor = UIColorFromRGB(0x323232);
        }
    }
    return cell;
}

#pragma mark - Anonymous

- (void)hide{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - Refresher Methods

- (void)getEvents{
    [self performSelector:@selector(updateTable) withObject:self afterDelay:1.0];
}

- (void)updateTable{
    
    [self updateEventLists];
    NSIndexSet *iS = [NSIndexSet indexSetWithIndex:1];
    NSIndexSet *iSS = [NSIndexSet indexSetWithIndex:2];
    [self.tableView reloadSections:iS withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadSections:iSS withRowAnimation:UITableViewRowAnimationFade];
    [self.refreshControl endRefreshing];
}

- (void)updateEventLists{
}

#pragma mark - Button Methods

- (void)logOut{
    LoginViewController *lv = [[LoginViewController alloc]init];
    [self.revealSideViewController popViewControllerWithNewCenterController:lv animated:YES];
}
@end
