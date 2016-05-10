//
//  HttpServer.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "HttpServer.h"

@implementation HttpServer

+ (instancetype)sharedInstance {
    
    static HttpServer *instance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
        
    });
    
    return instance;
}

-(void)getWithMethod:(NSString *)methond withParams:(NSDictionary *)dic withSuccess:(XYPCommonBlock)successBlock withFailBlock:(XYPHttpErrorBlock)failBlock
{
    //url
    NSMutableString *tempUrl =[NSMutableString stringWithString:baseApiUrl];// baseUrl ;
    [tempUrl appendString:methond];
    for (int i = 0; i<[dic allKeys].count; i++) {
        
        NSString * key = [[dic allKeys]objectAtIndex:i];
        NSString * value = [dic objectForKey:key];
        
        if (i == [dic allKeys].count-1) {
            NSString * str = [NSString stringWithFormat:@"%@=%@",key,value];
            [tempUrl appendString:str];
        }else{
            NSString * str = [NSString stringWithFormat:@"%@=%@&",key,value];
            [tempUrl appendString:str];
        }
    }
  
    //2.管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //替换ContentType类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    //3.请求
    [manager GET:tempUrl parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"GET --> %@, %@", responseObject, [NSThread currentThread]); //自动返回主线程
        HttpResponseCodeCoModel * model = [[HttpResponseCodeCoModel alloc]initWithDic:responseObject];
        
        successBlock(model);
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@", error);
        [CommonUtils showToastWithStr:@"请检查您的网络"];
        failBlock(error);
    }];
}

@end
