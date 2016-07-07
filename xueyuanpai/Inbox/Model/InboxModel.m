//
//  InboxModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/7/4.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "InboxModel.h"

@implementation InboxModel

@end

@implementation InboxProgectModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.inboxProgectMessageId           = [dic stringForKey:@"msg_id"];
        self.inboxProgectMessageTitle        = [dic stringForKey:@"title"];
        self.inboxProgectMessageMsg          = [dic stringForKey:@"msg"];
        self.inboxProgectMessageExtra        = [dic stringForKey:@"extra"];
        self.inboxProgectMessageIsRead       = [dic stringForKey:@"is_read"];
        self.inboxProgectMessageCreateTime   = [dic stringForKey:@"create_at"];
    }
    
    return self;
}

@end

@implementation InboxInsideMessageModel

-(id)initWithDic:(NSDictionary *)dic
{

    self = [super init];
    if (self) {
        
        self.inboxInsideMessageId           = [dic stringForKey:@"msg_id"];
        self.inboxInsideMessageTitle        = [dic stringForKey:@"title"];
        self.inboxInsideMessageMsg          = [dic stringForKey:@"msg"];
        self.inboxInsideMessageExtra        = [dic stringForKey:@"extra"];
        self.inboxInsideMessageIsRead       = [dic stringForKey:@"is_read"];
        self.inboxInsideMessageCreateTime   = [dic stringForKey:@"create_at"];
    }
    
    return self;
}

@end

@implementation TimeBankMessageModel

-(id)initWithDic:(NSDictionary *)dic
{
    
    self = [super init];
    if (self) {
        
        self.timeBankMessageId           = [dic stringForKey:@"msg_id"];
        self.timeBankMessageTitle        = [dic stringForKey:@"title"];
        self.timeBankMessageMsg          = [dic stringForKey:@"msg"];
        self.timeBankMessageExtra        = [dic stringForKey:@"extra"];
        self.timeBankMessageIsRead       = [dic stringForKey:@"is_read"];
        self.timeBankMessageCreateTime   = [dic stringForKey:@"create_at"];
    }
    
    return self;
}


@end

