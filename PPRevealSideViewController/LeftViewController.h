//
//  LeftViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/26/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "Event.h"

@class LeftViewController;

@protocol LeftViewControllerDelegate <NSObject>

- (void)LeftViewControllerDidPop:(LeftViewController *)lv;
- (void)addEvent:(Event*)e;

@end

@interface LeftViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, retain) UIImageView*                  eventPic;

@property (nonatomic, retain) UITextField*                  eName;
@property (nonatomic, retain) UITextField*                  eLocation;
@property (nonatomic, retain) UITextField*                  eDate;

@property (nonatomic, retain) UITextField*                  ePriceN;
@property (nonatomic, retain) UITextField*                  ePriceL;
@property (nonatomic, retain) UITextField*                  ePriceM;
@property (nonatomic, retain) UITextField*                  ePriceH;

@property (nonatomic, retain) UITextView*                     eDiscription;

@property (nonatomic, retain) UITextField*                  rangeL;
@property (nonatomic, retain) UITextField*                  rangeH;

@property (nonatomic, retain) UIButton*                     eDiscrip;
@property (nonatomic, retain) UIButton*                     invite;
@property (nonatomic, retain) UIButton*                     blacklist;

@property (nonatomic, retain) UISlider*                     eCapacity;

@property (nonatomic, retain) UISwitch*                     ageBased;
@property (nonatomic, retain) UISwitch*                     pubPriv;
@property (nonatomic, retain) UISwitch*                     BYOB;

@property (nonatomic, weak) id <LeftViewControllerDelegate> delegate;

@end
