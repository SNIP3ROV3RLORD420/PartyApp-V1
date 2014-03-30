//
//  PPAppDelegate.h
//  PPRevealSideViewController
//
//  Created by Dylan Humphrey on 3/20/14.
//  Copyright (c) 2014 Dylan Humphrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, PPRevealSideViewControllerDelegate>{
    UIImageView *splashView;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;

- (void)startupAnimationDone:(NSString*)animationID finished:(NSNumber*)finished context:(void*) context;

@end
