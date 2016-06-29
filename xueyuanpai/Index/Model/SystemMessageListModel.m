//
//  SystemMessageListModel.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SystemMessageListModel.h"

@implementation SystemMessageListModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.messageID        = [dic stringForKey:@"msg_id"];
        self.messageTitle      = [dic stringForKey:@"title"];
        self.messageContent    = [dic stringForKey:@"msg"];
        self.messageIsRead       = [dic stringForKey:@"is_read"];
        self.messageCreateTime       = [dic stringForKey:@"create_at"];

    }
    
    return self;
}


@end
