//
//  LeftViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/26/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//
//

#import "LeftViewController.h"
#import "FreindListViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LeftViewController ()

@end

@interface LeftViewController (){
    UIImage *image;
    
    UILabel *discription;
    
    UILabel *capacityNum;
    UILabel *capacity;
    
    UILabel *dash;
    
    UIDatePicker *dateAndTime;
    
    UIPickerView *prices;
    UINavigationBar *pickerBar;
    NSArray *pickerArray;
    
    NSString *theRetainedDescription;
    
    BOOL expanded;
}

@end

@implementation LeftViewController

@synthesize eventPic, eCapacity, eDiscrip, eDiscription, eLocation, ePriceN, ePriceL, ePriceM, ePriceH, eName, eDate, invite, ageBased, pubPriv, blacklist, rangeH, rangeL, BYOB;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.allowsSelection = NO;
    
    //setting the bar that pops up when a textfield begins editing
    pickerBar = PP_AUTORELEASE([[UINavigationBar alloc]initWithFrame:CGRectMake( 0, 0, 320, 30)]);
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *pickerItem = [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                                  style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(pickerDone)];
    UINavigationItem *navItem = [[UINavigationItem alloc]init];
    navItem.rightBarButtonItem = pickerItem;
    pickerBar.items = [NSArray arrayWithObjects:navItem, nil];
    
    //setting the picker array
    pickerArray = [[NSArray alloc]initWithObjects:
                   @"$0.00",
                   @"$1.00",
                   @"$2.00",
                   @"$3.00",
                   @"$3.00",
                   @"$4.00",
                   @"$5.00",
                   @"$6.00",
                   @"$7.00",
                   @"$8.00",
                   @"$9.00",
                   @"$10.00",
                   @"$15.00",
                   @"$20.00",
                   @"$25.00",
                   @"$30.00",
                   @"$35.00",
                   @"$40.00",
                   nil];
    
    //setting the navigation bar
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Host"
                                                                               style:UIBarButtonItemStyleDone
                                                                              target:self
                                                                              action:@selector(create:)]);
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                             target:self
                                                                                             action:@selector(cancel:)]);
    self.title = @"Host Event";
}

