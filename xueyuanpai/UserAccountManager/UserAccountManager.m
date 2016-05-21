//
//  UserAccountManager.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "UserAccountManager.h"

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

-(void)saveUserAccountWithUserId:(NSString *)userId withPhoneNum:(NSString *)phoneNum withPassword:(NSString *)password
{
    
    NSString * userInfoKey = @"userInfo";
    
    NSMutableDictionary * userInfoDic = [NSMutableDictionary dictionary];
    [userInfoDic setObject:userId forKey:@"userId"];
    [userInfoDic setObject:phoneNum forKey:@"phoneNum"];
    [userInfoDic setObject:password forKey:@"password"];
    
    [UserDefaultsDataDeal saveWithKey:userInfoKey andValue:userInfoDic];
    
    self.userId = userId;
    self.phoneNum = phoneNum;
    self.password = password;
    
    
}
-(NSDictionary *)getUserInfo
{
    NSString * userInfoKey = @"userInfo";
    NSDictionary * dic = [UserDefaultsDataDeal getDictionaryForKey:userInfoKey];
    self.userId =[dic objectForKey:@"phoneNum"];
    self.phoneNum = [dic objectForKey:@"phoneNum"];
    self.password = [dic objectForKey:@"password"];
    if (self.userId && self.userId.length>0) {
        self.yesIsLogin = YES;
    }else{
        self.yesIsLogin = NO;
    }
    return dic;
}

-(NSString *)getUserId
{
    NSString * userInfoKey = @"userInfo";
    NSDictionary * dic = [UserDefaultsDataDeal getDictionaryForKey:userInfoKey];
    NSString * userId = [dic objectForKey:@"userId"];
    return userId;
}

-(NSString *)getUserPhoneNum
{
    NSString * userInfoKey = @"userInfo";
    NSDictionary * dic = [UserDefaultsDataDeal getDictionaryForKey:userInfoKey];
    NSString * userId = [dic objectForKey:@"phoneNum"];
    return userId;
}

-(NSString *)getUserPassWord
{
    NSString * userInfoKey = @"userInfo";
    NSDictionary * dic = [UserDefaultsDataDeal getDictionaryForKey:userInfoKey];
    NSString * userId = [dic objectForKey:@"password"];
    return userId;
}

-(void)exitLogin
{
    NSString * userInfoKey = @"userInfo";
    [UserDefaultsDataDeal deleteKey:userInfoKey];
    self.yesIsLogin = NO;
}
@end
