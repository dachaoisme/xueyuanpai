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

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"


//极光推送
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


#import "MFWelcomPageController.h"
@interface AppDelegate ()<CustomIOS7AlertViewDelegate,WXApiDelegate,JPUSHRegisterDelegate>

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
    
    
    
    [self setRootViewController:YES];

    return YES;
}
-(void)setRootViewController:(BOOL)isLogin
{
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:NOTFISTOPEN]) {
        //进去欢迎页面
        MFWelcomPageController *pageController = [[MFWelcomPageController alloc] init];
        self.window.rootViewController        = pageController;
        [self.window makeKeyAndVisible];
    }else{
        BaseTabBarViewController *mainVC = [[BaseTabBarViewController alloc] init];
        _mainTabBar=mainVC;
        _window.rootViewController=mainVC;
        
        [_window makeKeyAndVisible];
    }
    
}
#pragma mark - 分享
- (void)shareContent{
}

#pragma mark - 极光推送

- (void)jpushAction:(NSDictionary *)launchOptions{
    
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
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
        
        
        //当应用处于活跃状态可以给用户一个弹框
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送消息"
                                                            message:@"测试一下"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:
(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    //    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}
#endif


+ (void)setupWithOption:(NSDictionary *)launchingOption
                 appKey:(NSString *)appKey
                channel:(NSString *)channel
       apsForProduction:(BOOL)isProduction{
    
    
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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    //是推送的红点1消失
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}



#pragma mark - 支付相关内容
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [self returnWithOpenUrlHandle:url];
    return YES;
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    [self returnWithOpenUrlHandle:url];
    return YES;
    
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options
{
    [self returnWithOpenUrlHandle:url];
    return YES;
}
-(void)returnWithOpenUrlHandle:(NSURL *)url
{
    if([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    }else if ([url.host isEqualToString:@"pay"]){
        [WXApi handleOpenURL:url delegate:self];
        
        
    }
}
- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode) {
            case WXSuccess:
                //strMsg = @"支付结果：成功！";
                //NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [self sendWechatPayResultNotificationWithErrorCode:resp.errCode];
                break;
                
            default:
                //strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                //NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                [self sendWechatPayResultNotificationWithErrorCode:resp.errCode];
                break;
        }
    }
   
}
#pragma mark - 微信支付结果通知
-(void)sendWechatPayResultNotificationWithErrorCode:(int)errorCode
{
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTI_WXSUCCESS_PAY object:[NSNumber numberWithInt:errorCode]];
}
#pragma mark - 支付宝客户端支付结果通知
-(void)sendAliPayResultNotificationWithErrorCode:(NSDictionary*)result
{
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTI_ALISUCCESS_PAY object:result];
}

@end
