//
//  LeftViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/21/14.
//
//

#import <UIKit/UIKit.h>
#import "Event.h"

@class LeftViewController;

@protocol LeftViewControllerDelegate <NSObject>

- (void)leftViewControllerDidFinish:(LeftViewController*)lv withEvent:(Event*)e;
- (void)leftViewControllerDidCancel:(LeftViewController*)lv;

@end

@interface LeftViewController : UITableViewController

@property (nonatomic, weak) UITextField *eName;
@property (nonatomic, weak) UITextField *eLocation;

@property (nonatomic, weak) UIDatePicker *eDate;

@property (nonatomic, weak) UISlider *eCapacity;

@property (weak, nonatomic) id <LeftViewControllerDelegate> delegate;

@end
