//
//  IndexMallModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexMallModel : NSObject

/*
 "id":2,             //序号
 "title":"xcdddd",  //标题
 "thumbUrl":"http:\/\/admin.c.com\/uploads\/20160504\/14624022816617.png", //缩略图
 "points":"q"   //积分
 ,"college_name":"\u5317\u4eac\u5e08\u8303\u5927\u5b66",//所在学校
 "description":"xcxzz", //礼品描述
  "leftnum":10,  //剩余份数
 "exchangemethod":"czzzc" //兑换方法
 */

@property(nonatomic,strong)NSString * indexMallId;
@property(nonatomic,strong)NSString * indexMallTitle;
@property(nonatomic,strong)NSString * indexMallThumbUrl;
@property(nonatomic,strong)NSString * indexMallPoints;
@property(nonatomic,strong)NSString * indexMallCollegeName;
@property(nonatomic,strong)NSString * indexMallDescription;
@property(nonatomic,strong)NSString * indexMallleftNumber;
@property(nonatomic,strong)NSString * indexMallExchangemethod;

-(id)initWithDic:(NSDictionary *)dic;

@end
