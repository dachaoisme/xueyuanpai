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
     "user_id": 4,//用户序号
     "points": 0, //积分
     "role": 1,  //1学生 2导师
     "icon": "", //头像
     "nickname": "答案的", //昵称
     "mobile": "13718360863",//手机号码
     "college_id": 1, //学校序号
     "college_name": "北京大学",
     "sex": 1,       //性别 1男 0女
     "realname": "", //真实姓名
     "idcard": 0,   //身份证号
     "company": "", //工作单位
     "job": "",    //职务
     "telphone": "", //联系电话
     "email": "",
     "skillful": "",//擅长辅导领域
     "tutorbackground": "" //导师背景
     */
    NSString * userInfoKey = @"userInfo";
    NSDictionary * userInfoDic = [[NSUserDefaults standardUserDefaults] objectForKey:userInfoKey];
    
    self.userId           = [userInfoDic stringForKey:@"user_id"];
    self.userUsablePoints = [userInfoDic stringForKey:@"points"];
    self.userRole         = [[userInfoDic stringForKey:@"role"] integerValue];
    self.userIcon         = [userInfoDic stringForKey:@"icon"];
    self.userNickname     = [userInfoDic stringForKey:@"nickname"];
    self.userMobile       = [userInfoDic stringForKey:@"mobile"];
    self.userCollegeId    = [userInfoDic stringForKey:@"college_id"];
    self.userCollegeName  = [userInfoDic stringForKey:@"college_name"];
    self.userSex          = [[userInfoDic stringForKey:@"sex"] integerValue];
    self.userRealName     = [userInfoDic stringForKey:@"realname"];
    self.userIdCard       = [userInfoDic stringForKey:@"idcard"];
    self.userCompany      = [userInfoDic stringForKey:@"company"];
    self.userJob          = [userInfoDic stringForKey:@"job"];
    self.userTelphone     = [userInfoDic stringForKey:@"telphone"];
    self.userEmail        = [userInfoDic stringForKey:@"email"];
    self.userSkillful     = [userInfoDic stringForKey:@"skillful"];
    self.userTutorbackground= [userInfoDic stringForKey:@"tutorbackground"];
    
    if (self.userId && self.userId.length>0) {
        self.isLogin = YES;
    }else{
        self.isLogin = NO;
    }

}

-(void)exitLogin
{
    NSString * userInfoKey = @"userInfo";
    [UserDefaultsDataDeal deleteKey:userInfoKey];
    self.isLogin = NO;
    [self getUserInfo];
}
-(void)loginWithUserPhoneNum:(NSString *)phoneNum andPassWord:(NSString *)passWord
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneNum forKey:@"mobile"];
    [dic setObject:passWord forKey:@"passwd"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)self.userRole] forKey:@"role"];
    [[HttpClient sharedInstance]loginWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
        [[UserAccountManager sharedInstance]saveUserAccountWithUserInfoDic:model.responseCommonDic];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
@end
