//
//  MyEventsViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/29/14.
//
//

#import "MyEventsViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MyEventsViewController (){
    NSMutableArray *myEvents;
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
    
    //setting the navigation bar
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back"
                                                                    style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(back)];
    self.title = @"My Events";
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    [refresh setTintColor:UIColorFromRGB(0x34B085)];
    [refresh addTarget:self action:@selector(getEvents) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    //set myEvents to some serverside list of events that this user is currently a host of
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return myEvents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.indentationLevel = 7;
    return cell;
}

#pragma mark - Button Methods

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [self.revealSideViewController popViewControllerAnimated:YES];
}

#pragma mark - Refresher Methods

- (void)getEvents{
    [self performSelector:@selector(updateTable) withObject:self afterDelay:1.0];
}

- (void)updateTable{
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

@end
