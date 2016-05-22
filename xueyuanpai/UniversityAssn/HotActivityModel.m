//
//  HotActivityModel.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "HotActivityModel.h"

@implementation HotActivityModel

/*
 "id":3,
 "title":"ddedd",
 "place":"dd",
 "brief":"dd",
 "logoUrl":"http:\/\/admin.c.com\/uploads\/20160504\/14623994142027.jpg",
 "content":"aa",
 "author":"d",
 "create_at":"2016-05-05 04:50:46"
 */

- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        
        
        self.hotActivityID            = [dic stringForKey:@"id"];
        self.title                    = [dic stringForKey:@"title"];
        self.place                    = [dic stringForKey:@"place"];
        self.brief                    = [dic stringForKey:@"brief"];
        self.logoUrl                  = [dic stringForKey:@"logoUrl"];
        self.content                  = [dic stringForKey:@"content"];
        self.author                   = [dic stringForKey:@"author"];
        self.createTime               = [dic stringForKey:@"create_at"];

    }
    return self;
    
}

@end
