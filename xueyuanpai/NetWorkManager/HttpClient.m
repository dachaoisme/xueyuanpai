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

/*
 *  @brief 获取首页轮播图
 */
- (void)getBannerOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_BANNER withParams:params withSuccess:^(HttpResponseCodeCoModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

/*
 *  @brief 获取首页栏目分类
 */
- (void)getColumnsOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_COLUMNS withParams:params withSuccess:^(HttpResponseCodeCoModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

/*
 *  @brief 获取首页栏目分类
 */
- (void)getMallOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock
{
    [[HttpServer sharedInstance]getWithMethod:METHOD_OF_MALL withParams:params withSuccess:^(HttpResponseCodeCoModel *model) {
        successBlock(model);
    } withFailBlock:^(NSError *error) {
        failBlock(error);
    }];
}

@end
