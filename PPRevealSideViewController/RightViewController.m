//
//  RightViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//
//

#import "RightViewController.h"
#import "AccountViewController.h"
#import "MyEventsViewController.h"
#import "MapViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface RightViewController (){
    PFUser *usr;
    
    NSMutableArray *hostEvents;
    NSMutableArray *invitedEvents;
}

@end

@implementation RightViewController

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
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 100);
    
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
        return 50;
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

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"hosting";
    }
    if (section == 2) {
        return @"invited";
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 5;
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
        
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    view.backgroundColor = UIColorFromRGB(0x323232);
    
    UIImageView *pic = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    pic.image = [UIImage imageNamed:@"sampleProf.png"];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, 200, 40)];
    name.text = usr[@"name"]; //not working which is weird
    if (!name.text)
        name.text = @"Display Name";
    name.textColor = [UIColor whiteColor];
    
    [view addSubview:pic];
    [view addSubview:name];
        
        return view;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 22)];
    view.backgroundColor = UIColorFromRGB(0x323232);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 200, 22)];
    label.textColor = UIColorFromRGB(0xa6a6a6);
    if (section == 1) {
        label.text = @"HOSTING";
    }
    if (section == 2) {
        label.text = @"INVITED TO";
    }
    [view addSubview:label];
    
    return view;
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
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"My Account";
                cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
                [cell setSelectedBackgroundView:bc];
                cell.textLabel.highlightedTextColor = [UIColor whiteColor];
                cell.backgroundColor = UIColorFromRGB(0x323232);
                break;
            case 1:
                cell.textLabel.text = @"Map";
                cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
                [cell setSelectedBackgroundView:bc];
                cell.textLabel.highlightedTextColor = [UIColor whiteColor];
                cell.backgroundColor = UIColorFromRGB(0x323232);
                break;
            case 2:
                cell.textLabel.text = @"Other";
                cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
                [cell setSelectedBackgroundView:bc];
                cell.textLabel.highlightedTextColor = [UIColor whiteColor];
                cell.backgroundColor = UIColorFromRGB(0x323232);
                break;
            case 3:
                cell.textLabel.text = @"Settings";
                cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
                [cell setSelectedBackgroundView:bc];
                cell.textLabel.highlightedTextColor = [UIColor whiteColor];
                cell.backgroundColor = UIColorFromRGB(0x323232);
                break;
            case 4:
                cell.textLabel.text = @"About";
                cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
                [cell setSelectedBackgroundView:bc];
                cell.textLabel.highlightedTextColor = [UIColor whiteColor];
                cell.backgroundColor = UIColorFromRGB(0x323232);
                break;
            default:
                break;
        }
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            [arr addObject:[NSIndexPath indexPathForRow:1 inSection:0]];
            [arr addObject:[NSIndexPath indexPathForRow:2 inSection:0]];
            [arr addObject:[NSIndexPath indexPathForRow:3 inSection:0]];
            [arr addObject:[NSIndexPath indexPathForRow:4 inSection:0]];
            
            AccountViewController *av = [[AccountViewController alloc]initWithStyle:UITableViewStyleGrouped];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:av];
            [self.revealSideViewController popViewControllerWithNewCenterController:nav animated:YES];
            [self.tableView cellForRowAtIndexPath:indexPath].backgroundColor = UIColorFromRGB(0x191919);
            
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        }
        if (indexPath.row == 1) {
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            [arr addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
            [arr addObject:[NSIndexPath indexPathForRow:2 inSection:0]];
            [arr addObject:[NSIndexPath indexPathForRow:3 inSection:0]];
            [arr addObject:[NSIndexPath indexPathForRow:4 inSection:0]];
            
            MapViewController *mv = [[MapViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mv];
            [self.revealSideViewController popViewControllerWithNewCenterController:nav animated:YES];
            [self.tableView cellForRowAtIndexPath:indexPath].backgroundColor = UIColorFromRGB(0x191919);
            
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        }
    }
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
    NSMutableArray *allEvents = [[NSMutableArray alloc]init]; //some method or online database of events
    hostEvents = [self getEventsHostOf:allEvents];
    invitedEvents = [self getEventsInvitedTo:allEvents];
}

#pragma mark - Event Methods

- (NSMutableArray*)getEventsHostOf:(NSArray*)allEvents{
    NSMutableArray *hostOf = [[NSMutableArray alloc]init];
#warning This method will start taking longer and longer the more events there are, but to start out should be fine
    for (Event* e in allEvents) {
        for (PFUser* user in e.hosts) {
            if ([user[@"name"] isEqualToString:[PFUser currentUser][@"name"]]) {
                [hostOf addObject:e];
            }
        }
    }
    return hostOf;
}

- (NSMutableArray*)getEventsInvitedTo:(NSArray*)allEvents{
    NSMutableArray* invitedTo = [[NSMutableArray alloc]init];
#warning This method will start taking longer and longer the more events there are, but to start out should be fine
    for (Event* e in allEvents) {
        for (PFUser* user in e.invited) {
            if ([user[@"name"] isEqualToString:[PFUser currentUser][@"name"]]) {
                [invitedTo addObject:e];
            }
        }
    }
    return invitedTo;
}


@end
