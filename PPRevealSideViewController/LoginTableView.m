//
//  LoginTableView.m
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/28/14.
//
//

#import "LoginTableView.h"

@implementation LoginTableView

@synthesize login, password;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
        cell = PP_AUTORELEASE([[UITableViewCell alloc]init]);
    if (indexPath.row == 0) {
        login = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, 320, 44)];
        [cell.contentView addSubview:login];
    }
    if (indexPath.row == 1) {
        password = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, 320, 44)];
        password.secureTextEntry = YES;
        [cell.contentView addSubview:password];
    }
    return cell;
}

@end
