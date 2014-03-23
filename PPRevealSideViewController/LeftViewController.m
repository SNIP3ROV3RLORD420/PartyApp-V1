//
//  LeftViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/21/14.
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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        [navBar setBarTintColor:UIColorFromRGB(0x34B085)];
        UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:@"Create Event"];
        navItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Host"
                                                                            style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(create:)]);
        navItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                target:self
                                                                                                action:@selector(cancel:)]);
        
        navBar.items = [NSArray arrayWithObject:navItem];
        [self.view addSubview:navBar];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.revealSideViewController unloadViewControllerForSide:PPRevealSideDirectionRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 3;
    if (section == 1)
        return 2;
    if (section == 2)
        return 3;
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
        cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = @"cell";
    
    
    return cell;
}


#pragma mark - Button Methods

- (void)cancel:(id)sender{
    [self.revealSideViewController popViewControllerAnimated:YES];
    [self.delegate leftViewControllerDidCancel:self];
    
}

- (void)create:(id)sender{
    //implement later --> Create event based on the properties that were created
    //for now just dismiss the view
    [self.revealSideViewController popViewControllerAnimated:YES];
}

@end
