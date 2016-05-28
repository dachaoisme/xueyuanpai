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


@implementation SchoolRecruitmentDetailModel

- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        
        self.schoolRecruitmentDetailTitle                = [dic stringForKey:@"title"];
        self.schoolRecruitmentDetailUpdateTime           = [dic stringForKey:@"update_at"];
        self.schoolRecruitmentDetailSalary               = [dic stringForKey:@"salary"];
        self.schoolRecruitmentDetailCompanyName          = [dic stringForKey:@"company_name"];
        self.schoolRecruitmentDetailWorksArea            = [dic stringForKey:@"worksarea"];
        self.schoolRecruitmentDetailnumber               = [dic stringForKey:@"number"];
        self.schoolRecruitmentDetailEducation            = [dic stringForKey:@"education"];
        self.schoolRecruitmentDetailSex                  = [dic stringForKey:@"sex"];
        self.schoolRecruitmentDetailWorkinglife          = [dic stringForKey:@"workinglife"];
        self.schoolRecruitmentDetailJobDescription       = [dic stringForKey:@"description"];
        self.schoolRecruitmentDetailOfficer              = [dic stringForKey:@"officer"];
        self.schoolRecruitmentDetailTelphone             = [dic stringForKey:@"telphone"];
        self.schoolRecruitmentDetailBusinesslicense      = [dic stringForKey:@"businesslicense"];
        self.schoolRecruitmentDetailIndustry             = [dic stringForKey:@"industry"];
        self.schoolRecruitmentDetailScale                = [dic stringForKey:@"scale"];
        self.schoolRecruitmentDetailCompanyProperty      = [dic stringForKey:@"property"];
        self.schoolRecruitmentDetailCompanyAddress       = [dic stringForKey:@"address"];
        self.schoolRecruitmentDetailCompanyIntroduction  = [dic stringForKey:@"introduction"];
        self.schoolRecruitmentDetailCompanyId            = [dic stringForKey:@"company_id"];
    }
    return self;
    
}

@end
