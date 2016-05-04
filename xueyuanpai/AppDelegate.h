//
//  AppDelegate.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/4.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BaseTabBarViewController *mainTabBar;
@property (strong, nonatomic) UINavigationController *navBar;
@property (strong, nonatomic) UINavigationController *navController;

@end

