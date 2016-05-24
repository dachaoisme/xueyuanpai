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
    if (userId) {
        NSString * userIdStr = [NSString stringWithFormat:@"%d",[userId intValue]];
        [userInfoDic setObject:userIdStr forKey:@"userId"];
        if (phoneNum) {
            [userInfoDic setObject:phoneNum forKey:@"phoneNum"];
        }
        if (password) {
            [userInfoDic setObject:password forKey:@"password"];
        }
        
        [UserDefaultsDataDeal saveWithKey:userInfoKey andValue:userInfoDic];
        
        self.userId = userIdStr;
        self.phoneNum = phoneNum;
        self.password = password;
        self.isLogin = YES;
    }else{
        
    }
}
-(NSDictionary *)getUserInfo
{
    NSString * userInfoKey = @"userInfo";
    NSDictionary * dic = [UserDefaultsDataDeal getDictionaryForKey:userInfoKey];
    self.userId =[dic stringForKey:@"userId"];
    self.phoneNum = [dic stringForKey:@"phoneNum"];
    self.password = [dic stringForKey:@"password"];
    if (self.userId && self.userId.length>0) {
        self.isLogin = YES;
    }else{
        self.isLogin = NO;
    }
    [self getPoints];
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
    self.isLogin = NO;
}
-(void)saveUsablePointsWithPoints:(NSString * )points
{
    NSString * userInfoKey = @"points";
    if (points) {
        NSString * pointsStr = [NSString stringWithFormat:@"%d",[points intValue]];
        NSMutableDictionary * userInfoDic = [NSMutableDictionary dictionary];
        if (pointsStr) {
            [userInfoDic setObject:pointsStr forKey:userInfoKey];
            [UserDefaultsDataDeal saveWithKey:userInfoKey andValue:userInfoDic];
            self.usablePoints = pointsStr;
        }else{
            
        }
    }
    
}
-(NSString *)getPoints
{
    NSString * userInfoKey = @"points";
    NSDictionary * dic = [UserDefaultsDataDeal getDictionaryForKey:userInfoKey];
    NSString * usablePoints = [dic objectForKey:userInfoKey];
    self.usablePoints = usablePoints;
    return usablePoints;
}
@end
