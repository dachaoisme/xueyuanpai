//
//  CollegeModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "CollegeModel.h"

@implementation CollegeModel


-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.collegeID        = [dic stringForKey:@"id"];
        self.collegeName     = [dic stringForKey:@"name"];
        self.collegeProvinceID  = [dic stringForKey:@"province_id"];
        self.collegeOrd    = [dic stringForKey:@"ord"];
    }
    
    return self;
}



@end
