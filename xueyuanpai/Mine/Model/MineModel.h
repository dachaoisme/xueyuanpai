//
//  MineModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineModel : NSObject

@end

///我的收藏
@interface MineStoreModel : NSObject

/*
 "id": 1,
 "title": "dsfafa",
 "thumbUrl": "/upload/dafa/daf.jpg",
 "brief": "ssddddafafsf",
 "create_at": "2016-06-01 06:35:42"
 */
@property(nonatomic,strong)NSString  *mineStoreId;
@property(nonatomic,strong)NSString  *mineStoreTitle;
@property(nonatomic,strong)NSString  *mineStoreImage;
@property(nonatomic,strong)NSString  *mineStoreBrief;
@property(nonatomic,strong)NSString  *mineStoreCreateTime;
-(id)initWithDic:(NSDictionary *)dic;
@end

///我的积分
@interface MinePointModel : NSObject

/*
 "id": 6,
 "number": 20, //积分数量
 "msg": "大法嗯嗯",//积分记录信息
 "type": 1,//类型：1登录2兑换3充值
 "create_at": "2016-06-02 06:48:26"
 */

///id
@property(nonatomic,strong)NSString  *minePointId;
///积分数量
@property(nonatomic,strong)NSString  *minePointNumber;
///积分记录信息
@property(nonatomic,strong)NSString  *minePointMsg;
///积分类型 //类型：1登录2兑换3充值
@property(nonatomic,strong)NSString  *minePointType;
///创建时间
@property(nonatomic,strong)NSString  *minePointCreateTime;
-(id)initWithDic:(NSDictionary *)dic;
@end

///我的钱包
@interface MineWalletModel : NSObject

/*
 "id": 1,
 "amount": 200,
 "msg": "fasdfasd",
 "create_at": "2016-06-03 06:13:21"
 */
///id
@property(nonatomic,strong)NSString  *minePointId;
///积分数量
@property(nonatomic,strong)NSString  *minePointAmount;
///积分记录信息
@property(nonatomic,strong)NSString  *minePointMsg;
///创建时间
@property(nonatomic,strong)NSString  *minePointCreateTime;
-(id)initWithDic:(NSDictionary *)dic;
@end