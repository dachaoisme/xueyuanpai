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

///详情id
@property(nonatomic,strong)NSString *jobMarketDetailId;
///图片数组
@property(nonatomic,strong)NSMutableArray *jobMarketDetailImageArr;
///标题
@property(nonatomic,strong)NSString *jobMarketDetailTitle;
///原价
@property(nonatomic,strong)NSString *jobMarketDetailOrginPrice;
///计算价格
@property(nonatomic,strong)NSString *jobMarketDetailSalePrice;
///创建时间
@property(nonatomic,strong)NSString *jobMarketDetailCreateTime;
///宝贝描述
@property(nonatomic,strong)NSString *jobMarketDetailDescription;
///用户名
@property(nonatomic,strong)NSString *jobMarketDetailUserName;
///头像
@property(nonatomic,strong)NSString *jobMarketDetailIcon;
///电话
@property(nonatomic,strong)NSString *jobMarketDetailMobile;
///大学
@property(nonatomic,strong)NSString *jobMarketDetailCollege;
-(id)initWithDic:(NSDictionary *)dic;
@end

///发布跳蚤市场model
@interface PublishJobMarketModel : NSObject
/*
 user_id           int        必需    用户序号
 title             string     必需    标题
 images            string     必需    照片 多个以;号分隔
 cat_id            int        必需    分类序号
 sale_price        int        必需    销售价格
 origin_price      int        必需    原价
 college_id        int        必需    学校序号
 telphone          string     必需    联系方式
 description       string     必需    描述 */

///用户序号
@property(nonatomic,strong)NSString *publicJobMarketId;
///标题
@property(nonatomic,strong)NSString *publicJobMarketTitle;
///照片
@property(nonatomic,strong)NSString *publicJobMarketImages;
///分类序号
@property(nonatomic,strong)NSString *publicJobMarketCategoryId;
///分类序号
@property(nonatomic,strong)NSString *publicJobMarketCategoryName;
///销售价格
@property(nonatomic,strong)NSString *publicJobMarketSalePrice;
///原价
@property(nonatomic,strong)NSString *publicJobMarketOriginPrice;
///学校序号
@property(nonatomic,strong)NSString *publicJobMarketCollegeId;
///联系方式
@property(nonatomic,strong)NSString *publicJobMarketTelephone;
///描述
@property(nonatomic,strong)NSString *publicJobMarketDescription;
-(id)initWithDic:(NSDictionary *)dic;
@end



