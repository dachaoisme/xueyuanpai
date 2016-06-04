//
//  JobMarketModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/6/4.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "JobMarketModel.h"

@implementation JobMarketModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.jobMarketId           = [dic stringForKey:@"id"];
        self.jobMarketIdThumbUrl   =[CommonUtils getEffectiveUrlWithUrl:[dic stringForKey:@"thumbUrl"] withType:1] ;
        self.jobMarketTitle        = [dic stringForKey:@"title"];
        self.jobMarketOriginPrice  = [dic stringForKey:@"origin_price"];
        self.jobMarketSalePrice    = [dic stringForKey:@"sale_price"];
    }
    
    return self;
}

@end


@implementation JobMarketConditionCategoryModel

///{"id":"8","name":"\u5403\u996d","ord":"1"}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.jobMarketConditionCategoryId         = [dic stringForKey:@"id"];
        self.jobMarketConditionCategoryName       = [dic stringForKey:@"name"];
        self.jobMarketConditionCategoryOrd        = [dic stringForKey:@"ord"];
    }
    
    return self;
}

@end

@implementation JobMarketDetailModel

-(id)initWithDic:(NSDictionary *)dic
{
  
    self = [super init];
    if (self) {
        
        self.jobMarketDetailId               = [dic stringForKey:@"id"];
        self.jobMarketDetailTitle            = [dic stringForKey:@"title"];
        self.jobMarketDetailOrginPrice       = [dic stringForKey:@"origin_price"];
        self.jobMarketDetailSalePrice        = [dic stringForKey:@"sale_price"];;
        self.jobMarketDetailCreateTime       = [dic stringForKey:@"create_at"];
        self.jobMarketDetailDescription      = [dic stringForKey:@"description"];
        self.jobMarketDetailUserName         = [dic stringForKey:@"username"];
        self.jobMarketDetailIcon             = [dic stringForKey:@"icon"];
        self.jobMarketDetailMobile           = [dic stringForKey:@"mobile"];
        self.jobMarketDetailCollege          = [dic stringForKey:@"college"];
        self.jobMarketDetailImageArr         = [NSMutableArray array];
        for (NSString * imageUrl in [dic arrayForKey:@"images"]) {
            [self.jobMarketDetailImageArr addObject:imageUrl];
        }
        
        
    }
    return self;
}



@end