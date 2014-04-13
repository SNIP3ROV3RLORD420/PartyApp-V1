//
//  MapViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LoginViewController.h"
#import "RightViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "CreateViewController.h"

@interface MapViewController : UIViewController <RightViewControllerDelegate, LoginViewControllerDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (strong, nonatomic) UISearchDisplayController *searchController;

@property (strong, nonatomic) GMSMapView *map;

@end
