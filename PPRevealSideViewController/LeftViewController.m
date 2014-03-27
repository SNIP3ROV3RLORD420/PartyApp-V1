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

@implementation LeftViewController

@synthesize eventPic, eCapacity, eDiscrip, eLocation, ePrice, eName, eDate, invite, ageBased, pubPriv, blacklist;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //adding the navigation bar and what not
        UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        [navBar setBarTintColor:UIColorFromRGB(0x34B085)];
        UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:@"Create Event"];
        navItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Host"
                                                                                   style:UIBarButtonItemStyleDone
                                                                                  target:self
                                                                                  action:@selector(create:)]);
        navItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                 target:self
                                                                                                 action:@selector(cancel:)]);
        
        navBar.items = [NSArray arrayWithObject:navItem];
        [self.view addSubview:navBar];
        
//--------------------------------First View--------------------------------
        
        //creating the first view --> Holds the Event image, event name, event location, event description, event price
        UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 320, 150)];
        firstView.backgroundColor = [UIColor whiteColor];
        
        //adding the image view
        eventPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 100, 100)];
        eventPic.backgroundColor = UIColorFromRGB(0x34B085);
        
        //adding the Event Name text field
        eName = [[UITextField alloc]initWithFrame:CGRectMake(120, 5.333333, 185, 33)];
        eName.placeholder = @"Event Name";
        eName.borderStyle = UITextBorderStyleNone;
        eName.backgroundColor = [UIColor whiteColor];
        eName.delegate = self;
        
        //adding the Event Location text field
        eLocation = [[UITextField alloc]initWithFrame:CGRectMake(120, 38.333333, 185, 33)];
        eLocation.placeholder = @"Address, Zipcode";
        eLocation.borderStyle = UITextBorderStyleNone;
        eLocation.backgroundColor = [UIColor whiteColor];
        eLocation.delegate = self;
        
        //adding the Event price text field
        ePrice = [[UITextField alloc]initWithFrame:CGRectMake(120, 71.333333, 185, 33)];
        ePrice.placeholder = @"Event Price";
        ePrice.borderStyle = UITextBorderStyleNone;
        ePrice.backgroundColor = [UIColor whiteColor];
        ePrice.delegate = self;
        
        //adding the descripiton button and labels
        UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 200, 40)];
        description.text = @"Event Description";
        
        eDiscrip = [[UIButton alloc]initWithFrame:CGRectMake(250, 110, 50, 40)];
        [eDiscrip setTitle:@"Show" forState:UIControlStateNormal];
        [eDiscrip addTarget:self action:@selector(descrip:) forControlEvents:UIControlEventTouchUpInside];
        [eDiscrip setTitleColor:UIColorFromRGB(0x34B085) forState:UIControlStateNormal];
        eDiscrip.showsTouchWhenHighlighted = YES;
        eDiscrip.backgroundColor = [UIColor whiteColor];
        
        //adding the date button and labels
        
        //actually adding stuff to the view
        [firstView addSubview:eventPic];
        [firstView addSubview:eName];
        [firstView addSubview:eLocation];
        [firstView addSubview:ePrice];
        [firstView addSubview:description];
        [firstView addSubview:eDiscrip];
        
//--------------------------------Second View----------------------------------
        //creating the second View --> Holds the age based switch
        UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 205, 320, 45)];
        secondView.backgroundColor = [UIColor whiteColor];
        
        //adding the age based switch
        ageBased = [[UISwitch alloc]initWithFrame:CGRectMake(245, 5, 40, 30)];
        
        //adding the label
        UILabel *ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 200, 30)];
        ageLabel.text = @"Age Based";
        //actually adding stuff to the view
        [secondView addSubview:ageBased];
        [secondView addSubview:ageLabel];
        
//--------------------------------Third View-----------------------------------
        //creating the third view --> Holds the public or private switch
        UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, 260, 320, 80)];
        thirdView.backgroundColor = [UIColor whiteColor];
        
        //adding the switch
        pubPriv = [[UISwitch alloc]initWithFrame:CGRectMake(245, 5, 40, 30)];
        
        //adding the label
        UILabel *pubPrivLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 200, 30)];
        pubPrivLabel.text = @"Private";
        
        //adding the blacklist button
        blacklist = [[UIButton alloc]initWithFrame:CGRectMake(15, 40, 290, 30)];
        [blacklist setTitle:@"BlackList" forState:UIControlStateNormal];
        [blacklist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        blacklist.backgroundColor = UIColorFromRGB(0x34B085);
        blacklist.showsTouchWhenHighlighted = YES;
        [blacklist addTarget:self action:@selector(blacklist) forControlEvents:UIControlEventTouchUpInside];
        
        //actually adding stuff to the view
        [thirdView addSubview:pubPriv];
        [thirdView addSubview:pubPrivLabel];
        [thirdView addSubview:blacklist];
        
//--------------------------------Main View------------------------------------
        self.view.backgroundColor = UIColorFromRGB(0x34B085);
        [self.view addSubview:firstView];
        [self.view addSubview:secondView];
        [self.view addSubview:thirdView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Methods

- (void)create:(id)sender{
    [self.revealSideViewController popViewControllerAnimated:YES];
}

- (void)cancel:(id)sender{
    [self.revealSideViewController popViewControllerAnimated:YES];
}

- (void)descrip:(id)sender{
    //implement new view showing up or a modal view coming up
}

@end
