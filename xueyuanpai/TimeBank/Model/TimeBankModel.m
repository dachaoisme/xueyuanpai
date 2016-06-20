//
//  TimeBankModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/25.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TimeBankModel.h"

@implementation TimeBankModel
/*

 "id":2,         //序号
 "username":1,   //用户名
 "icon":"1",     //头像
 "title":"1111", //标题
 "appointment_time":"", //预约时间
 "area":"1",     //地点
 "tasks":"111",  //任务
 "brief":"11",   //简介
 "payway":""     //支付方式
 "sex":"3",      //1男 2女 3保密
 "price":"3",      //价格
 "stat"  :1      //状态
 
 */
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.timeBankId                = [dic stringForKey:@"id"];
        self.timeBankUsername          = [dic stringForKey:@"username"];
        self.timeBankIcon              = [dic stringForKey:@"icon"] ;
        self.timeBankTitle             = [dic stringForKey:@"title"];
        self.timeBankAppointmentTime   = [dic stringForKey:@"appointment_time"];
        self.timeBankArea              = [dic stringForKey:@"area"];
        self.timeBankTasks             = [dic stringForKey:@"tasks"];
        self.timeBankBrief             = [dic stringForKey:@"brief"];
        self.timeBankPayway            = [dic stringForKey:@"payway"];
        self.timeBankSex               = [dic stringForKey:@"sex"];
        self.timeBankPrice             = [dic stringForKey:@"price"];
        self.timeBankStat              = [dic stringForKey:@"stat"];
    }
    return self;
}

@end

@implementation TimeBankConditionCategoryModel
///{"id":"8","name":"\u5403\u996d","ord":"1"}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.timeBankConditionCategoryId         = [dic stringForKey:@"id"];
        self.timeBankConditionCategoryName       = [dic stringForKey:@"name"];
        self.timeBankConditionCategoryOrd        = [dic stringForKey:@"ord"];
    }
    
    return self;
}

@end

@implementation TimeBankPayWayModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.timeBankPayWayId         = [dic stringForKey:@"id"];
        self.timeBankPayWayName       = [dic stringForKey:@"name"];
    }
    
    return self;
}

@end

@implementation TimeBankSubmitModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.timeBankSubmitTitle        = dic?[dic stringForKey:@"title"]:@"";
        self.timeBankSubmitType         = dic?[dic stringForKey:@"category_id"]:@"";
        self.timeBankSubmitTime         = dic?[dic stringForKey:@"appointment_time"]:@"";
        self.timeBankSubmitNoon         = dic?[dic stringForKey:@"noon"]:@"";
        self.timeBankSubmitAdress       = dic?[dic stringForKey:@"area"]:@"";
        self.timeBankSubmitPerson       = dic?[dic stringForKey:@"number"]:@"";
        self.timeBankSubmitPayWay       = dic?[dic stringForKey:@"payway"]:@"";
        self.timeBankSubmitDescription  = dic?[dic stringForKey:@"brief"]:@"";
        self.timeBankSubmitPrice        = dic?[dic stringForKey:@"price"]:@"";
        self.timeBankSubmitIcon         = dic?[dic stringForKey:@"icon"]:@"";
        self.timeBankSubmitPoints       = dic?[dic stringForKey:@"points"]:@"";
    }
    return self;
}

@end


@implementation TimeBankDetailModel
/*
 "id":1,                                                         //序号
 "username":3,                                                   //用户名
 "sex":3,                                                   //性别
 "price":3,                                                   //价格
 "icon":"\/backend\/web\/uploads\/20160516\/14634064623808.jpg", //头像
 "title":"\u5927\u5e45\u653e\u677e\u7684",                       //标题
 "appointment_time":"2016-03-28",                                //时间
 "noon":1,                                                       //1上午 2中午 3下午
 "area":"sadfsdda\u5c11\u65f6\u8bf5\u8bd7\u4e66ss",              //地点
 "tasks":"的撒啊撒",                                              //任务
 "brief":"1ssss",                                                //简介
 "payway":"AA",                                                   //支付方式
 "stat":1,                                                       //申领状态  0未申请 1 已申请 2 已通过 3过期 4完成
 "content":"dsafafafa",                                          //内容
 "views":1,                                                      //浏览数
 "number":8                                                      //人数
 }
 */
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.timeBankDetailId               = [dic stringForKey:@"id"];
        self.timeBankDetailUserName         = [dic stringForKey:@"username"];
        self.timeBankDetailSex              = [dic stringForKey:@"sex"];
        self.timeBankDetailPrice            = [dic stringForKey:@"price"];
        self.timeBankDetailIcon             = [dic stringForKey:@"icon"];;
        self.timeBankDetailTitle            = [dic stringForKey:@"title"];
        self.timeBankDetailAppointmentTime  = [dic stringForKey:@"appointment_time"];
        self.timeBankDetailNoon             = [dic stringForKey:@"noon"];
        self.timeBankDetailArea             = [dic stringForKey:@"area"];
        self.timeBankDetailTasks            = [dic stringForKey:@"tasks"];
        self.timeBankDetailIdBrief          = [dic stringForKey:@"brief"];
        self.timeBankDetailPayWay           = [dic stringForKey:@"payway"];
        self.timeBankDetailStat             = [dic stringForKey:@"stat"];
        self.timeBankDetailContent          = [dic stringForKey:@"content"];
        self.timeBankDetailViews            = [dic stringForKey:@"views"];
        self.timeBankDetailNumber           = [dic stringForKey:@"number"];
    }
    return self;
}

@end

@implementation TimeBankCommentModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.timeBankCommentId           = [dic stringForKey:@"id"];
        self.timeBankCommentUserId       = [dic stringForKey:@"user_id"];
        self.timeBankCommentUserName     = [dic stringForKey:@"username"];
        self.timeBankCommentIcon         = [dic stringForKey:@"icon"];
        self.timeBankCommentContent      = [dic stringForKey:@"content"];
        self.timeBankCommentCreateTime   = [dic stringForKey:@"create_at"];
    }
    return self;
}

@end
