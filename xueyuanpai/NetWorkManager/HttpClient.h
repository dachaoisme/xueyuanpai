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
/*
 *  @brief 获取首页轮播图
 */
- (void)getBannerOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

/*
 *  @brief 获取首页栏目分类
 */
- (void)getColumnsOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;

/*
 *  @brief 获取首页栏目分类
 */
- (void)getMallOfIndexWithParams:(NSDictionary *)params withSuccessBlock:(XYPCommonBlock)successBlock withFaileBlock:(XYPHttpErrorBlock)failBlock;
@end
