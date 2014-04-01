//
//  FreindListViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/29/14.
//
//

#import "FreindListViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FreindListViewController (){
    NSMutableArray *freindList;
}

@end

@implementation FreindListViewController

@synthesize lists, usr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0x34B085);
    
    //adding the navigation bar to the view
    UINavigationBar *navBar = PP_AUTORELEASE([[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, 320, 44)]);
    navBar.backgroundColor = [UIColor clearColor];
    
    UINavigationItem *navItem = [[UINavigationItem alloc]init];
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Done"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(done)];
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    lists = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"   Presets", @"Freinds", nil]];
    [lists sizeToFit];
    
    navItem.titleView = lists;
    navBar.items = [NSArray arrayWithObject:navItem];
    
    [self.view addSubview:navBar];
    
    //adding a tool bar
    UINavigationBar *toolBar = PP_AUTORELEASE([[UINavigationBar alloc]initWithFrame:CGRectMake(0, 538, 320, 30)]);
    toolBar.backgroundColor = [UIColor clearColor];
    UINavigationItem *toolItem = [[UINavigationItem alloc]init];
    toolItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"   Add Selected Freinds To Presets"
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(addPreset)];
    toolBar.items = [NSArray arrayWithObject:toolItem];
    
    [self.view addSubview:toolBar];
    
    //adding the table view
    UITableView *tableView = PP_AUTORELEASE([[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, 474)]);
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    self.title = @"Freinds";
    usr = [PFUser currentUser];
    freindList = usr[@"friendsList"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return freindList.count;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    search.backgroundColor = [UIColor whiteColor];
    search.tintColor = [UIColor whiteColor];
    return search;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%i", indexPath.row];
    
    return cell;
}


#pragma mark - Button Methods

- (void)done{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addPreset{
    
}

@end
