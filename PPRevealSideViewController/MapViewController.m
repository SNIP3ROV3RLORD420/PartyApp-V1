//
//  MapViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//

#import "MapViewController.h"
#import "LoginViewController.h"
#import "Comms.h"
#import "CreateViewController.h"
#import <Parse/Parse.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MapViewController (){
    MKLocalSearchResponse *results;
    MKLocalSearch *localSearch;
    
    UISearchBar *searchBar;
}
@end

@implementation MapViewController

@synthesize searchController, map;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.revealSideViewController setPanInteractionsWhenOpened:PPRevealSideInteractionNavigationBar];
    [self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionNavigationBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.revealSideViewController setPanInteractionsWhenOpened:PPRevealSideInteractionNavigationBar];
    [self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionNavigationBar];
    
    [self.revealSideViewController setFakeiOS7StatusBarColor:[UIColor blackColor]];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:34.05
                                                            longitude:-118.25
                                                                 zoom:12];
    
    map = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    map.padding = UIEdgeInsetsMake(64, 0, 44, 0);
    map.myLocationEnabled = YES;
    map.settings.myLocationButton = YES;
    map.settings.compassButton = YES;
    
    self.view = map;
    
    // Do any additional setup after loading the view.
    UIBarButtonItem *slide = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu.png"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(pushLeft:)];
    
    self.navigationItem.leftBarButtonItem = slide;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                          target:self
                                                                                          action:@selector(search)];
    self.title = @"Map";
    
    UIButton *add = [[UIButton alloc]initWithFrame:CGRectMake(5, 70, 48, 48)];
    [add setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(create:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:add];
    
    //doing search stuff
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, 270, 44)];
    searchBar.placeholder = @"Search";
    searchBar.delegate = self;
    
    searchController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                           target:self
                                                                           action:@selector(cancelSearch)];
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
    CreateViewController *lv = [[CreateViewController alloc]initWithStyle:UITableViewStyleGrouped];
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

#pragma mark - Login View Controller Delegate

- (void)loginViewControllerDidFinish:(LoginViewController *)lv{
}

#pragma mark - Table View Delegate and Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return results.mapItems.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    
    MKMapItem *item = results.mapItems[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.placemark.addressDictionary[@"Street"];
    
    return cell;
}

#pragma mark - Search Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    // Cancel any previous searches.
    [localSearch cancel];
    
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    
    // Perform a new search.
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchText;
    request.region = MKCoordinateRegionMake(currentLoc.placemark.location.coordinate, MKCoordinateSpanMake(1000, 1000));
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        results = response;
        
        [searchController.searchResultsTableView reloadData];
    }];
    
}


@end
