//
//  HttpClient.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpServer.h"



@interface HttpClient : NSObject

/**
 *  @brief  单利初始化
 *
 *  @param
 *  @return
 */
+ (instancetype)sharedInstance;

#pragma mark - 首页相关
/**
 *  @brief  获取首页轮播图
 *
 *  @param
 *
 *  @return
 */
- (void)getBannerOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

/**
 *  @brief  获取首页栏目分类
 *
 *  @param
 *
 *  @return
 */
- (void)getColumnsOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

/**
 *  @brief  获取首页栏目分类
 *
 *  @param
 *
 *  @return
 */
- (void)getMallOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;


#pragma mark - 用户相关
/**
 *  @brief  登陆
 *
 *  @param
 *
 *  @return
 */

- (void)loginWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  发送验证码
 *
 *  @param
 *
 *  @return
 */

- (void)registerOfSendMessageWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  提交并注册
 *
 *  @param
 *
 *  @return
 */

- (void)registerAndSubmitWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  忘记密码-----校验验证码，验证手机号和验证码是否匹配
 *
 *  @param
 *
 *  @return
 */

- (void)validateTelephoneAndSecurityCodeWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  修改密码
 *
 *  @param
 *
 *  @return
 */

- (void)changePasswordWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  根据关键字查询学校
 *
 *  @param
 *
 *  @return
 */

- (void)searchCollegeWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  更新个人用户资料
 *
 *  @param
 *
 *  @return
 */

- (void)updateStudentInfoWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

/**
 *  @brief  更新导师用户资料
 *
 *  @param
 *
 *  @return
 */

- (void)updateTeacherInfoWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

/**
 *  @brief  上传用户头像
 *
 *  @param
 *
 *  @return
 */

- (void)uploadImageWithParams:(NSDictionary *)params withUploadDic:(NSDictionary *)uploadDic withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
#pragma mark - 大学社团
#pragma mark - 1.热门活动
/**
 *  @brief  热门活动数据列表显示
 *
 *  @param
 *
 *  @return
 */

- (void)getHotActivityDataWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;


#pragma mark - 2.明星社团
/**
 *  @brief  明星社团数据列表显示
 *
 *  @param
 *
 *  @return
 */

- (void)getStartCommunityDataWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
#pragma mark - 3.社团纳新
/**
 *  @brief  社团纳新数据列表显示
 *
 *  @param
 *
 *  @return
 */
- (void)getCommunityNewDataWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;


#pragma mark - 大派送
/**
 *  @brief  立即兑换
 *
 *  @param
 *
 *  @return
 */
- (void)exchangeGiftWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

#pragma mark - 时间银行
/**
 *  @brief  获取查询条件
 *
 *  @param
 *
 *  @return
 */
- (void)timeBankGetConditionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  获取时间银行列表
 *
 *  @param
 *
 *  @return
 */
- (void)timeBankGetListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
#pragma mark - 校园招聘
/**
 *  @brief  获取校园招聘栏目
 *
 *  @param
 *
 *  @return
 */
- (void)getColumnsOfSchoolRecruitmentWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  获取校园招聘列表
 *
 *  @param
 *
 *  @return
 */
- (void)getListOfSchoolRecruitmentWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
@end
