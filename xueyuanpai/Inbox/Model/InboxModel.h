//
//  InboxModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/7/4.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InboxModel : NSObject

@end

@interface InboxProgectModel : NSObject

/*
 "msg_id": 9,
 "title": "正在申请创业项目",
 "msg": "123123",
 "extra": "\"{\\\"apply_user_id\\\":\\\"11\\\",\\\"tb_id\\\":\\\"24\\\"}\"",
 "is_read": 0,
 "create_at": "2016-07-02 03:31:29"
 */
@property(nonatomic,strong)NSString *inboxProgectMessageId;
@property(nonatomic,strong)NSString *inboxProgectMessageTitle;
@property(nonatomic,strong)NSString *inboxProgectMessageMsg;
@property(nonatomic,strong)NSString *inboxProgectMessageExtra;
@property(nonatomic,strong)NSString *inboxProgectMessageIsRead;
@property(nonatomic,strong)NSString *inboxProgectMessageCreateTime;

-(id)initWithDic:(NSDictionary *)dic;
@end

///站内消息
@interface InboxInsideMessageModel : NSObject

/*
 "msg_id": 9,
 "title": "正在申请创业项目",
 "msg": "123123",
 "extra": "\"{\\\"apply_user_id\\\":\\\"11\\\",\\\"tb_id\\\":\\\"24\\\"}\"",
 "is_read": 0,
 "create_at": "2016-07-02 03:31:29"
 */
@property(nonatomic,strong)NSString *inboxInsideMessageId;
@property(nonatomic,strong)NSString *inboxInsideMessageTitle;
@property(nonatomic,strong)NSString *inboxInsideMessageMsg;
@property(nonatomic,strong)NSString *inboxInsideMessageExtra;
@property(nonatomic,strong)NSString *inboxInsideMessageIsRead;
@property(nonatomic,strong)NSString *inboxInsideMessageCreateTime;

-(id)initWithDic:(NSDictionary *)dic;
@end