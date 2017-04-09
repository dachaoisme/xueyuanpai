//
//  HttpCommonModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "HttpCommonModel.h"

@implementation HttpResponseCodeModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.responseCode           =[[dic stringForKey:@"stat"] integerValue];
        self.responseMsg            = [dic stringForKey:@"msg"];
        self.responseCommonDic      = [dic objectForKey:@"data"];
    }
    
    return self;
    
}

@end


@implementation HttpResponsePageModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.responseCurrentPage    = [dic stringForKey:@"page"];
        self.responsePageTotalCount = [dic stringForKey:@"cnt"];
        self.responsePageLength     = [dic stringForKey:@"len"];
    }
    
    return self;
}

@end
