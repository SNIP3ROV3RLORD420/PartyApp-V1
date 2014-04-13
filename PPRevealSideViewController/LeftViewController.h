//
//  LeftViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 4/13/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LeftViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)PFUser *usr;

@end
