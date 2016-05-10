//
//  HttpServer.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求失败的时候的block
typedef void(^XYPHttpErrorBlock)(NSError *error);
//常规的数据返回
typedef void(^XYPCommonBlock)(HttpResponseCodeCoModel *model);

@interface HttpServer : NSObject

/**
 *  @brief  单利初始化
 *
 *  @param
 *  @return
 */
+ (instancetype)sharedInstance;

/**
 *  @brief  get请求
 *
 *  @param  methond  表示请求的method，字段，如“v1/focus/index”
 *
 *  @param  传入的参数，在此方法里面，会把其变成字符串URL
 *
 *  @return
 */
-(void)getWithMethod:(NSString *)methond withParams:(NSDictionary *)dic withSuccess:(XYPCommonBlock)successBlock withFailBlock:(XYPHttpErrorBlock)failBlock;

@end
