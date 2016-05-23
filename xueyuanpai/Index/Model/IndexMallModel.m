//
//  IndexMallModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "IndexMallModel.h"

@implementation IndexMallModel

/*
"id":2,             //序号
"title":"xcdddd",  //标题
"thumbUrl":"http:\/\/admin.c.com\/uploads\/20160504\/14624022816617.png", //缩略图
"points":"q"   //积分
 "college_name":"\u5317\u4eac\u5e08\u8303\u5927\u5b66",//所在学校
 "description":"xcxzz", //礼品描述
 "exchangemethod":"czzzc" //兑换方法
*/

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.indexMallId        = [dic stringForKey:@"id"];
        self.indexMallTitle     = [dic stringForKey:@"title"];
        self.indexMallThumbUrl  = [dic stringForKey:@"thumbUrl"];
        self.indexMallPoints    = [dic stringForKey:@"points"];
        self.indexMallCollegeName = [dic stringForKey:@"college_name"];
        self.indexMallDescription = [dic stringForKey:@"description"];
        self.indexMallExchangemethod = [dic stringForKey:@"exchangemethod"];
    }
    
    return self;
}


@end