- (void)viewDidAppear:(BOOL)animated{
    [self.revealSideViewController openCompletelyAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            if (ageBased.on)
                return 5;
            return 1;
        case 2:
            return 4;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        
        if (indexPath.row == 0)
        {
            return 110;
        }
        if (indexPath.row == 1)
        {
            if (expanded) {
                return 150;
            }
            return 44;
        }
        if (indexPath.row == 2)
        {
            return 44;
        }
    }
    
    if (indexPath.section == 1){
        return 44;
    }
    
    if (indexPath.section == 2){
        
        if (indexPath.row == 0)
        {
            return 44;
        }
        if (indexPath.row == 1)
        {
            if (pubPriv.on) {
                return 44;
            }
            return 75;
        }
        if (indexPath.row == 2){
            return 44;
        }
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell)
        cell = PP_AUTORELEASE([[UITableViewCell alloc]init]);

    if (indexPath.section == 0){
            switch (indexPath.row) {
                case 0:
                    //adding the image view
                    eventPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 100, 100)];
                    image = [UIImage imageNamed:@"EPhoto(edit).png"];
                    [eventPic setImage:image];
                    
                    //adding the Event Name text field
                    if (!(ageBased.on)) {
                        eName = [[UITextField alloc]initWithFrame:CGRectMake(120, 5.333333, 185, 33)];
                    }
                    else
                        eName = [[UITextField alloc]initWithFrame:CGRectMake(120, 10, 185, 40)];
                    eName.placeholder = @"Event Name";
                    eName.borderStyle = UITextBorderStyleNone;
                    eName.returnKeyType = UIReturnKeyDone;
                    eName.backgroundColor = [UIColor whiteColor];
                    eName.delegate = self;
                    
                    //adding the Event Location text field
                    if (!(ageBased.on))
                        eLocation = [[UITextField alloc]initWithFrame:CGRectMake(120, 38.333333, 185, 33)];
                    else
                        eLocation = [[UITextField alloc]initWithFrame:CGRectMake(120, 60, 185, 40)];
                    eLocation.placeholder = @"Address, Zipcode";
                    eLocation.borderStyle = UITextBorderStyleNone;
                    eLocation.returnKeyType = UIReturnKeyDone;
                    eLocation.backgroundColor = [UIColor whiteColor];
                    eLocation.delegate = self;
                    
                    //adding the Event price text field
                    if (!(ageBased.on)) {
                        ePriceN = [[UITextField alloc]initWithFrame:CGRectMake(120, 71.333333, 185, 33)];
                        ePriceN.placeholder = @"Event Price";
                        ePriceN.borderStyle = UITextBorderStyleNone;
                        ePriceN.backgroundColor = [UIColor whiteColor];
                        ePriceN.inputAccessoryView = pickerBar;
                        ePriceN.delegate = self;
                        
                        prices = [[UIPickerView alloc]init];
                        prices.backgroundColor = [UIColor whiteColor];
                        prices.delegate = self;
                        prices.dataSource = self;
                        [ePriceN setInputView:prices];
                        
                        [cell.contentView addSubview:ePriceN];
                    }
                    [cell.contentView addSubview:eName];
                    [cell.contentView addSubview:eventPic];
                    [cell.contentView addSubview:eLocation];
                    
                    break;
                case 1:
                    discription = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 35)];
                    discription.text = @"Event Description";
                    
                    eDiscrip = [[UIButton alloc]initWithFrame:CGRectMake(240, 5, 60, 30)];
                    [eDiscrip setTitle:@"Show" forState:UIControlStateNormal];
                    if (!expanded){
                        eDiscrip.backgroundColor = [UIColor whiteColor];
                        [eDiscrip setTitleColor:UIColorFromRGB(0x34B085) forState:UIControlStateNormal];
                        eDiscrip.layer.borderColor = UIColorFromRGB(0x34B085).CGColor;
                    }
                    if (expanded){
                        eDiscrip.backgroundColor = UIColorFromRGB(0x34B085);
                        [eDiscrip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                         eDiscrip.layer.borderColor = [UIColor whiteColor].CGColor;
                    }
                    [eDiscrip addTarget:self action:@selector(descrip:) forControlEvents:UIControlEventTouchUpInside];
                    eDiscrip.layer.cornerRadius = 4;
                    eDiscrip.layer.borderWidth = .5;
                    if (expanded) {
                        eDiscription = [[UITextView alloc]initWithFrame:CGRectMake(15, 44, 290, 100)];
                        eDiscription.returnKeyType = UIReturnKeyDone;
                        eDiscription.layer.cornerRadius = 3;
                        eDiscription.layer.borderWidth = .5;
                        eDiscription.layer.borderColor = [UIColor lightGrayColor].CGColor;
                        eDiscription.text = theRetainedDescription;
                        [cell.contentView addSubview:eDiscription];
                    }
                    
                    [cell.contentView addSubview:discription];
                    [cell.contentView addSubview:eDiscrip];
                    break;
                case 2:
                    eDate = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, 320, 44)];
                    eDate.placeholder = @"Date and Time of Event";
                    eDate.inputAccessoryView = pickerBar;
                    eDate.delegate = self;
                    
                    dateAndTime = [[UIDatePicker alloc]init];
                    [dateAndTime setDate:[NSDate date]];
                    [dateAndTime addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
                    dateAndTime.backgroundColor = [UIColor whiteColor];
                    [eDate setInputView:dateAndTime];
                    
                    [cell.contentView addSubview:eDate];
                default:
                    break;
            }
    }
    if (indexPath.section == 1){
            switch (indexPath.row) {
                case 0:
                    //adding the age based switch
                    ageBased = [[UISwitch alloc]initWithFrame:CGRectMake(245, 5, 40, 30)];
                    [ageBased addTarget:self action:@selector(ageBased:) forControlEvents:UIControlEventValueChanged];
                    
                    //adding the label
                    cell.textLabel.text = @"Age Based";
                    
                    //actually adding stuff to the view
                    [cell.contentView addSubview:ageBased];
                    break;
                case 1:
                    cell.textLabel.text = @"Age Range";
                    
                    rangeL = [[UITextField alloc]initWithFrame:CGRectMake(150, 0, 30, 44)];
                    rangeL.placeholder = @"00";
                    rangeL.delegate = self;
                    
                    dash = [[UILabel alloc]initWithFrame:CGRectMake(185, 0, 20, 44)];
                    dash.text = @"-";
                    
                    rangeH = [[UITextField alloc]initWithFrame:CGRectMake(210, 0, 30, 44)];
                    rangeH.placeholder = @"00";
                    rangeH.delegate = self;
                    
                    [cell.contentView addSubview:rangeL];
                    [cell.contentView addSubview:rangeH];
                    [cell.contentView addSubview:dash];
                    
                    break;
                case 2:
                    ePriceL = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, 320, 40)];
                    ePriceL.borderStyle = UITextBorderStyleNone;
                    ePriceL.placeholder = @"Price for Youngest";
                    ePriceL.inputAccessoryView = pickerBar;
                    ePriceL.delegate = self;
                    
                    prices = [[UIPickerView alloc]init];
                    prices.backgroundColor = [UIColor whiteColor];
                    prices.delegate = self;
                    prices.dataSource = self;
                    [ePriceL setInputView:prices];
                    
                    [cell.contentView addSubview:ePriceL];
                    break;
                case 3:
                    ePriceM = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, 320, 40)];
                    ePriceM.borderStyle = UITextBorderStyleNone;
                    ePriceM.placeholder = @"Price for Average Age";
                    ePriceM.inputAccessoryView = pickerBar;
                    ePriceM.delegate = self;
                    
                    prices = [[UIPickerView alloc]init];
                    prices.backgroundColor = [UIColor whiteColor];
                    prices.delegate = self;
                    prices.dataSource = self;
                    [ePriceM setInputView:prices];
                    
                    [cell.contentView addSubview:ePriceM];
                    break;
                case 4:
                    ePriceH = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, 320, 30)];
                    ePriceH.borderStyle = UITextBorderStyleNone;
                    ePriceH.placeholder = @"Price for Oldest";
                    ePriceH.inputAccessoryView = pickerBar;
                    ePriceH.delegate = self;
                    
                    prices = [[UIPickerView alloc]init];
                    prices.backgroundColor = [UIColor whiteColor];
                    prices.delegate = self;
                    prices.dataSource = self;
                    [ePriceH setInputView:prices];
                    
                    [cell.contentView addSubview:ePriceH];
                    break;
                default:
                    break;
            }
    }

    if (indexPath.section == 2){
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Private";
                    
                    //adding the pubPriv switch
                    pubPriv = [[UISwitch alloc]initWithFrame:CGRectMake(245, 5, 40, 30)];
                    [pubPriv addTarget:self action:@selector(pubPriv:) forControlEvents:UIControlEventValueChanged];
                    
                    [cell.contentView addSubview:pubPriv];
                    break;
                case 1:
                    if (!(pubPriv.on)) {
                        //the actual slider
                        eCapacity = [[UISlider alloc]initWithFrame:CGRectMake(15, 35, 280, 30)];
                        eCapacity.minimumValue = 1;
                        eCapacity.maximumValue = 1000;
                        [eCapacity addTarget:self action:@selector(slid:) forControlEvents:UIControlEventValueChanged];
                    
                        //the static label
                        capacity = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 200, 30)];
                        capacity.text = @"Max Capacity";
                        
                        //the label that shows the number
                        capacityNum = [[UILabel alloc]initWithFrame:CGRectMake(260, 10, 60, 30)];
                        
                        //adding stuff to the frame
                        [cell.contentView addSubview:eCapacity];
                        [cell.contentView addSubview:capacity];
                        [cell.contentView addSubview:capacityNum];
                    }
                    else{
                        cell.textLabel.text = @"Invite People";
                        
                        invite = [[UIButton alloc]initWithFrame:CGRectMake(200, 10, 100, 24)];
                        [invite setTitle:@"Invite" forState:UIControlStateNormal];
                        [invite setTitleColor:UIColorFromRGB(0x34B085) forState:UIControlStateNormal];
                        [invite setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                        [invite addTarget:self action:@selector(invite:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:invite];
                    }
                    break;
                case 3:
                    cell.textLabel.text = @"BYOB";
                    BYOB = [[UISwitch alloc]initWithFrame:CGRectMake(245, 5, 40, 30)];
                    
                    [cell.contentView addSubview:BYOB];
                    break;
                case 2:
                    cell.textLabel.text = @"Blacklist";
                    
                    blacklist = [[UIButton alloc]initWithFrame:CGRectMake(220, 0, 100, 44)];
                    [blacklist setTitle:@"Add People" forState:UIControlStateNormal];
                    [blacklist setTitleColor:UIColorFromRGB(0x34B085) forState:UIControlStateNormal];
                    [blacklist setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                    [blacklist addTarget:self action:@selector(blacklist:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:blacklist];
                    break;
                default:
                    break;
            }
    }
    
    return cell;
}

#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - Button Methods

- (void)cancel:(id)sender{
    [self.delegate LeftViewControllerDidPop:self];
    [self.revealSideViewController popViewControllerAnimated:YES];
}

- (void)create:(id)sender{
    //implement delegate method create event
    [self.delegate addEvent:nil];
    [self.delegate LeftViewControllerDidPop:self];
    [self.revealSideViewController popViewControllerAnimated:YES];
}

- (void)descrip:(id)sender{
    if (!expanded) {
        expanded = YES;
    }
    else{
        theRetainedDescription = eDiscription.text;
        expanded = NO;
    }
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)ageBased:(id)sender{
    [self.tableView beginUpdates];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    [tempArray addObject:[NSIndexPath indexPathForRow:1 inSection:1]];
    [tempArray addObject:[NSIndexPath indexPathForRow:2 inSection:1]];
    [tempArray addObject:[NSIndexPath indexPathForRow:3 inSection:1]];
    [tempArray addObject:[NSIndexPath indexPathForRow:4 inSection:1]];
    
    if (ageBased.on)
        [self.tableView insertRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationLeft];
    else
        [self.tableView deleteRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView endUpdates];
}

- (void)pubPriv:(id)sender{
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView endUpdates];
}

