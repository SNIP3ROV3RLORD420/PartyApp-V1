//
//  RightViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/20/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//
//

#import "RightViewController.h"
#import "AccountViewController.h"
#import "MyEventsViewController.h"

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
        self.tableView.separatorColor = [UIColor whiteColor];
        self.tableView.scrollEnabled = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.revealSideViewController unloadViewControllerForSide:PPRevealSideDirectionLeft];
}

- (void)viewDidAppear:(BOOL)animated{
    [self performSelector:@selector(hide) withObject:self afterDelay:.1];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        return (3 * 44);
    }
    if (indexPath.row == 6){
        return (5 * 44);
    }
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = PP_AUTORELEASE([[UITableViewCell alloc]init]);
    }
    
    UIView *bc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    bc.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row == 0 || indexPath.row == 6){
        cell.backgroundColor = UIColorFromRGB(0x34B085);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (indexPath.row) {
        case 1:
            cell.textLabel.text = @"My Account";
            cell.textLabel.textColor = [UIColor whiteColor];
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = UIColorFromRGB(0x34B085);
            cell.backgroundColor = UIColorFromRGB(0x34B085);
            break;
        case 2:
            cell.textLabel.text = @"My Events";
            cell.textLabel.textColor = [UIColor whiteColor];
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = UIColorFromRGB(0x34B085);
            cell.backgroundColor = UIColorFromRGB(0x34B085);
            break;
        case 3:
            cell.textLabel.text = @"Settings";
            cell.textLabel.textColor = [UIColor whiteColor];
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = UIColorFromRGB(0x34B085);
            cell.backgroundColor = UIColorFromRGB(0x34B085);
            break;
        case 4:
            cell.textLabel.text = @"About";
            cell.textLabel.textColor = [UIColor whiteColor];
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = UIColorFromRGB(0x34B085);
            cell.backgroundColor = UIColorFromRGB(0x34B085);
            break;
        case 5:
            cell.textLabel.text = @"Other";
            cell.textLabel.textColor = [UIColor whiteColor];
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = UIColorFromRGB(0x34B085);
            cell.backgroundColor = UIColorFromRGB(0x34B085);
            break;
        default:
            break;
    }
    cell.indentationLevel = 7;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1){
        AccountViewController *av = [[AccountViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:av animated:YES];
        [self.revealSideViewController openCompletelyAnimated:YES];
    }
    if (indexPath.row == 2) {
        MyEventsViewController *mv = [[MyEventsViewController alloc]init];
        [self.navigationController pushViewController:mv animated:YES];
        [self.revealSideViewController openCompletelyAnimated:YES];
    }
}

#pragma mark - Anonymous

- (void)hide{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


@end
