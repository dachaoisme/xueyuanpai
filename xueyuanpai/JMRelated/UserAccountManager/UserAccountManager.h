//
//  UserAccountManager.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAccountManager : NSObject

/*

 self.userCollegeId    = [userInfoDic stringForKey:@"college_id"];
 self.colledgeTime = [userInfoDic stringForKey:@""];
 self.userIcon         = [userInfoDic stringForKey:@"icon"];
 self.userId           = [userInfoDic stringForKey:@"user_id"];
 self.userNickname     = [userInfoDic stringForKey:@"nickname"];
 self.userSex          = [[userInfoDic stringForKey:@"sex"] integerValue];
 self.userTelphone     = [userInfoDic stringForKey:@"telphone"];
 self.updateTime     = [userInfoDic stringForKey:@"update_time"];
*/
///用户大学序号
@property (nonatomic, strong) NSString *userCollegeId;
///激萌二期
@property (nonatomic, strong) NSString *colledgeTime;
///用户头像
@property (nonatomic, strong) NSString *userIcon;
///用户ID 唯一标示
@property (nonatomic, strong) NSString *userId;
///用户昵称
@property (nonatomic, strong) NSString *userNickname;
///用户性别
@property (nonatomic, assign) UserInfoSex userSex;
///用户联系电话
@property (nonatomic, strong) NSString *userTelphone;
@property (nonatomic, strong) NSString *updateTime;;




///用户积分
@property (nonatomic, strong) NSString *userUsablePoints;
///用户钱包
@property (nonatomic, strong) NSString *userUsableMoney;
///用户角色
@property (nonatomic, assign) UserInfoRole userRole;


///用户手机号
@property (nonatomic, strong) NSString *userMobile;

///用户大学名称
@property (nonatomic, strong) NSString *userCollegeName;

///用户真实姓名
@property (nonatomic, strong) NSString *userRealName;
///用户身份证
@property (nonatomic, strong) NSString *userIdCard;
///用户工作单位
@property (nonatomic, strong) NSString *userCompany;
///用户职务
@property (nonatomic, strong) NSString *userJob;

///用户邮箱
@property (nonatomic, strong) NSString *userEmail;
///用户技能
@property (nonatomic, strong) NSString *userSkillful;
///用户导师北京
@property (nonatomic, strong) NSString *userTutorbackground;
///是否是登陆状态
@property (nonatomic, assign) BOOL isLogin;

+ (instancetype)sharedInstance;

/**
 *  @brief  保存登陆信息
 *
 *  @param
 *
 *  @return
 */
-(void)saveUserAccountWithUserInfoDic:(NSDictionary *)userInfoDic;
/**
 *  @brief  获取用户信息，并更新属性的值
 *
 *  @param
 *
 *  @return
 */
-(void)getUserInfo;
/**
 *  @brief  获取用户id
 *
 *  @param
 *
 *  @return
 */

/**
 *  @brief  退出登录
 *
 *  @param
 *
 *  @return
 */
-(void)exitLogin;

-(void)loginWithUserPhoneNum:(NSString *)phoneNum andPassWord:(NSString *)passWord withUserRole:(RegisterRoleType)role;
///根据手机号获取用户信息
-(void)getUserInfoWithUserPhoneNum:(NSString *)phoneNum;
//根据用户id，获取用户信息
-(void)getUserInfoWithUserId:(NSString *)userid;
///极光推送tag
-(void)setJpushTags;
@end
