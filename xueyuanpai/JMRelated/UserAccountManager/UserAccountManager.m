//
//  UserAccountManager.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "UserAccountManager.h"
#import "JPUSHService.h"
@implementation UserAccountManager

+ (instancetype)sharedInstance
{
    static UserAccountManager *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
    });
    
    return sharedClient;
}

-(void)saveUserAccountWithUserInfoDic:(NSMutableDictionary *)userInfoDic
{
    
    NSString * userInfoKey = @"userInfo";
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:userInfoDic];
    for (NSString * key in [userInfoDic allKeys]) {
        NSString * value = [userInfoDic objectForKey:key];
        if ([value isEqual:[NSNull null]]) {
            [dic setValue:@"" forKey:key];
        }else{
            
        }
    }
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:userInfoKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self getUserInfo];
}
-(void)getUserInfo
{
    
    /*
     "college_id" = 1;
     "create_time" = "2017-04-18 13:38:45";
     icon = "http://114.215.111.210:999/frontend/web/uploads/20170418/14924971055920.png";
     id = 8;
     nickname = "\U8d85\U8d85";
     point = 0;
     sex = 1;
     telphone = 18511870285;
     "update_time" = "2017-04-18 13:38:45";
     */
    NSString * userInfoKey = @"userInfo";
    NSDictionary * userInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:userInfoKey];
    self.userCollegeId    = [userInfoDic stringForKey:@"college_id"];
    self.colledgeTime = [userInfoDic stringForKey:@"create_time"];
    self.userIcon         = [userInfoDic stringForKey:@"icon"];
    self.userId           = [userInfoDic stringForKey:@"id"];
    self.userNickname     = [userInfoDic stringForKey:@"nickname"];
    self.userPoint     = [userInfoDic stringForKey:@"point"];
    self.userSex          = [[userInfoDic stringForKey:@"sex"] integerValue];
    self.userTelphone     = [userInfoDic stringForKey:@"telphone"];
    self.updateTime     = [userInfoDic stringForKey:@"update_time"];
    
    
    
    if (self.userId && self.userId.length>0) {
        self.isLogin = YES;
        ///设置别名
        [self setJpushTags];
    }else{
        self.isLogin = NO;
    }

    //登陆的时候,先进行环信登陆判断,然后再进行密码判断
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.userTelphone password:@"1"];
    if (!error) {
        
        NSLog(@"环信登陆成功");
        
    }
    //环信登陆成功
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTI_UPDATE_BY_USER_ID object:nil];
}

-(void)exitLogin
{
    NSString * userInfoKey = @"userInfo";
    [UserDefaultsDataDeal deleteKey:userInfoKey];
    [self getUserInfo];
}
-(void)loginWithUserPhoneNum:(NSString *)phoneNum andPassWord:(NSString *)passWord withUserRole:(RegisterRoleType)role
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:phoneNum forKey:@"mobile"];
    [dic setValue:passWord forKey:@"passwd"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)role] forKey:@"role"];
    [[HttpClient sharedInstance]loginWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
        
            [[UserAccountManager sharedInstance]saveUserAccountWithUserInfoDic:model.responseCommonDic];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        
    } withFaileBlock:^(NSError *error) {
        
    }];
}
-(void)setJpushTags
{
    //设置tags和别名
    NSString * tag = [NSString stringWithFormat:@"user%@",self.userId];
    NSSet  *set = [NSSet setWithObject:tag];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JPUSHService setTags:set alias:tag fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            NSLog(@"%d----%@---",iResCode,iAlias);
//            [CommonUtils showToastWithStr:[NSString stringWithFormat:@"注册别名成功:%@",iAlias]];
        }];
    });
   
}
-(void)getUserInfoWithUserPhoneNum:(NSString *)phoneNum
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.userTelphone forKey:@"mobile"];
    [[HttpClient sharedInstance]myHomePageByMobileWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            
            [[UserAccountManager sharedInstance]saveUserAccountWithUserInfoDic:model.responseCommonDic];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        
    } withFaileBlock:^(NSError *error) {
        
    }];
}
-(void)getUserInfoWithUserId:(NSString *)userid
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.userId forKey:@"user_id"];
    [[HttpClient sharedInstance]myHomePageWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            
            [[UserAccountManager sharedInstance]saveUserAccountWithUserInfoDic:model.responseCommonDic];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        
    } withFaileBlock:^(NSError *error) {
        
    }];
}
@end
