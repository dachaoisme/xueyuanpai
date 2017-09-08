//
//  AppDelegate.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/4.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarViewController.h"

//极光推送
static NSString *appKey = @"79dba290d82b3e915deb7a4f";
static NSString *channel = @"Publish channel";
static BOOL isProduction = YES;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BaseTabBarViewController *mainTabBar;
@property (strong, nonatomic) UINavigationController *navBar;
@property (strong, nonatomic) UINavigationController *navController;

/**
 *  @brief  登陆成功以后，重新设置跟试图控制器
 *
 *  @return
 */
-(void)setRootViewController:(BOOL)isLogin;
@end

