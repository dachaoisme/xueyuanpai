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
 *  @brief 获取首页栏目分类
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
@end
