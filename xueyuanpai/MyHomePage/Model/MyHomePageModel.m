//
//  MyHomePageModel.m
//  xueyuanpai
//
//  Created by 王园园 on 16/7/8.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MyHomePageModel.h"

@implementation MyHomePageModel
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


-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.myHomePageCollegeID          = [dic stringForKey:@"college_id"];
        self.myHomePageCollegeName        = [dic stringForKey:@"college_name"];
        self.myHomePageCompony            = [dic stringForKey:@"company"];
        self.myHomePageEmail              = [dic stringForKey:@"email"];
        self.myHomePageIcon               = [dic stringForKey:@"icon"];
        self.myHomePageIdCard             = [dic stringForKey:@"idcard"];;
        self.myHomePageIsFriend            = [dic stringForKey:@"is_friend"];
        self.myHomePageJob                 = [dic stringForKey:@"job"];
        self.myHomePageMobile             = [dic stringForKey:@"mobile"];
        self.myHomePageNickName             = [dic stringForKey:@"nickname"];
        self.myHomePagePoints            = [dic stringForKey:@"points"];
        self.myHomePageRealName          = [dic stringForKey:@"realname"];
        self.myHomePageRole           = [dic stringForKey:@"role"];
        self.myHomePageSex             = [dic stringForKey:@"sex"];
        self.myHomePageSkillful          = [dic stringForKey:@"skillful"];
        self.myHomePageTelphone            = [dic stringForKey:@"telphone"];
        self.myHomePageUserId           = [dic stringForKey:@"user_id"];
        self.myHomePageTutorbackground = [dic stringForKey:@"tutorbackground"];

    }
    return self;
}


@end
