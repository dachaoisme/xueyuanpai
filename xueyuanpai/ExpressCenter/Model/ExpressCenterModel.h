//
//  ExpressCenterModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressCenterModel : NSObject

@end


#pragma mark - 快递员信息model
@interface ExpressCenterPeopleModel : NSObject
/*
 "user_id": 2,
 "icon": "",
 "realname": "11",
 "nickname": "任志强",
 "mobile": "15910985232",
 "grade": ""
 */
///快递员Id
@property(nonatomic,strong)NSString *ExpressCenterPeopleId;
///快递员头像
@property(nonatomic,strong)NSString *ExpressCenterPeopleImg;
///快递员真实名字
@property(nonatomic,strong)NSString *ExpressCenterPeopleRealName;
///快递员昵称
@property(nonatomic,strong)NSString *ExpressCenterPeopleNickName;
///快递员手机
@property(nonatomic,strong)NSString *ExpressCenterPeopleMobile;
///快递员等级
@property(nonatomic,strong)NSString *ExpressCenterPeopleGrade;

-(id)initWithDic:(NSDictionary *)dic;
@end

#pragma mark - 快递信息model
@interface ExpressCenterExpressInfoModel : NSObject
/*
 "id": 1,
 "courier_name": "dsasf",
 "courier_icon": "",
 "create_time": "刚刚",
 "address": "大法",
 "fetchtime": "打法是否大师傅",
 "telphone": "大法",
 "status": "已取件",//取件状态 -1 取消取件 0 等待取件 1已取件
 "create_at": "2016-06-04 23:21:30"
 */
///快件Id
@property(nonatomic,strong)NSString *expressCenterExpressInfoId;
///快递员名字
@property(nonatomic,strong)NSString *expressCenterExpressInfoExpressPeopleName;
///快递员头像
@property(nonatomic,strong)NSString *expressCenterExpressInfoExpressPeopleImg;
///快递员创建时间---标记时间。类似，刚刚、一小时前什么的
@property(nonatomic,strong)NSString *expressCenterExpressInfoCreateTime;
///快递地址
@property(nonatomic,strong)NSString *expressCenterExpressInfoAdress;
///快递取件时间
@property(nonatomic,strong)NSString *expressCenterExpressInfoFetchTime;
///快递联系电话
@property(nonatomic,strong)NSString *expressCenterExpressInfoFetchTelephone;
///status "已取件",//取件状态 -1 取消取件 0 等待取件 1已取件
@property(nonatomic,strong)NSString *expressCenterExpressInfoStatus;
///快件具体发生时间
@property(nonatomic,strong)NSString *expressCenterExpressInfoDetailCreateTime;
-(id)initWithDic:(NSDictionary *)dic;
@end

#pragma mark - 发送的快递信息model
@interface ExpressCenterReceiveMessageModel : NSObject
/*
 {
 "msg_id": 3,
 "title": "快递消息",
 "msg": "请到学校门口取件",
 "is_read": 0,
 "create_at": "2016-07-01 06:08:34"
 }
 */
///快件Id
@property(nonatomic,strong)NSString *ExpressCenterReceiveMessageId;
///快件消息title
@property(nonatomic,strong)NSString *ExpressCenterReceiveMessageTitle;
///快件消息消息
@property(nonatomic,strong)NSString *ExpressCenterReceiveMessageMsg;
///快件消息是否已读
@property(nonatomic,assign)BOOL      yesExpressCenterReceiveMessageIsRead;
///快件消息时间
@property(nonatomic,strong)NSString *ExpressCenterReceiveMessageTime;


-(id)initWithDic:(NSDictionary *)dic;
@end
