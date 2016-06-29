//
//  SystemMessageListModel.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemMessageListModel : NSObject

/*
 "msg_id": 3,
 "title": "sssssss",  //消息标题
 "msg": "sassssssssssssss",//消息内容
 "is_read":0,//是否已读
 "create_at": "2016-06-29 05:35:54"
 */
@property(nonatomic,strong)NSString * messageID;
@property(nonatomic,strong)NSString * messageTitle;
@property(nonatomic,strong)NSString * messageContent;
@property(nonatomic,strong)NSString * messageIsRead;
@property(nonatomic,strong)NSString * messageCreateTime;

-(id)initWithDic:(NSDictionary *)dic;



@end
