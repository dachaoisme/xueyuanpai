//
//  TimeBankModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/25.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeBankModel : NSObject
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
@property(nonatomic,strong)NSString *timeBankId;
@property(nonatomic,strong)NSString *timeBankUsername;
@property(nonatomic,strong)NSString *timeBankIcon;
@property(nonatomic,strong)NSString *timeBankTitle;
@property(nonatomic,strong)NSString *timeBankAppointmentTime;
@property(nonatomic,strong)NSString *timeBankArea;
@property(nonatomic,strong)NSString *timeBankTasks;
@property(nonatomic,strong)NSString *timeBankBrief;
@property(nonatomic,strong)NSString *timeBankPayway;
@property(nonatomic,strong)NSString *timeBankSex;
@property(nonatomic,strong)NSString *timeBankPrice;
@property(nonatomic,strong)NSString *timeBankStat;

-(id)initWithDic:(NSDictionary *)dic;
@end


@interface TimeBankConditionCategoryModel : NSObject

///"id":"8","name":"\u5403\u996d","ord":"1"
@property(nonatomic,strong)NSString *timeBankConditionCategoryId;
@property(nonatomic,strong)NSString *timeBankConditionCategoryName;
@property(nonatomic,strong)NSString *timeBankConditionCategoryOrd;

-(id)initWithDic:(NSDictionary *)dic;
@end