//
//  SchoolRecruitmentModel.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolRecruitmentModel : NSObject
/*
 "id":4,
 "title":"xxx",
 "company":1,
 "salary":"2",
 "day":"05-03",
 "education":"1",
 "workinglife":1
 
 */

@property(nonatomic,strong)NSString *schoolRecruitmentId;
@property(nonatomic,strong)NSString *schoolRecruitmentTitle;
@property(nonatomic,strong)NSString *schoolRecruitmentCompany;
@property(nonatomic,strong)NSString *schoolRecruitmentSalary;
@property(nonatomic,strong)NSString *schoolRecruitmentDay;
@property(nonatomic,strong)NSString *schoolRecruitmentEducation;
@property(nonatomic,strong)NSString *schoolRecruitmentWorkinglife;
- (id)initWithDic:(NSDictionary *)dic;
@end
