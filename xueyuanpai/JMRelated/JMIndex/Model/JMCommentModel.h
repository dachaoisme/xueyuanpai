//
//  JMCommentModel.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMCommentUserModel : NSObject

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

@property(nonatomic,strong)NSString *commentUserId;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *telphone;

@end

@interface JMCommentModel : NSObject
/////////////////////评论列表item/////////////////////
///entity_type 类型     必需   可选项: project 创业项目  salon创业沙龙 course 创业课程
/*
 {
     "id": 1,
     "content": "ddddd",
     "user_id": 1,
     "entity_id": 1,
     "entity_type": "project",
     "create_time": "2017-03-25 10:30:43",
     "user": {
         "id": 1,
         "nickname": "1",
         "icon": "1",
         "telphone": "13718360864"
    }
 }
 */

@property(nonatomic,strong)NSString *commentId;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *entity_id;
@property(nonatomic,strong)NSString *entity_type;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)JMCommentUserModel*user;
@end
