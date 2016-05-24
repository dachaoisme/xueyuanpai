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
@end
