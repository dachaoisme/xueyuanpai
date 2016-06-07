//
//  HttpClient.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "HttpClient.h"

@implementation HttpClient


+ (instancetype)sharedInstance {
    
    static HttpClient *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}
#pragma mark - 首页相关
/*
 *  @brief 获取首页轮播图
 */
- (void)getBannerOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_BANNER withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        //banner对象
        NSDictionary * listDic = model.responseCommonDic ;
        successBlock(model,pageModel,listDic);
        
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

/*
 *  @brief 获取首页栏目分类
 */
- (void)getColumnsOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_COLUMNS withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        //banner对象
        NSDictionary * listDic = model.responseCommonDic ;
        successBlock(model,pageModel,listDic);
        
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

/*
 *  @brief 获取大派送信息
 */
- (void)getMallOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_MALL withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        //首页栏目分类对象
        NSDictionary * listDic = model.responseCommonDic ;
        successBlock(model,pageModel,listDic);
        
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
#pragma mark - 用户相关
- (void)loginWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_LOGIN withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)registerOfSendMessageWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_SEND_MESSAGE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)registerAndSubmitWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_REGISTER withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)validateTelephoneAndSecurityCodeWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_CHECKING_MESSAGE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)changePasswordWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_UPDATE_PASSWORD withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)searchCollegeWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_COLLEGE_SEARCH withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)updateStudentInfoWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_UPDATE_STUDENT_INFO withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)updateTeacherInfoWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_UPDATE_TEACHER_INFO withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)uploadImageWithParams:(NSDictionary *)params withUploadDic:(NSDictionary *)uploadDic withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]postWithMethod:METHOD_OF_UPLOAD withParams:params withUploadDic:uploadDic withSuccess:^(HttpResponseCodeModel *model) {
        
        successBlock(model);
        
    } withFailBlock:^(NSError *error) {
        
        failBlock(error);
        
    }];
    
}

#pragma mark - 大学社团
#pragma mark - 1.热门活动
- (void)getHotActivityDataWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    
    [[HttpServer sharedInstance] getWithMethod:METHOD_OF_UNIVERSITY_ACTIVITY withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,listDic);
 
    } withFailBlock:^(NSError *error) {
        failBlock(error);

    }];
}

- (void)getStartCommunityDataWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock{
    [[HttpServer sharedInstance] getWithMethod:METHOD_OF_UNIVERSITY_START_COMMUNITY withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,listDic);
        
    } withFailBlock:^(NSError *error) {
        failBlock(error);
        
    }];

}

- (void)getCommunityNewDataWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock{
    [[HttpServer sharedInstance] getWithMethod:METHOD_OF_UNIVERSITY_COMMUNITY_NEW withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,listDic);
        
    } withFailBlock:^(NSError *error) {
        failBlock(error);
        
    }];

}


#pragma mark - 大派送
- (void)exchangeGiftWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_EXCHANGE_GIFT withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

#pragma mark - 时间银行
- (void)timeBankGetConditionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_BANK_CONDITIONS withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)timeBankGetListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_BANK_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

- (void)timeBankGetPayWayWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_BANK_PAYWAY withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)timeBankSubmitWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_BANK_RELEASE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)timeBankDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_BANK_APPLY_DETAIL withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)timeBankProjectWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_BANK_APPLY_PASS withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

- (void)timeBankAddScanNumWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_BANK_ADD_SCAN withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

- (void)timeBankAddCommentWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_BANK_ADD_COMMENTS withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)timeBankCommentListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_BANK_COMMENTS withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
#pragma mark - 大学招聘
/*
 *  @brief 获取大学招聘栏目分类
 */
- (void)getColumnsOfSchoolRecruitmentWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_SCHOOL_RECRUITEMENT_COLUMNS withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        //list
        NSDictionary * listDic = model.responseCommonDic ;
        successBlock(model,pageModel,listDic);
        
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
/*
 *  @brief 获取大学招聘列表
 */
- (void)getListOfSchoolRecruitmentWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_SCHOOL_RECRUITEMENT_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        //list
        NSDictionary * listDic = model.responseCommonDic ;
        successBlock(model,pageModel,listDic);
        
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

/**
 *  @brief  获取校园招聘详情接口
 */
- (void)getSchoolRecruitmentDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPNoneListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_TIME_SCHOOL_RECRUITEMENT_Detail withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

#pragma mark - 跳蚤市场
- (void)getJobMarketConditionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_JOB_MARKET_CONDITION_CATEGORY withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

- (void)jobMarketGetListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_JOB_MARKET_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
- (void)jobMarketDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_JOB_MARKET_DETAIL withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

- (void)jobMarketSubmitWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_JOB_MARKET_ADD withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

#pragma mark - 创业中心
///创业新闻
- (void)businessCenterGetListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_BUSINESS_CENTER_NEWS_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///创业大赛
- (void)businessCenterGetCompetitionListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_BUSINESS_CENTER_COMPETITION_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///创业讲堂
- (void)businessCenterGetSchoolRoomListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_BUSINESS_CENTER_SCHOOLROOM_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///创业讲堂详情
- (void)businessCenterGetSchoolRoomDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_BUSINESS_CENTER_SCHOOLROOM_Detail withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///创业讲堂 立即报名
- (void)businessCenterBaoMingWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_BUSINESS_CENTER_SCHOOLROOM_APPLY withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///创业项目列表
- (void)businessCenterGetProgectListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_BUSINESS_CENTER_PROGECT_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///创业项目分类
- (void)getbusinessCenterConditionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_BUSINESS_CENTER_PROGECT_CATEGORY_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///创业项目详情
- (void)businessCenterGetProjectDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_BUSINESS_CENTER_PROGECT_DETAIL withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

///明星导师
- (void)businessCenterGetTeachersListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_BUSINESS_CENTER_TUTOR_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///导师详情
- (void)businessCenterGetTeachersDetailWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_BUSINESS_CENTER_TUTOR_DETAIL withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///创业中心发布项目
- (void)businessCenterSubmitWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_BUSINESS_CENTER_PROGECT_CREATE withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

#pragma mark - 我的
///个人中心-我的项目
- (void)mineProgectListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_MINE_PROGECT_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///个人中心-跳蚤市场
- (void)mineToGetjobMarketListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_MINE_JOB_MARKET_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///个人中心-我的收藏
- (void)mineToGetCollectionListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_MINE_COLLECTION_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///个人中心-我的时间银行
- (void)mineToGetTimeBankListWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonListBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_MINE_TIME_BANK_LIST withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        //Pages
        HttpResponsePageModel * pageModel = [[HttpResponsePageModel alloc]initWithDic:model.responseCommonDic];
        NSDictionary * listDic = model.responseCommonDic;
        successBlock(model,pageModel,listDic);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
#pragma mark - 收藏相关
///添加收藏
- (void)addCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_COLLECTION_ADD withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///取消收藏
- (void)cancelCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_COLLECTION_CANCEL withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
///验证是否已经被收藏
- (void)checkCollectionWithParams:(NSDictionary *)params withSuccessBlock:(XYPBaseBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_COLLECTION_CHECK withParams:params withSuccess:^(HttpResponseCodeModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}
@end
