//
//  MineModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MineModel.h"

@implementation MineModel

@end

///我的收藏
@implementation MineStoreModel

-(id)initWithDic:(NSDictionary *)dic
{
    
    self = [super init];
    if (self) {
        self.mineStoreId               = [dic stringForKey:@"id"];
        self.mineStoreTitle            = [dic stringForKey:@"title"];
        self.mineStoreImage            = [dic stringForKey:@"thumbUrl"];
        self.mineStoreBrief            = [dic stringForKey:@"brief"];
        self.mineStoreCreateTime       = [dic stringForKey:@"create_at"];
    }
    return self;
}

@end
///我的积分
@implementation MinePointModel

/*
 "id": 6,
 "number": 20, //积分数量
 "msg": "大法嗯嗯",//积分记录信息
 "type": 1,//类型：1登录2兑换3充值
 "create_at": "2016-06-02 06:48:26"
 */
-(id)initWithDic:(NSDictionary *)dic
{
    
    self = [super init];
    if (self) {
        self.minePointId           = [dic stringForKey:@"id"];
        self.minePointNumber       = [dic stringForKey:@"number"];
        self.minePointMsg          = [dic stringForKey:@"msg"];
        self.minePointType         = [dic stringForKey:@"type"];
        self.minePointCreateTime   = [dic stringForKey:@"create_at"];
    }
    return self;
}

@end

///我的钱包
@implementation MineWalletModel

/*
 "id": 1,
 "amount": 200,
 "msg": "fasdfasd",
 "create_at": "2016-06-03 06:13:21"
 */

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.mineWalletId           = [dic stringForKey:@"id"];
        self.mineWalletAmount       = [dic stringForKey:@"amount"];
        self.mineWalletMsg          = [dic stringForKey:@"msg"];
        self.mineWalletCreateTime   = [dic stringForKey:@"create_at"];
    }
    return self;
}

@end


