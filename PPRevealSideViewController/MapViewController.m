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
#import "LeftViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController (){
    NSMutableArray *allEvents;
    
    BOOL preloadedRight;
    BOOL preloadedLeft;
}

- (void)updateMap:(NSMutableArray*)allVisibleEvents;
- (NSMutableArray*)processAllEvents:(NSMutableArray*)allEvents;

@end

@implementation MapViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                                longitude:151.20
                                                                     zoom:6];
        
        GMSMapView *map = [GMSMapView mapWithFrame:CGRectMake(0, 64, 320, 504) camera:camera];
        map.myLocationEnabled = YES;
        
        [self.view addSubview:map];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Slide"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(pushRight:)]);
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Create"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(create:)]);
    self.title = @"Our App";
    [self performSelector:@selector(pushLogin) withObject:nil afterDelay:.5];
    preloadedLeft = NO;
    preloadedRight = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)preloadLeft{
    if (!preloadedLeft){
        LeftViewController *lv = [[LeftViewController alloc]initWithStyle:UITableViewStyleGrouped];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:lv];
        [self.revealSideViewController preloadViewController:nav forSide:PPRevealSideDirectionLeft];
        PPRSLog(@"Preloaded Left View");
        PP_AUTORELEASE(nav);
        preloadedLeft = YES;
    }
    else
        NSLog(@"Left Already Preloaded!");
}

- (void)preloadRight{
    if (!preloadedRight){
        RightViewController *c = [[RightViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:c];
        [self.revealSideViewController preloadViewController:nav forSide:PPRevealSideDirectionRight];
        PPRSLog(@"Preloaded Right View");
        PP_AUTORELEASE(nav);
        preloadedRight = YES;
    }
    else
        NSLog(@"Right Already Preloaded!");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //implement later --> Make it so the view isnt preloaded until after the login is complete to save memory
    //for now just preload anyways :p
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preloadRight) object:nil];
    [self performSelector:@selector(preloadRight) withObject:nil afterDelay:0.3];
    [self performSelector:@selector(preloadLeft) withObject:nil afterDelay:0.4];
}
#pragma mark - Managing Button Methods

- (void)pushRight:(id)sender{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionRight animated:YES];
}

- (void)create:(id)sender{
    [self.revealSideViewController openCompletelySide:PPRevealSideDirectionLeft animated:YES];
}

#pragma mark - Navigation

- (void)pushLogin{
    LoginViewController *lv = [[LoginViewController alloc]init];
    [self.navigationController presentViewController:lv animated:YES completion:^{PPRSLog(@"Popped login")}];
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

@end
