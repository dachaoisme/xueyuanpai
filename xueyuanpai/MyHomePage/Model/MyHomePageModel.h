//
//  MyHomePageModel.h
//  xueyuanpai
//
//  Created by 王园园 on 16/7/8.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHomePageModel : NSObject

/*
 {
 "college_id" = 6;
 "college_name" = "\U5409\U6797\U519c\U4e1a\U5927\U5b66";
 company = "";
 email = "";
 icon = "http://114.215.111.210";
 idcard = "";
 "is_friend" = 1;   //好友关系  1好友 0 非好友
 job = "";
 mobile = 13601394332;
 nickname = "";
 points = 240;
 realname = "";
 role = 1;
 sex = 1;
 skillful = "";
 telphone = "";
 tutorbackground = "";  //"擅长领域
 "user_id" = 31;
 }

 */

///大学ID
@property (nonatomic,strong)NSString *myHomePageCollegeID;
///大学名称
@property (nonatomic,strong)NSString *myHomePageCollegeName;
///公司
@property (nonatomic,strong)NSString *myHomePageCompony;
///邮箱
@property (nonatomic,strong)NSString *myHomePageEmail;
///头像
@property (nonatomic,strong)NSString *myHomePageIcon;

@property (nonatomic,strong)NSString *myHomePageIdCard;

///好友关系
@property (nonatomic,strong)NSString *myHomePageIsFriend;
///工作
@property (nonatomic,strong)NSString *myHomePageJob;
///电话
@property (nonatomic,strong)NSString *myHomePageMobile;
///昵称
@property (nonatomic,strong)NSString *myHomePageNickName;
///积分
@property (nonatomic,strong)NSString *myHomePagePoints;
///真实姓名
@property (nonatomic,strong)NSString *myHomePageRealName;
///学生，老师角色
@property (nonatomic,strong)NSString *myHomePageRole;
///性别
@property (nonatomic,strong)NSString *myHomePageSex;
///擅长领域
@property (nonatomic,strong)NSString *myHomePageSkillful;
///联系方式
@property (nonatomic,strong)NSString *myHomePageTelphone;
///擅长领域
@property (nonatomic,strong)NSString *myHomePageTutorbackground;
///用户id
@property (nonatomic,strong)NSString *myHomePageUserId;


-(id)initWithDic:(NSDictionary *)dic;







@end
