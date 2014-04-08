//
//  AccViewController.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 4/7/14.
//
//

#import "AccViewController.h"

@interface AccViewController (){
    UITableView *section1;
    UITableView *section2;
    
    NSArray *pickerList;
}

@end

@implementation AccViewController

@synthesize username, usr, password, home, interestedIn, profPic, email, name;

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
    
    [self.revealSideViewController setPanInteractionsWhenOpened:PPRevealSideInteractionNavigationBar | PPRevealSideInteractionContentView];
    [self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionContentView | PPRevealSideInteractionNavigationBar];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(pushLeft)];
    pickerList = [[NSArray alloc]initWithObjects:@"Male",@"Female",@"Both", nil];
    
    //adding the image view
    profPic = [[UIImageView alloc]initWithFrame:CGRectMake(5, 69, 110, 110)];
    profPic.image = [UIImage imageNamed:@"sampleProf.png"];
    [self.view addSubview:profPic];
    
    //adding the first table view
    section1 = [[UITableView alloc]initWithFrame:CGRectMake(120, 69, 195, 110) style:UITableViewStyleGrouped];
    section1.layer.cornerRadius = 3;
    section1.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Methods

- (void)pushLeft{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}


@end
