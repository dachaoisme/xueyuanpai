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
        self.timeBankIcon              = [CommonUtils getEffectiveUrlWithUrl:[dic stringForKey:@"icon"] withType:1];
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
        
        self.timeBankSubmitTitle        = @"";
        self.timeBankSubmitType         = @"";
        self.timeBankSubmitTime         = @"";
        self.timeBankSubmitNoon         = @"";
        self.timeBankSubmitAdress       = @"";
        self.timeBankSubmitPerson       = @"";
        self.timeBankSubmitPayWay       = @"";
        self.timeBankSubmitDescription  = @"";
        self.timeBankSubmitPrice        = @"";
    }
    return self;
}

@end
