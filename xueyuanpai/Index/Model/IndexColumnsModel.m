//
//  IndexColumnsModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "IndexColumnsModel.h"

@implementation IndexColumnsModel


/*
 
 "id":1,
 "name":"\u6d4b\u8bd5\u6807\u9898",
 "picUrl":"\/uploads\/20160501\/14620726009400.png",
 "ord":1
 */
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.indexColumnsId        = [dic stringForKey:@"id"];
        self.indexColumnsName      = [dic stringForKey:@"name"];
        self.indexColumnsPicUrl    = [dic stringForKey:@"picUrl"];//[dic stringForKey:@"picUrl"];
        self.indexColumnsOrd       = [dic stringForKey:@"ord"];
    }
    
    return self;
}


@end
