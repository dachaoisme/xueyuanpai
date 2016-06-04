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

///跳蚤市场model
@interface JobMarketDetailModel : NSObject
/*
 "id":5,       //序号
 "images":["dasd"], //照片列表
 "title":"daafdas", //标题
 "origin_price":"1", //原价
 "sale_price":"2",  //市场价
 "create_at":"2016-05-22 12:45:08",
 "description":"desc",  //描述
 "username":"\u591a\u4f26\u591a",  //用户名
 "icon":"",  //用户头像
 "mobile":"15010121545", //联系方式
 "college":"\u5c71\u4e1c\u7406\u5de5\u5927\u5b66" //学校
 
 */

///序号
@property(nonatomic,strong)NSString *jobMarketDetailId;
///用户名
@property(nonatomic,strong)NSMutableArray *jobMarketDetailImageArr;
///性别
@property(nonatomic,strong)NSString *jobMarketDetailTitle;
///价格
@property(nonatomic,strong)NSString *jobMarketDetailOrginPrice;
///头像
@property(nonatomic,strong)NSString *jobMarketDetailSalePrice;
///标题
@property(nonatomic,strong)NSString *jobMarketDetailCreateTime;
///约会时间
@property(nonatomic,strong)NSString *jobMarketDetailDescription;
///1上午 2中午 3下午
@property(nonatomic,strong)NSString *jobMarketDetailUserName;
///地点
@property(nonatomic,strong)NSString *jobMarketDetailIcon;
///任务
@property(nonatomic,strong)NSString *jobMarketDetailMobile;
///简介
@property(nonatomic,strong)NSString *jobMarketDetailCollege;
-(id)initWithDic:(NSDictionary *)dic;
@end

