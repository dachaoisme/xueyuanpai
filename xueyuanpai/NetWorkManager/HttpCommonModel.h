//
//  HttpCommonModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpCommonModel : NSObject

@property(nonatomic,strong)NSString     *responseCurrentPage;    //当前页数
@property(nonatomic,strong)NSString     *responsePageTotalCount; //总页数数
@property(nonatomic,strong)NSString     *responsePageLength;     //每页的数目
@property(nonatomic,strong)NSArray      *responseDataList;       //返回的数据列表
-(id)initWithDic:(NSDictionary *)dic;
@end


@interface HttpResponseCodeCoModel : NSObject


@property(nonatomic,assign)ResponseCode         responseCode;           //类型
@property(nonatomic,strong)NSString            *responseMsg;            //返回的message
@property(nonatomic,strong)HttpCommonModel     *responseCommonModel;    //data里面的数据

-(id)initWithDic:(NSDictionary *)dic;
@end

