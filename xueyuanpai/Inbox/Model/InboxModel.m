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
