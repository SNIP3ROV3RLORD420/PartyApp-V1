//
//  RightViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//
//

#import "RightViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface RightViewController ()

@end

@implementation RightViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.separatorColor = UIColorFromRGB(0x34B085);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = PP_AUTORELEASE([[UITableViewCell alloc]init]);
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"My Account";
            break;
        case 1:
            cell.textLabel.text = @"Nearby Events";
            break;
        case 2:
            cell.textLabel.text = @"Settings";
            break;
        case 3:
            cell.textLabel.text = @"About";
            break;
        case 4:
            cell.textLabel.text = @"Other";
            break;
        default:
            break;
    }
    cell.indentationLevel = 7;
    return cell;
}



@end
