//
//  ExpressCenterModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ExpressCenterModel.h"

@implementation ExpressCenterModel

@end


@implementation ExpressCenterPeopleModel

-(id)initWithDic:(NSDictionary *)dic
{

    self = [super init];
    if (self) {
        self.ExpressCenterPeopleId              = [dic stringForKey:@"user_id"];
        self.ExpressCenterPeopleImg             = [dic stringForKey:@"icon"];
        self.ExpressCenterPeopleRealName        = [dic stringForKey:@"realname"];
        self.ExpressCenterPeopleNickName        = [dic stringForKey:@"nickname"];
        self.ExpressCenterPeopleMobile          = [dic stringForKey:@"mobile"];
        self.ExpressCenterPeopleGrade           = [dic stringForKey:@"grade"];
    }
    return self;
}

@end

@implementation ExpressCenterExpressInfoModel

-(id)initWithDic:(NSDictionary *)dic
{
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
    self = [super init];
    if (self) {
        self.expressCenterExpressInfoId                    = [dic stringForKey:@"id"];
        self.expressCenterExpressInfoExpressPeopleName     = [dic stringForKey:@"courier_name"];
        self.expressCenterExpressInfoExpressPeopleImg      = [dic stringForKey:@"courier_icon"];
        self.expressCenterExpressInfoCreateTime            = [dic stringForKey:@"create_time"];
        self.expressCenterExpressInfoAdress                = [dic stringForKey:@"address"];
        self.expressCenterExpressInfoFetchTime             = [dic stringForKey:@"fetchtime"];
        self.expressCenterExpressInfoFetchTelephone        = [dic stringForKey:@"telphone"];
        self.expressCenterExpressInfoStatus                = [dic stringForKey:@"status"];
        self.expressCenterExpressInfoDetailCreateTime      = [dic stringForKey:@"create_at"];
    }
    return self;
}

@end

