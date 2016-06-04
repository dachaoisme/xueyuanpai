//
//  TimeBankModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/25.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>
///时间银行molde
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

///筛选条件model
@interface TimeBankConditionCategoryModel : NSObject

///"id":"8","name":"\u5403\u996d","ord":"1"
@property(nonatomic,strong)NSString *timeBankConditionCategoryId;
@property(nonatomic,strong)NSString *timeBankConditionCategoryName;
@property(nonatomic,strong)NSString *timeBankConditionCategoryOrd;

-(id)initWithDic:(NSDictionary *)dic;
@end
///支付方式model
@interface TimeBankPayWayModel : NSObject

///"id":"8","name":"\u5403\u996d"
@property(nonatomic,strong)NSString *timeBankPayWayId;
@property(nonatomic,strong)NSString *timeBankPayWayName;

-(id)initWithDic:(NSDictionary *)dic;
@end

///发布时间银行model
@interface TimeBankSubmitModel : NSObject

@property(nonatomic,strong)NSString *timeBankSubmitTitle;
@property(nonatomic,strong)NSString *timeBankSubmitType;
@property(nonatomic,strong)NSString *timeBankSubmitTime;
@property(nonatomic,strong)NSString *timeBankSubmitNoon;///上午、下午和中午
@property(nonatomic,strong)NSString *timeBankSubmitAdress;
@property(nonatomic,strong)NSString *timeBankSubmitPerson;
@property(nonatomic,strong)NSString *timeBankSubmitPayWay;
@property(nonatomic,strong)NSString *timeBankSubmitDescription;
@property(nonatomic,strong)NSString *timeBankSubmitPrice;

-(id)initWithDic:(NSDictionary *)dic;
@end

///发布时间银行model
@interface TimeBankDetailModel : NSObject


///序号
@property(nonatomic,strong)NSString *timeBankDetailId;
///用户名
@property(nonatomic,strong)NSString *timeBankDetailUserName;
///性别
@property(nonatomic,strong)NSString *timeBankDetailSex;
///价格
@property(nonatomic,strong)NSString *timeBankDetailPrice;
///头像
@property(nonatomic,strong)NSString *timeBankDetailIcon;
///标题
@property(nonatomic,strong)NSString *timeBankDetailTitle;
///约会时间
@property(nonatomic,strong)NSString *timeBankDetailAppointmentTime;
///1上午 2中午 3下午
@property(nonatomic,strong)NSString *timeBankDetailNoon;
///地点
@property(nonatomic,strong)NSString *timeBankDetailArea;
///任务
@property(nonatomic,strong)NSString *timeBankDetailTasks;
///简介
@property(nonatomic,strong)NSString *timeBankDetailIdBrief;
///支付方式
@property(nonatomic,strong)NSString *timeBankDetailPayWay;
///申领状态 申领状态  0未申请 1 已申请 2 已通过 3过期 4完成
@property(nonatomic,strong)NSString *timeBankDetailStat;
///内容
@property(nonatomic,strong)NSString *timeBankDetailContent;
///浏览数
@property(nonatomic,strong)NSString *timeBankDetailViews;
///人数
@property(nonatomic,strong)NSString *timeBankDetailNumber;

-(id)initWithDic:(NSDictionary *)dic;
@end

///时间银行评论列表评论model
@interface TimeBankCommentModel : NSObject

/*
 
 {"id":2,
 "user_id":2, 
 "username":"\u4efb\u5fd7\u5f3a",
 "icon":"",
 "content":"fsdafadf",
 "create_at":"2016-05-16 23:22:46"}
 */
@property(nonatomic,strong)NSString *timeBankCommentId;
@property(nonatomic,strong)NSString *timeBankCommentUserId;
///用户名
@property(nonatomic,strong)NSString *timeBankCommentUserName;
///用户头像
@property(nonatomic,strong)NSString *timeBankCommentIcon;
///评论内容
@property(nonatomic,strong)NSString *timeBankCommentContent;
///评论创建时间
@property(nonatomic,strong)NSString *timeBankCommentCreateTime;

-(id)initWithDic:(NSDictionary *)dic;
@end
