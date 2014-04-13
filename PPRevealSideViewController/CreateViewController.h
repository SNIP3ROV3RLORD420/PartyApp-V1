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

@class CreateViewController;

@protocol LeftViewControllerDelegate <NSObject>

- (void)LeftViewControllerDidPop:(CreateViewController *)lv;
- (void)addEvent:(Event*)e;

@end

@interface CreateViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIImageView*                  eventPic;

@property (nonatomic, strong) UITextField*                  eName;
@property (nonatomic, strong) UITextField*                  eLocation;
@property (nonatomic, strong) UITextField*                  eDate;

@property (nonatomic, strong) UITextField*                  ePriceN;
@property (nonatomic, strong) UITextField*                  ePriceL;
@property (nonatomic, strong) UITextField*                  ePriceM;
@property (nonatomic, strong) UITextField*                  ePriceH;

@property (nonatomic, strong) UITextView*                   eDiscription;

@property (nonatomic, strong) UITextField*                  rangeL;
@property (nonatomic, strong) UITextField*                  rangeH;

@property (nonatomic, strong) UIButton*                     eDiscrip;
@property (nonatomic, strong) UIButton*                     invite;
@property (nonatomic, strong) UIButton*                     blacklist;

@property (nonatomic, strong) UISlider*                     eCapacity;

@property (nonatomic, strong) UISwitch*                     ageBased;
@property (nonatomic, strong) UISwitch*                     pubPriv;
@property (nonatomic, strong) UISwitch*                     BYOB;

@property (nonatomic, weak) id <LeftViewControllerDelegate> delegate;

@end
