//
//  LeftViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/26/14.
//
//

#import <UIKit/UIKit.h>
#import "Event.h"

@class LeftViewController;

@protocol LeftViewControllerDelegate <NSObject>

- (void)LeftViewControllerDidCancel:(LeftViewController *)lv;
- (void)LeftViewControllerDidfinish:(LeftViewController *)lv withEvent:(Event *)e;

@end

@interface LeftViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) UIImageView*                  eventPic;

@property (nonatomic, retain) UITextField*                  eName;
@property (nonatomic, retain) UITextField*                  eLocation;
@property (nonatomic, retain) UITextField*                  ePrice;

@property (nonatomic, retain) UIButton*                     eDiscrip;
@property (nonatomic, retain) UIButton*                     invite;
@property (nonatomic, retain) UIButton*                     blacklist;
@property (nonatomic, retain) UIButton*                     eDate;

@property (nonatomic, retain) UISlider*                     eCapacity;

@property (nonatomic, retain) UISwitch*                     ageBased;
@property (nonatomic, retain) UISwitch*                     pubPriv;

@property (nonatomic, weak) id <LeftViewControllerDelegate> delegate;

@end
