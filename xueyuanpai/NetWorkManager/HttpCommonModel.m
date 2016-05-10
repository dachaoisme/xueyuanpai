//
//  HttpCommonModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "HttpCommonModel.h"

@implementation HttpResponseCodeCoModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.responseCode           =[[dic stringForKey:@"stat"] integerValue];
        self.responseMsg            = [dic stringForKey:@"msg"];
        self.responseCommonModel    = [[HttpCommonModel alloc] initWithDic:[dic dictionaryForKey:@"data"]];
    }
    
    return self;
    
}

@end

@implementation HttpCommonModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.responseCurrentPage    = [dic stringForKey:@"page"];
        self.responsePageTotalCount = [dic stringForKey:@"cnt"];
        self.responsePageLength     = [dic stringForKey:@"len"];
        self.responseDataList       = [dic arrayForKey:@"lists"];
    }
    
    return self;
}

@end
