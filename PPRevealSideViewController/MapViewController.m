//
//  MapViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//

#import "MapViewController.h"
#import "RightViewController.h"

@interface MapViewController (){
    MKMapView *map;
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)preloadLeft {
    RightViewController *c = [[RightViewController alloc] init];
    [self.revealSideViewController preloadViewController:c forSide:PPRevealSideDirectionRight];
    PP_RELEASE(c);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(preloadLeft) object:nil];
    [self performSelector:@selector(preloadLeft) withObject:nil afterDelay:0.3];
}

#pragma mark - Managing Button Methods

- (void)pushRight:(id)sender{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionRight animated:YES];
}

- (void)create:(id)sender{
    
}

@end