- (void)invite:(id)sender{
    FreindListViewController *fv = [[FreindListViewController alloc]init];
    [self presentViewController:fv animated:YES completion:nil];
}

- (void)blacklist:(id)sender{
    FreindListViewController *fv = [[FreindListViewController alloc]init];
    [self presentViewController:fv animated:YES completion:nil];
}

#pragma mark - UI Methods

- (void)slid:(id)sender{
    capacityNum.text = [NSString stringWithFormat:@"%i", (int)eCapacity.value];
}

- (void)updateTextField:(id)sender{
    UIDatePicker *picker = (UIDatePicker*)eDate.inputView;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    eDate.text = [formatter stringFromDate:picker.date];
}

- (void)pickerDone{
    UIPickerView *n = (UIPickerView*)ePriceN.inputView;
    UIPickerView *l = (UIPickerView*)ePriceL.inputView;
    UIPickerView *m = (UIPickerView*)ePriceM.inputView;
    UIPickerView *h = (UIPickerView*)ePriceH.inputView;
    
    ePriceN.text = [pickerArray objectAtIndex:[n selectedRowInComponent:0]];
    ePriceL.text = [pickerArray objectAtIndex:[l selectedRowInComponent:0]];
    ePriceM.text = [pickerArray objectAtIndex:[m selectedRowInComponent:0]];
    ePriceH.text = [pickerArray objectAtIndex:[h selectedRowInComponent:0]];
    
    [ePriceN resignFirstResponder];
    [ePriceL resignFirstResponder];
    [ePriceM resignFirstResponder];
    [ePriceH resignFirstResponder];
    [eDate resignFirstResponder];
}

#pragma mark - UIPickerViewDelegate

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [pickerArray objectAtIndex:row];
}

#pragma mark - UIPickerViewDatasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return pickerArray.count;
}

@end
