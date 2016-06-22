//
//  AppDelegate.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/4.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AppDelegate.h"

#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>

#import "CustomIOS7AlertView.h"

@interface AppDelegate ()<CustomIOS7AlertViewDelegate>

///推送消息
@property (nonatomic,strong)NSString *message;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    //极光推送方法
    [self jpushAction:launchOptions];
    
    [[UserAccountManager sharedInstance]getUserInfo];
    
    BaseTabBarViewController *mainVC = [[BaseTabBarViewController alloc] init];
    _mainTabBar=mainVC;
    _window.rootViewController=mainVC;
    
    [_window makeKeyAndVisible];
    

    return YES;
}

- (void)jpushAction:(NSDictionary *)launchOptions{
    
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];

}


#pragma mark - 注册token
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required -    DeviceToken
     NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark - 处理用户信息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:
(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    
    //集成完毕待测试
    NSLog(@"++++++userInfo = %@",userInfo);
    
    self.message  = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue];
    
    if (application.applicationState == UIApplicationStateActive) {
        
        
        CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
        //自定义AlertView
        [alertView setContainerView:[self createView]];
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"关闭", nil]];
        [alertView setBackgroundColor:[UIColor clearColor]];
        [alertView setDelegate:self];
        [alertView setUseMotionEffects:true];
        [alertView show];
        
    }

}

#pragma mark - 提交小票成功提醒框的内容
- (UIView* )createView
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 220/2)];
    customView.backgroundColor = [CommonUtils colorWithHex:@"ffffff"];
    
    UILabel *lableShowSuess = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 210, 40)];
    lableShowSuess.backgroundColor = [UIColor clearColor];
    lableShowSuess.textAlignment = NSTextAlignmentCenter;
    lableShowSuess.textColor = [CommonUtils colorWithHex:@"00beaf"];
    lableShowSuess.font = [UIFont systemFontOfSize:22];
    lableShowSuess.text = @"推送消息";
    [customView addSubview:lableShowSuess];
    
    UILabel * labelShowMessage = [[UILabel alloc] initWithFrame:CGRectMake(45/2, 40, 250, 60)];
    labelShowMessage.numberOfLines = 0;
    labelShowMessage.textColor = [UIColor blackColor];
    labelShowMessage.font = [UIFont systemFontOfSize:30/2];
    labelShowMessage.alpha = 0.7;
    labelShowMessage.text = self.message;
    [customView addSubview:labelShowMessage];
    return customView;
    
}

#pragma mark - CustomIOS7AlertViewDelegate
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
       [alertView close];
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:
(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error
          );
}

+ (void)setupWithOption:(NSDictionary *)launchingOption
                 appKey:(NSString *)appKey
                channel:(NSString *)channel
       apsForProduction:(BOOL)isProduction{
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
