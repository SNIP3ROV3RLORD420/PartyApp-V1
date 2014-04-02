//
//  MyEventsViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/29/14.
//
//

#import "MyEventsViewController.h"
#import "Event.h"
#import <Parse/Parse.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MyEventsViewController (){
    NSMutableArray *hostEvents;
    NSMutableArray *invitedEvents;
}

@end

@implementation MyEventsViewController

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
    
    self.view.backgroundColor = UIColorFromRGB(0x4c4c4c);
    self.tableView.backgroundColor = UIColorFromRGB(0x323232);
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    [refresh setTintColor:[UIColor whiteColor]];
    [refresh addTarget:self action:@selector(getEvents) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    /*
     
     NSMutableArray *allEvents = some method or online database of events
     hostEvents = [self getEventsHostOf:allEvents];
     invitedEvents = [self getEventsInvitedTo:allEvents];
     
     */
}

- (void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (hostEvents.count == 0) {
            return 1;
        }
        return hostEvents.count;
    }
    else{
        if (invitedEvents.count == 0) {
            return 1;
        }
        return invitedEvents.count;
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"                Hosting";
    }
    else
        return @"                Invited To";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)
        return 30;
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(50, 0, 270, 44)];
    }
    if (indexPath.section == 0) {
        if (hostEvents.count == 0) {
            cell.textLabel.text = @"Currently None";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = UIColorFromRGB(0x323232);
        }
        else{
            //do all that stuff with the events and what not
        }
    }
    if (indexPath.section == 1) {
        if (invitedEvents.count == 0) {
            cell.textLabel.text = @"Currently None";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = UIColorFromRGB(0x323232);
        }
        else{
            //do all that stuff with the events and what not
        }
    }
    cell.indentationLevel = 7;
    return cell;
}

#pragma mark - Button Methods

- (void)pushLeft{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

#pragma mark - Refresher Methods

- (void)getEvents{
    [self performSelector:@selector(updateTable) withObject:self afterDelay:1.0];
}

- (void)updateTable{
    
    [self updateEventLists];
    [self.tableView reloadData];
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
        for (PFUser* usr in e.hosts) {
            if ([usr[@"name"] isEqualToString:[PFUser currentUser][@"name"]]) {
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
        for (PFUser* usr in e.invited) {
            if ([usr[@"name"] isEqualToString:[PFUser currentUser][@"name"]]) {
                [invitedTo addObject:e];
            }
        }
    }
    return invitedTo;
}

@end
