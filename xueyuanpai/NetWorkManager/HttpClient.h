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

- (void)getHotActivityDataWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;


#pragma mark - 2.明星社团
/**
 *  @brief  明星社团数据列表显示
 *
 *  @param
 *
 *  @return
 */

- (void)getStartCommunityDataWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
#pragma mark - 3.社团纳新
/**
 *  @brief  社团纳新数据列表显示
 *
 *  @param
 *
 *  @return
 */
- (void)getCommunityNewDataWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;


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
/**
 *  @brief  发布需求:获取支付方式
 *
 *  @param
 *
 *  @return
 */
- (void)timeBankGetPayWayWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  发布需求:提交发布时间银行
 *
 *  @param
 *
 *  @return
 */
- (void)timeBankSubmitWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  时间银行详情
 *
 *  @param
 *
 *  @return
 */
- (void)timeBankDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  申领项目
 *
 *  @param
 *
 *  @return
 */
- (void)timeBankProjectWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  增加浏览次数
 *
 *  @param
 *
 *  @return
 */
- (void)timeBankAddScanNumWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  时间银行添加评论
 *
 *  @param
 *
 *  @return
 */
- (void)timeBankAddCommentWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
/**
 *  @brief  时间银行评论列表
 *
 *  @param
 *
 *  @return
 */
- (void)timeBankCommentListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///时间银行，发布需求照片上传
- (void)uploadTimeBankIconWithParams:(NSDictionary *)params withUploadDic:(NSDictionary *)uploadDic withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

#pragma mark - 校园招聘
///获取校园招聘栏目
- (void)getColumnsOfSchoolRecruitmentWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///获取校园招聘列表
- (void)getListOfSchoolRecruitmentWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///获取校园招聘详情接口
- (void)getSchoolRecruitmentDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

#pragma mark - 跳蚤市场
///跳蚤市场，获取筛选条件
- (void)getJobMarketConditionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///跳蚤市场，获取列表
- (void)jobMarketGetListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///跳蚤市场，跳蚤市场详情
- (void)jobMarketDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///跳蚤市场，发布跳蚤市场
- (void)jobMarketSubmitWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///跳蚤市场，发布需求照片上传
- (void)uploadJobMarketIconWithParams:(NSDictionary *)params withUploadDic:(NSDictionary *)uploadDic withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
#pragma mark - 创业中心
///创业新闻
- (void)businessCenterGetListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///创业大赛
- (void)businessCenterGetCompetitionListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///创业讲堂
- (void)businessCenterGetSchoolRoomListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///创业讲堂详情
- (void)businessCenterGetSchoolRoomDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///创业讲堂 立即报名
- (void)businessCenterBaoMingWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///创业项目
- (void)businessCenterGetProgectListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///创业项目分类
- (void)getbusinessCenterConditionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///创业项目详情
- (void)businessCenterGetProjectDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///明星导师&创业导师
- (void)businessCenterGetTeachersListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///导师详情
- (void)businessCenterGetTeachersDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///创业中心发布项目
- (void)businessCenterSubmitWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

#pragma mark - 我的
///个人中心-我的项目
- (void)mineProgectListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///个人中心-跳蚤市场
- (void)mineToGetjobMarketListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///个人中心-我的收藏
- (void)mineToGetCollectionListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///个人中心-我的时间银行
- (void)mineToGetTimeBankListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///个人中心-我的积分
- (void)mineToGetPointsListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///个人中心-我的钱包
- (void)mineToGetWalletsListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///个人中心-意见反馈
- (void)feedBackWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

///个人中心-关于我们
- (void)aboutUsWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

#pragma mark - 收藏相关
///添加收藏
- (void)addCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///取消收藏
- (void)cancelCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///验证是否已经被收藏
- (void)checkCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

#pragma mark - 快递中心
///获取快递员数目
- (void)expressCenterGetExpressPeopleWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///分配的快递员
- (void)expressCenterDistributeExpressPeopleWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///发快递
- (void)expressCenterSendExpressWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///取消发快递
- (void)expressCenterCancelExpressWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
///我的发送快递记录
- (void)expressCenterExpressListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
@end


