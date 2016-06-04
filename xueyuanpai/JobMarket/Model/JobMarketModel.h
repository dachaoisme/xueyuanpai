//
//  JobMarketModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/6/4.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobMarketModel : NSObject

/*
 {"id":4,
 "thumbUrl":"http:\/\/admin.c.com\/uploads\/20160502\/14622015396953.jpg",
 "title":"fadsfa",
 "origin_price":"1",
 "sale_price":"1"}]
 
 */
///id
@property(nonatomic,strong)NSString *jobMarketId;
///图片
@property(nonatomic,strong)NSString *jobMarketIdThumbUrl;
///标题
@property(nonatomic,strong)NSString *jobMarketTitle;
///原价
@property(nonatomic,strong)NSString *jobMarketOriginPrice;
///售卖价
@property(nonatomic,strong)NSString *jobMarketSalePrice;
-(id)initWithDic:(NSDictionary *)dic;
@end

///筛选条件model
@interface JobMarketConditionCategoryModel : NSObject

///"id":"8","name":"\u5403\u996d","ord":"1"
@property(nonatomic,strong)NSString *jobMarketConditionCategoryId;
@property(nonatomic,strong)NSString *jobMarketConditionCategoryName;
@property(nonatomic,strong)NSString *jobMarketConditionCategoryOrd;

-(id)initWithDic:(NSDictionary *)dic;
@end
