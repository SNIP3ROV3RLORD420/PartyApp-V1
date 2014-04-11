//
//  RightViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//
//

#import <Parse/Parse.h>
#import "User.h"
#import <UIKit/UIKit.h>

@class RightViewController;

@protocol RightViewControllerDelegate <NSObject>

- (void)RightViewControllerDidPop:(RightViewController*)rv;

@end

@interface RightViewController : UITableViewController

@property (nonatomic, weak) PFUser *usr;

@property (nonatomic, strong) id <RightViewControllerDelegate> delegate;

@end
