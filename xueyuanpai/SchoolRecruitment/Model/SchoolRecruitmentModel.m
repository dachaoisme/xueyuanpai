//
//  SchoolRecruitmentModel.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SchoolRecruitmentModel.h"

@implementation SchoolRecruitmentModel

 /*
 "id":4,
 "title":"xxx",
 "company":1,
 "salary":"2",
 "day":"05-03",
 "education":"1",
 "workinglife":1
 
 */


- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        
        self.schoolRecruitmentId           = [dic stringForKey:@"id"];
        self.schoolRecruitmentTitle        = [dic stringForKey:@"title"];
        self.schoolRecruitmentCompany      = [dic stringForKey:@"company"];
        self.schoolRecruitmentSalary       = [dic stringForKey:@"salary"];
        self.schoolRecruitmentDay          = [dic stringForKey:@"day"];
        self.schoolRecruitmentEducation    = [dic stringForKey:@"education"];
        self.schoolRecruitmentWorkinglife  = [dic stringForKey:@"workinglife"];
        
    }
    return self;
    
}

@end
