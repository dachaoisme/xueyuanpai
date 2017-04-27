//
//  JMMessageModel.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/21.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMMessageUserModel : NSObject

/////////////////////评论列表item/////////////////////
///entity_type 类型     必需   可选项: project 创业项目  salon创业沙龙 course 创业课程
/*
 "user": {
 "id": 1,
 "nickname": "1",
 "icon": "1",
 "telphone": "13718360864"
 }
 
 */

@property(nonatomic,strong)NSString *messageUserId;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *telphone;

@end

@interface JMMessageModel : NSObject

/*
 "id": "3",
 "message": "saaa",  //消息内容
 "linkUrl": "",      //链接地址
 "user": {
     "user_id": 1,
     "nickname": "aaaa",  //用户昵称
     "telphone": "13718360863",  //手机号
     "icon": "1"      //头像
 },
 "time": "27分钟前"
 
 
 
 */


@property(nonatomic,strong)NSString *messageId;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSString *linkUrl;
@property(nonatomic,strong)NSString *is_readed;////1表示已读 0表示未读
@property(nonatomic,strong)JMMessageUserModel *user;
@property(nonatomic,strong)NSString *time;

@end
