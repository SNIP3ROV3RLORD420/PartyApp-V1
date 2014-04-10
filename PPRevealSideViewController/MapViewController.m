//
//  MapViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//

#import "MapViewController.h"
#import "RightViewController.h"
#import "LoginViewController.h"
#import "Comms.h"
#import "CreateViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MapViewController (){
    NSMutableArray *allEvents;
    NSMutableArray *searchArray;
    
    UISearchBar *searchBar;
    
    GMSMapView *map;
}

- (void)updateMap:(NSMutableArray*)allVisibleEvents;
- (NSMutableArray*)processAllEvents:(NSMutableArray*)allEvents;

@end

@implementation MapViewController

@synthesize searchController;

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
    
    [self.revealSideViewController setPanInteractionsWhenOpened:PPRevealSideInteractionNavigationBar];
    [self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionNavigationBar];
    
    [self.revealSideViewController setFakeiOS7StatusBarColor:UIColorFromRGB(0x4c4c4c)];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:34.05
                                                            longitude:-118.25
                                                                 zoom:12];
    
    map = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    //temp marker
    
    UIEdgeInsets mapInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    map.padding = mapInsets;
    
    GMSMarker *losAngeles = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(34.05, -118.25)];
    losAngeles.title = @"Los Angeles";
    losAngeles.map = map;
    map.settings.zoomGestures = NO;
    map.myLocationEnabled = YES;
    map.settings.myLocationButton = YES;
    map.settings.compassButton = YES;
    
    self.view = map;
    
    // Do any additional setup after loading the view.
    UIBarButtonItem *slide = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pushLeft:)];
    
    self.navigationItem.leftBarButtonItem = slide;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    self.title = @"Our App";
    
    UIButton *add = [[UIButton alloc]initWithFrame:CGRectMake(5, 70, 48, 48)];
    [add setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(create:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:add];
    
    //doing search stuff
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, 270, 44)];
    searchBar.placeholder = @"Search";
    
    searchController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelSearch)];
    cancel.tintColor = [UIColor whiteColor];
    searchController.navigationItem.rightBarButtonItem = cancel;
    searchController.delegate = self;
    searchController.searchResultsDataSource = self;
    searchController.searchResultsDelegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Managing Button Methods

- (void)pushLeft:(id)sender{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

- (void)create:(id)sender{
    LeftViewController *lv = [[LeftViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:lv animated:YES];
}

- (void)search{
    [searchController setActive:YES animated:YES];
    [self.view addSubview:searchBar];
    [searchBar becomeFirstResponder];
}

- (void)cancelSearch{
    [searchBar removeFromSuperview];
    [searchController setActive:NO animated:YES];
}

#pragma mark - All Map View Class methods

- (void)updateMap:(NSMutableArray *)allVisibleEvents{
    //this method will take the array from processAllEvents
    //this method will configure the map to display the events
    //will be called when the map is slid up and will be called in the left view controller delegate method leftViewControllerDidFinish
}

- (NSMutableArray*)processAllEvents:(NSMutableArray *)allEvents{
    //this method will process the list of all current events from the server
    //it will return an array of the events that have not passed and should be visible
    //for now return an empty array
    return [NSMutableArray arrayWithObject:nil];
}

#pragma mark - Left View Controller Delegate

- (void)LeftViewControllerDidPop:(LeftViewController *)lv{
    [self updateMap:[self processAllEvents:allEvents]];
}

- (void)addEvent:(Event *)e{
    [allEvents insertObject:e atIndex:0];
    [self updateMap:[self processAllEvents:allEvents]];
}

#pragma mark - Login View Controller Delegate

- (void)loginViewControllerDidFinish:(LoginViewController *)lv{
}

#pragma mark - Map Delegate

#pragma mark - Table View Delegate and Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return searchArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    return cell;
}

#pragma mark - Search Display Controller Delegate

@end
