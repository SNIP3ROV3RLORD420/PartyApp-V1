//
//  SettingsViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 4/3/14.
//
//

#import "SettingsViewController.h"

@interface SettingsViewController (){
    UISwitch *pushNotifications;
    UISwitch *keepLogged;
    
    UISlider *rangeSlider;
    UILabel *range;
}

@end

@implementation SettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.title = @"Settings";
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 70;
    }
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"Push Notifications";
        pushNotifications = [[UISwitch alloc]init];
        [pushNotifications addTarget:self action:@selector(notifications) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = pushNotifications;
    }
    if (indexPath.section == 1) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 30)];
        label.text = @"Search Range";
        rangeSlider = [[UISlider alloc]initWithFrame:CGRectMake(5, 50, 310, 20)];
        rangeSlider.minimumValue = 1;
        rangeSlider.maximumValue = 50;
        [rangeSlider addTarget:self action:@selector(slid) forControlEvents:UIControlEventValueChanged];
        
        range = [[UILabel alloc]initWithFrame:CGRectMake(270, 7, 30, 30)];
        range.text = @"1";
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:range];
        cell.detailTextLabel.text = @"Miles";
        
        [cell.contentView addSubview:rangeSlider];
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = @"Keep Me Logged In";
        keepLogged = [[UISwitch alloc]init];
        cell.accessoryView = keepLogged;
        [keepLogged addTarget:self action:@selector(keepLogged) forControlEvents:UIControlEventValueChanged];
    }
    return cell;
}


#pragma mark - Button Methods

- (void)back{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

#pragma mark - Other Methods

- (void)notifications{
    
}

- (void)keepLogged{
    
}

- (void)slid{
    range.text = [NSString stringWithFormat:@"%i",(int)rangeSlider.value];
}

@end
