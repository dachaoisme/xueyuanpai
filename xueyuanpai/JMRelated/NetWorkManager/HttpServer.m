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
-(void)postWithMethod:(NSString *)methond withParams:(NSDictionary *)dic withUploadDic:(NSDictionary *)uploadDic withSuccess:(XYPBaseBlock)successBlock withFailBlock:(XYPHttpErrorBlock)failBlock
{
    NSMutableString *tempUrl =[NSMutableString stringWithString:baseApiUrl];// baseUrl ;
    [tempUrl appendString:methond];
    /*
    //获取当前时间apptime
    NSString *appCurrentTimeString = [NSString stringWithFormat:@"%ld", time(NULL)];//转为字符型
    //加密MD5KEY
    NSString * md5key = @"8409-4E89-A81A-B7FF-u(#d";
    NSString *sign = [[CommonUtils md5:[appCurrentTimeString stringByAppendingString:md5key]] uppercaseString];
    [tempUrl appendString:[NSString stringWithFormat:@"?apptime=%@&sign=%@",appCurrentTimeString,sign]];
     
     */
    NSString * urlStr = tempUrl;
    // 1.创建AFN管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil];
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //替换ContentType类型
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    
    // 2.利用AFN管理者发送请求
    [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (uploadDic.allKeys.count>0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            for (int i = 0; i < uploadDic.allKeys.count; i++) {
                
                NSData *imageData = uploadDic.allValues[i];
                NSString *imageKey = uploadDic.allKeys[i];
                [formData appendPartWithFileData:imageData name:imageKey fileName:fileName mimeType:@"file"];
            }
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        HttpResponseCodeModel * model = [[HttpResponseCodeModel alloc]initWithDic:responseObject];
        
        successBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [CommonUtils showToastWithStr:@"请求数据失败"];
        failBlock(error);
    }];
   
}
-(void)getWithMethod:(NSString *)methond withParams:(NSDictionary *)dic withSuccess:(XYPBaseBlock)successBlock withFailBlock:(XYPHttpErrorBlock)failBlock
{
    //url
    NSMutableString *tempUrl =[NSMutableString stringWithString:baseApiUrl];// baseUrl ;
    [tempUrl appendString:methond];
    /*
    //获取当前时间apptime
    NSString *appCurrentTimeString = [NSString stringWithFormat:@"%ld", time(NULL)];//转为字符型
    //加密MD5KEY
    NSString * md5key = @"8409-4E89-A81A-B7FF-u(#d";
    NSString *sign = [[CommonUtils md5:[appCurrentTimeString stringByAppendingString:md5key]] uppercaseString];
    
    NSMutableDictionary * mutDic = [NSMutableDictionary dictionary];
    [mutDic addEntriesFromDictionary:dic];
    [mutDic setObject:appCurrentTimeString forKey:@"apptime"];
    [mutDic setObject:sign forKey:@"sign"];
    
    for (int i = 0; i<[mutDic allKeys].count; i++) {
        
        NSString * key = [[mutDic allKeys]objectAtIndex:i];
        NSString * value = [mutDic objectForKey:key];
        
        if (i == [mutDic allKeys].count-1) {
            NSString * str = [NSString stringWithFormat:@"%@=%@",key,value];
            [tempUrl appendString:str];
        }else{
            NSString * str = [NSString stringWithFormat:@"%@=%@&",key,value];
            [tempUrl appendString:str];
        }
    }
    //编码
    NSString * urlStr = [tempUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     */
    //编码
    NSString * urlStr = tempUrl;
    //2.管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //替换ContentType类型
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil];
    [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    //3.请求
    [manager GET:urlStr parameters:dic success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"GET --> %@, %@", responseObject, [NSThread currentThread]); //自动返回主线程
        HttpResponseCodeModel * model = [[HttpResponseCodeModel alloc]initWithDic:responseObject];
        
        successBlock(model);
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"%@", error);

        [CommonUtils showToastWithStr:@"请求数据失败"];
        failBlock(error);
    }];
}

@end
