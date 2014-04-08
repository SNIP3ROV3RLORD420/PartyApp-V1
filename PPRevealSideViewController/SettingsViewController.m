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
    return 2;
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

@end
