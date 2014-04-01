//
//  FreindListViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/29/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FreindListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UISegmentedControl *lists;

@property (nonatomic, weak) PFUser *usr;

@end
