//
//  LoginTableView.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/28/14.
//
//

#import <UIKit/UIKit.h>

@interface LoginTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITextField *login;
@property (nonatomic, retain) UITextField *password;

@end
