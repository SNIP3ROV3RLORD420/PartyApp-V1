//
//  LeftViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/26/14.
//
//

#import "LeftViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LeftViewController ()

@end

@interface LeftViewController (){
    UIImage *image;
    
    UILabel *capacityNum;
    UILabel *capacity;
    
    UILabel *dash;
    
    UIDatePicker *dateAndTime;
}

@end

@implementation LeftViewController

@synthesize eventPic, eCapacity, eDiscrip, eLocation, ePriceN, ePriceL, ePriceM, ePriceH, eName, eDate, invite, ageBased, pubPriv, blacklist, rangeH, rangeL, BYOB;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.separatorColor = [UIColor lightGrayColor];
        self.tableView.separatorInset = UIEdgeInsetsZero;
        self.tableView.allowsSelection = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Host"
                                                                               style:UIBarButtonItemStyleDone
                                                                              target:self
                                                                              action:@selector(create:)]);
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                             target:self
                                                                                             action:@selector(cancel:)]);
    self.title = @"Host Event";
    
    UITapGestureRecognizer *tap = PP_AUTORELEASE([[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)]);
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Event Generics";
            break;
        case 1:
            return @"Age Restrictions";
            break;
        case 2:
            return @"Event Settings";
            break;
        default:
            break;
    }
    return nil;
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
                    eName.backgroundColor = [UIColor whiteColor];
                    eName.delegate = self;
                    
                    //adding the Event Location text field
                    if (!(ageBased.on))
                        eLocation = [[UITextField alloc]initWithFrame:CGRectMake(120, 38.333333, 185, 33)];
                    else
                        eLocation = [[UITextField alloc]initWithFrame:CGRectMake(120, 60, 185, 40)];
                    eLocation.placeholder = @"Address, Zipcode";
                    eLocation.borderStyle = UITextBorderStyleNone;
                    eLocation.backgroundColor = [UIColor whiteColor];
                    eLocation.delegate = self;
                    
                    //adding the Event price text field
                    if (!(ageBased.on)) {
                        ePriceN = [[UITextField alloc]initWithFrame:CGRectMake(120, 71.333333, 185, 33)];
                        ePriceN.placeholder = @"Event Price";
                        ePriceN.borderStyle = UITextBorderStyleNone;
                        ePriceN.backgroundColor = [UIColor whiteColor];
                        ePriceN.delegate = self;
                        [cell.contentView addSubview:ePriceN];
                    }
                    [cell.contentView addSubview:eName];
                    [cell.contentView addSubview:eventPic];
                    [cell.contentView addSubview:eLocation];
                    
                    break;
                case 1:
                    cell.textLabel.text = @"Event Description";
                    
                    eDiscrip = [[UIButton alloc]initWithFrame:CGRectMake(250, 5, 50, 35)];
                    [eDiscrip setTitle:@"Show" forState:UIControlStateNormal];
                    [eDiscrip addTarget:self action:@selector(descrip:) forControlEvents:UIControlEventTouchUpInside];
                    [eDiscrip setTitleColor:UIColorFromRGB(0x34B085) forState:UIControlStateNormal];
                    [eDiscrip setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                    eDiscrip.showsTouchWhenHighlighted = YES;
                    eDiscrip.backgroundColor = [UIColor whiteColor];
                    
                    [cell.contentView addSubview:eDiscrip];
                    break;
                case 2:
                    eDate = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, 320, 44)];
                    eDate.placeholder = @"Date and Time of Event";
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
                    ePriceL.delegate = self;
                    [cell.contentView addSubview:ePriceL];
                    break;
                case 3:
                    ePriceM = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, 320, 40)];
                    ePriceM.borderStyle = UITextBorderStyleNone;
                    ePriceM.placeholder = @"Price for Average Age";
                    ePriceM.delegate = self;
                    [cell.contentView addSubview:ePriceM];
                    break;
                case 4:
                    ePriceH = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, 320, 30)];
                    ePriceH.borderStyle = UITextBorderStyleNone;
                    ePriceH.placeholder = @"Price for Oldest";
                    ePriceH.delegate = self;
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
    //will reveal the description in the view
}

- (void)ageBased:(id)sender{
    [self.tableView beginUpdates];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    [tempArray addObject:[NSIndexPath indexPathForRow:1 inSection:1]];
    [tempArray addObject:[NSIndexPath indexPathForRow:2 inSection:1]];
    [tempArray addObject:[NSIndexPath indexPathForRow:3 inSection:1]];
    [tempArray addObject:[NSIndexPath indexPathForRow:4 inSection:1]];
    
    if (ageBased.on)
        [self.tableView insertRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
    else
        [self.tableView deleteRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)pubPriv:(id)sender{
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)invite:(id)sender{
#warning imcomplete method
}

- (void)blacklist:(id)sender{
#warning imcomplete method
}

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

- (void)dismissKeyboard{
    [eDate resignFirstResponder];
    [eName resignFirstResponder];
    [ePriceN resignFirstResponder];
    [ePriceM resignFirstResponder];
    [ePriceL resignFirstResponder];
    [ePriceH resignFirstResponder];
}


@end
