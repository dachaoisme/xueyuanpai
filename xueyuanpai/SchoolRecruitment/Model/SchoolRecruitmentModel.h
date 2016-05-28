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

@interface SchoolRecruitmentDetailModel : NSObject
///职位名称
@property(nonatomic,strong)NSString *schoolRecruitmentDetailTitle;
///更新时间
@property(nonatomic,strong)NSString *schoolRecruitmentDetailUpdateTime;
///月薪
@property(nonatomic,strong)NSString *schoolRecruitmentDetailSalary;
///公司名称
@property(nonatomic,strong)NSString *schoolRecruitmentDetailCompanyName;
///工作区域
@property(nonatomic,strong)NSString *schoolRecruitmentDetailWorksArea;
///招聘人数
@property(nonatomic,strong)NSString *schoolRecruitmentDetailnumber;
///学历要求
@property(nonatomic,strong)NSString *schoolRecruitmentDetailEducation;
///性别要求
@property(nonatomic,strong)NSString *schoolRecruitmentDetailSex;
///工作年限
@property(nonatomic,strong)NSString *schoolRecruitmentDetailWorkinglife;
///职位描述
@property(nonatomic,strong)NSString *schoolRecruitmentDetailJobDescription;
///联系人
@property(nonatomic,strong)NSString *schoolRecruitmentDetailOfficer;
///联系电话
@property(nonatomic,strong)NSString *schoolRecruitmentDetailTelphone;
///公司营业执照
@property(nonatomic,strong)NSString *schoolRecruitmentDetailBusinesslicense;
///公司行业
@property(nonatomic,strong)NSString *schoolRecruitmentDetailIndustry;
///公司规模
@property(nonatomic,strong)NSString *schoolRecruitmentDetailScale;
///公司性质
@property(nonatomic,strong)NSString *schoolRecruitmentDetailCompanyProperty;
///公司地址
@property(nonatomic,strong)NSString *schoolRecruitmentDetailCompanyAddress;
///公司介绍
@property(nonatomic,strong)NSString *schoolRecruitmentDetailCompanyIntroduction;
///公司序号
@property(nonatomic,strong)NSString *schoolRecruitmentDetailCompanyId;

- (id)initWithDic:(NSDictionary *)dic;
@end

