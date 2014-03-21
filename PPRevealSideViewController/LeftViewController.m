//
//  LeftViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/21/14.
//
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

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
    self.navigationItem.rightBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithTitle:@"Host"
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:self
                                                                           action:@selector(create:)]);
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE([[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                            target:self
                                                                            action:@selector(cancel:)]);

    self.title = @"Create Event";
    [self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionContentView | PPRevealSideInteractionNavigationBar];
    [self.revealSideViewController setPanInteractionsWhenOpened:PPRevealSideInteractionContentView | PPRevealSideInteractionNavigationBar];
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
    [self.delegate leftViewControllerDidCancel:self];
    
}

- (void)create:(id)sender{
    //implement later --> Create event based on the properties that were created
    //for now just dismiss the view
    [self dismissViewControllerAnimated:YES completion:^{PPRSLog(@"Created")}];
}

@end
