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
#import "LeftViewController.h"

@interface MapViewController (){
    MKMapView *map;
    NSMutableArray *allEvents;
}

- (void)updateMap:(NSMutableArray*)allVisibleEvents;
- (NSMutableArray*)processAllEvents:(NSMutableArray*)allEvents;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        map = PP_AUTORELEASE([[MKMapView alloc]initWithFrame:CGRectMake(0, 64, 320, 504)]);
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
    [self performSelector:@selector(pushLogin) withObject:nil afterDelay:1.5];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preloadRight) object:nil];
    [self performSelector:@selector(preloadRight) withObject:nil afterDelay:0.3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)preloadRight{
    RightViewController *c = [[RightViewController alloc] init];
    [self.revealSideViewController preloadViewController:c forSide:PPRevealSideDirectionRight];
    PPRSLog(@"Preloaded Right View");
    PP_AUTORELEASE(c);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //implement later --> Make it so the view isnt preloaded until after the login is complete to save memory
    //for now just preload anyways :p
}

#pragma mark - Managing Button Methods

- (void)pushRight:(id)sender{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionRight animated:YES];
}

- (void)create:(id)sender{
    LeftViewController *lv = [[LeftViewController alloc]init];
    [self.navigationController pushViewController:lv animated:YES];
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
    //will be called when the map is slid up and will be called in the left view controller delegate method leftViewController Did Finish
}

- (NSMutableArray*)processAllEvents:(NSMutableArray *)allEvents{
    //this method will process the list of all current visible events from the server
    //it will return an array of the events that have not passed and should be visible
    //for now return and empty array
    return [NSMutableArray arrayWithObject:nil];
}

#pragma mark - Left View Controller Delegate

- (void)leftViewControllerDidCancel:(LeftViewController *)lv{
    [lv dismissViewControllerAnimated:YES completion:^{PPRSLog(@"Canceled")}];
}

- (void)leftViewControllerDidFinish:(LeftViewController *)lv withEvent:(Event *)e{
    [allEvents insertObject:e atIndex:0];
    [self updateMap:[self processAllEvents:allEvents]];
}

@end
