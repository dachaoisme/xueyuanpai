//
//  UserAccountManager.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAccountManager : NSObject

///用户ID 唯一标示
@property (nonatomic, strong) NSString *userId;
///用户手机号
@property (nonatomic, strong) NSString *phoneNum;
//用户密码
@property (nonatomic, strong) NSString *password;
///是否是登陆状态
@property (nonatomic, assign) BOOL isLogin;
///可用积分
@property (nonatomic, strong) NSString *usablePoints;

+ (instancetype)sharedInstance;

/**
 *  @brief  保存登陆信息
 *
 *  @param
 *
 *  @return
 */
-(void)saveUserAccountWithUserId:(NSString *)userId withPhoneNum:(NSString *)phoneNum withPassword:(NSString *)password;
/**
 *  @brief  获取用户信息，并更新属性的值
 *
 *  @param
 *
 *  @return
 */
-(NSDictionary *)getUserInfo;
/**
 *  @brief  获取用户id
 *
 *  @param
 *
 *  @return
 */
-(NSString *)getUserId;
/**
 *  @brief  获取手机号
 *
 *  @param
 *
 *  @return
 */
-(NSString *)getUserPhoneNum;
/**
 *  @brief  获取密码
 *
 *  @param
 *
 *  @return
 */
-(NSString *)getUserPassWord;
/**
 *  @brief  退出登录
 *
 *  @param
 *
 *  @return
 */
-(void)exitLogin;
/**
 *  @brief  保存获取用户可用积分
 *
 *  @param
 *
 *  @return
 */
-(void)saveUsablePointsWithPoints:(NSString * )points;
/**
 *  @brief  获取用户可用积分
 *
 *  @param
 *
 *  @return
 */
-(NSString *)getPoints;
@end
