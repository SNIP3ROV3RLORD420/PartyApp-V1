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
#import "MapViewController.h"

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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 100);
    
    self.view.backgroundColor = UIColorFromRGB(0x4c4c4c);
    self.tableView.backgroundColor = UIColorFromRGB(0x323232);
    
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.scrollEnabled = NO;
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
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 22;
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
        cell = PP_AUTORELEASE([[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 200, 50)]);
    }
    
    UIView *bc = [[UIView alloc]initWithFrame:CGRectMake(5, 0, 100, 50)];
    bc.backgroundColor = UIColorFromRGB(0x191919);
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"My Account";
            cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
            cell.backgroundColor = UIColorFromRGB(0x323232);
            break;
        case 1:
            cell.textLabel.text = @"Map";
            cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
            cell.backgroundColor = UIColorFromRGB(0x323232);
            break;
        case 2:
            cell.textLabel.text = @"Other";
            cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
            cell.backgroundColor = UIColorFromRGB(0x323232);
            break;
        case 3:
            cell.textLabel.text = @"Settings";
            cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
            cell.backgroundColor = UIColorFromRGB(0x323232);
            break;
        case 4:
            cell.textLabel.text = @"About";
            cell.textLabel.textColor = UIColorFromRGB(0xa6a6a6);
            [cell setSelectedBackgroundView:bc];
            cell.textLabel.highlightedTextColor = [UIColor whiteColor];
            cell.backgroundColor = UIColorFromRGB(0x323232);
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        AccountViewController *av = [[AccountViewController alloc]initWithStyle:UITableViewStyleGrouped];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:av];
        [self.revealSideViewController popViewControllerWithNewCenterController:nav animated:YES];
    }
    if (indexPath.row == 1) {
        MapViewController *mv = [[MapViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mv];
        [self.revealSideViewController popViewControllerWithNewCenterController:nav animated:YES];
    }
}

#pragma mark - Anonymous

- (void)hide{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


@end
