//
//  IndexBannerModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "IndexBannerModel.h"


@implementation IndexBannerModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
   
        self.IndexBannerID            = [dic stringForKey:@"id"];
        self.IndexBannerLinkUrl       = [dic stringForKey:@"linkUrl"];
        self.IndexBannerLinkTo        = [dic stringForKey:@"linkto"];
        self.IndexBannerOrd           = [dic stringForKey:@"ord"];
        self.IndexBannerPicUrl        = [dic stringForKey:@"picUrl"];
        self.IndexBannerTitle         = [dic stringForKey:@"title"];
    }
    
    return self;
    
}

@end
