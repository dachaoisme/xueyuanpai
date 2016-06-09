//
//  BusinessCenterModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessCenterModel.h"

@implementation BusinessCenterModel

@end

@implementation BusinessCenterNewsModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.businessCenterNewsId               = [dic stringForKey:@"id"];
        self.businessCenterNewsTitle            = [dic stringForKey:@"title"];
        self.businessCenterNewsBrief            = [dic stringForKey:@"brief"];
        self.businessCenterNewsImage            = [dic stringForKey:@"thumbUrl"];
        self.businessCenterNewsAuthor           = [dic stringForKey:@"author"];
        self.businessCenterNewsContent          = [dic stringForKey:@"content"];
        self.businessCenterNewsCreateTime       = [dic stringForKey:@"create_at"];
        
    }
    return self;
}

@end

@implementation BusinessCenterSchoolRoomModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.businessCenterSchoolRoomId               = [dic stringForKey:@"id"];
        self.businessCenterSchoolRoomTitle            = [dic stringForKey:@"title"];
        self.businessCenterSchoolRoomBrief            = [dic stringForKey:@"brief"];
        self.businessCenterSchoolRoomImage            = [dic stringForKey:@"thumbUrl"];
        self.businessCenterSchoolRoomAuthor           = [dic stringForKey:@"author"];
        self.businessCenterSchoolRoomContent          = [dic stringForKey:@"content"];
        self.businessCenterSchoolRoomPeopleNum        = [dic stringForKey:@"applicants"];
        self.businessCenterSchoolRoomCreateTime       = [dic stringForKey:@"create_at"];
        
    }
    return self;
}

@end

@implementation BusinessCenterSchoolRoomDetailModel
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.businessCenterSchoolRoomDetailId               = [dic stringForKey:@"id"];
        self.businessCenterSchoolRoomDetailTitle            = [dic stringForKey:@"title"];
        self.businessCenterSchoolRoomDetailAuthor           = [dic stringForKey:@"author"];
        self.businessCenterSchoolRoomDetailTime            = [dic stringForKey:@"time"];
        self.businessCenterSchoolRoomDetailPlace            = [dic stringForKey:@"place"];
        self.businessCenterSchoolRoomDetailContent          = [dic stringForKey:@"content"];
        self.businessCenterSchoolRoomDetailPeopleNum        = [dic stringForKey:@"applicants"];
        self.businessCenterSchoolRoomDetailIsRegistered       = [dic stringForKey:@"isregistered"];
        self.businessCenterSchoolRoomDetailCreateTime       = [dic stringForKey:@"create_at"];
        
    }
    return self;
}
@end

@implementation BusinessCenterCompetitionModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.businessCenterCompetitionId               = [dic stringForKey:@"id"];
        self.businessCenterCompetitionTitle            = [dic stringForKey:@"title"];
        self.businessCenterCompetitionBrief            = [dic stringForKey:@"brief"];
        self.businessCenterCompetitionImage            = [dic stringForKey:@"thumbUrl"];
        self.businessCenterCompetitionAuthor           = [dic stringForKey:@"author"];
        self.businessCenterCompetitionContent          = [dic stringForKey:@"content"];
        self.businessCenterCompetitionCreateTime       = [dic stringForKey:@"create_at"];
        
    }
    return self;
}

@end

@implementation BusinessCenterTutorModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.businessCenterTutorId                  = [dic stringForKey:@"id"];
        self.businessCenterTutorUserName            = [dic stringForKey:@"username"];
        self.businessCenterTutorImage               = [dic stringForKey:@"icon"];
        self.businessCenterTutorJob                 = [dic stringForKey:@"job"];
        self.businessCenterTutorGoodAt              = [dic stringForKey:@"begoodat"];
        self.businessCenterTutorCreateTime          = [dic stringForKey:@"create_at"];
        
    }
    return self;
}

@end

@implementation BusinessCenterTutorDetailModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.businessCenterTutorDetailId                   = [dic stringForKey:@"id"];
        self.businessCenterTutorDetailUserId               = [dic stringForKey:@"user_id"];
        self.businessCenterTutorDetailImage                = [dic stringForKey:@"icon"];
        self.businessCenterTutorDetailRealName             = [dic stringForKey:@"realname"];
        self.businessCenterTutorDetailSex                  = [dic stringForKey:@"sex"];
        self.businessCenterTutorDetailBirth                = [dic stringForKey:@"birth"];
        self.businessCenterTutorDetailCompany              = [dic stringForKey:@"company"];
        self.businessCenterTutorDetailJob                  = [dic stringForKey:@"job"];
        self.businessCenterTutorDetailTelephone            = [dic stringForKey:@"telphone"];
        self.businessCenterTutorDetailAdress               = [dic stringForKey:@"address"];
        self.businessCenterTutorDetailEmail                = [dic stringForKey:@"email"];
        self.businessCenterTutorDetailSkillFul             = [dic stringForKey:@"skillful"];
        self.businessCenterTutorDetailTutorBackground      = [dic stringForKey:@"tutorbackground"];
        self.businessCenterTutorDetailExperience           = [dic stringForKey:@"experience"];
        self.businessCenterTutorDetailMessage              = [dic stringForKey:@"message"];
        self.businessCenterTutorDetailCnt                  = [dic stringForKey:@"cnt"];
        self.businessCenterTutorDetailCreateTime           = [dic stringForKey:@"create_at"];
        
    }
    return self;
}

@end

@implementation BusinessCenterProgectCategoryModel : NSObject
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.BusinessCenterProgectId                  = [dic stringForKey:@"id"];
        self.BusinessCenterProgectName                = [dic stringForKey:@"name"];
        self.BusinessCenterProgectOid                 = [dic stringForKey:@"ord"];
        
    }
    return self;
}
@end

@implementation BusinessCenterProgectModel

-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.businessCenterProgectId               = [dic stringForKey:@"id"];
        self.businessCenterProgectTitle            = [dic stringForKey:@"title"];
        self.businessCenterProgectImage            = [dic stringForKey:@"thumbUrl"];
        self.businessCenterProgectBrief            = [dic stringForKey:@"brief"];
        self.businessCenterProgectCreateTime       = [dic stringForKey:@"create_at"];
    }
    return self;
}

@end


@implementation BusinessCenterProgectDetailUserModel

-(id)initWithDic:(NSDictionary *)dic
{

    self = [super init];
    if (self) {
        self.businessCenterProgectDetailUserIcon                = [dic stringForKey:@"icon"];
        self.businessCenterProgectDetailUserNickName            = [dic stringForKey:@"nickname"];
        self.businessCenterProgectDetailUserRealName            = [dic stringForKey:@"realname"];
        self.businessCenterProgectDetailUserSex                 = [dic stringForKey:@"sex"];
        self.businessCenterProgectDetailCollege                 = [dic stringForKey:@"college"];
    }
    return self;
}

@end

@implementation BusinessCenterProgectDetailChiefModel

-(id)initWithDic:(NSDictionary *)dic
{

    self = [super init];
    if (self) {
        self.businessCenterProgectDetailChiefName                 = [dic stringForKey:@"master_name"];
        self.businessCenterProgectDetailChiefTelephone            = [dic stringForKey:@"telphone"];
        self.businessCenterProgectDetailChiefCollege              = [dic stringForKey:@"college"];
        self.businessCenterProgectDetailChiefMajor                = [dic stringForKey:@"major"];
        self.businessCenterProgectDetailChiefEducation            = [dic stringForKey:@"education"];
        self.businessCenterProgectDetailChiefGraduationTime       = [dic stringForKey:@"graduationtime"];
    }
    return self;
}

@end

@implementation BusinessCenterProgectDetailTutorModel

-(id)initWithDic:(NSDictionary *)dic
{

    self = [super init];
    if (self) {
        self.businessCenterProgectDetailTutorImage               = [dic stringForKey:@"icon"];
        self.businessCenterProgectDetailTutorNickName            = [dic stringForKey:@"nickname"];
        self.businessCenterProgectDetailTutorRealName            = [dic stringForKey:@"realname"];
        self.businessCenterProgectDetailTutorCompany             = [dic stringForKey:@"company"];
        self.businessCenterProgectDetailTutorJob                 = [dic stringForKey:@"job"];
    }
    return self;
}

@end

@implementation BusinessCenterProgectDetailModel

-(id)initWithDic:(NSDictionary *)dic
{
    /*
     "id": 1,
     "owner_id": 2,
     "user": { //发布者信息
     "icon": "", //头像
     "nickname": "任志强", //昵称
     "realname": "11", //真实姓名
     "sex": 1,           //性别
     "college": "北京大学" //学校
     },
     "chief": {//负责人信息
     "master_name": "", //负责人姓名
     "telphone": "", //联系电话
     "college": "0",//学校
     "major": "", //专业
     "education": "",//学历
     "graduationtime": ""//毕业时间
     },
     "title": "dwe ",//项目标题
     "date": "1970/01/01",
     "budget": "1",//项目预算
     "field": "1", //项目领域
     "description": "1", //项目简介
     "member": "1", //项目成员
     "background": "1", //项目背景
     "plan": "1",//实施计划
     "tags": "1", //标签
     "isapplyed": 1,//是否已申领 1已申领 0 未申领
     "tutor": { //导师信息
     "icon": "",//导师头像
     "nickname": "任志强", //导师昵称
     "realname": "11", //导师真实姓名
     "company": "11111", //工作单位
     "job": "11" //职位
     },
     "create_at": "0000-00-00 00:00:00"
     }
     */
    
    
    self = [super init];
    if (self) {
        self.businessCenterProgectDetailId               = [dic stringForKey:@"id"];
        self.businessCenterProgectDetailOwnId            = [dic stringForKey:@"owner_id"];
        self.businessCenterProgectDetailUserModel        = [[BusinessCenterProgectDetailUserModel alloc]initWithDic:[dic objectForKey:@"user"]];
        self.businessCenterProgectDetailChiefModel        = [[BusinessCenterProgectDetailChiefModel alloc]initWithDic:[dic objectForKey:@"chief"]];
        self.businessCenterProgectDetailTitle            = [dic stringForKey:@"title"];
        self.businessCenterProgectDetailDate             = [dic stringForKey:@"date"];
        self.businessCenterProgectDetailBudge            = [dic stringForKey:@"budget"];
        self.businessCenterProgectDetailField            = [dic stringForKey:@"field"];
        self.businessCenterProgectDetailDescription      = [dic stringForKey:@"description"];
        self.businessCenterProgectDetailMember           = [dic stringForKey:@"member"];
        self.businessCenterProgectDetailBackground       = [dic stringForKey:@"background"];
        self.businessCenterProgectDetailPlan             = [dic stringForKey:@"plan"];
        self.businessCenterProgectDetailTags             = [dic stringForKey:@"tags"];
        self.businessCenterProgectDetailIsApplyed        = [dic stringForKey:@"isapplyed"];
        self.businessCenterProgectDetailTutorModel        = [[BusinessCenterProgectDetailTutorModel alloc]initWithDic:[dic objectForKey:@"tutor"]];
        self.businessCenterProgectDetailCreatedTime      = [dic stringForKey:@"create_at"];
    }
    return self;
}

@end

#pragma mark - 发布创业项目model
@implementation BusinessCenterPublicProgectModel
/*
 owner_id         int        必需  发布者序号
 title            string     必需  项目名称
 thumbUrl         string     必需 项目封面图  图片上传请调用跳蚤市场上传照片接口
 budget           string     必需 项目预算
 field            string     必需 项目领域
 description      string     必需 项目简介
 member           string     必需 项目成员介绍
 background       string     必需 项目背景
 plan             string     必需 项目实施计划
 master_name      string     必需 负责人姓名
 idcard          string     必需  负责人身份证号
 telphone        string     必需  联系电话
 college         string     必需  学校
 major           string     必需 专业
 education       string     必需 学历
 graduationtime  string     必需 毕业时间
 */
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.businessCenterPublicProgectOwnId              = @"";
        self.businessCenterPublicProgectTitle              = @"";
        self.businessCenterPublicProgectImage              = @"";
        self.businessCenterPublicProgectDetailBudge        = @"";
        self.businessCenterPublicProgectDetailField        = @"";
        self.businessCenterPublicProgectDetailFieldId      = @"";
        self.businessCenterPublicProgectDetailDescription  = @"";
        self.businessCenterPublicProgectDetailDescription  = @"";
        self.businessCenterPublicProgectDetailMember       = @"";
        self.businessCenterPublicProgectDetailBackground   = @"";
        self.businessCenterPublicProgectDetailPlan         = @"";
        self.businessCenterPublicProgectRealName           = @"";
        self.businessCenterPublicProgectIdentityCard       = @"";
        self.businessCenterPublicProgectTelephone          = @"";
        self.businessCenterPublicProgectCollege            = @"";
        self.businessCenterPublicProgectCollegeId          = @"";
        self.businessCenterPublicProgectMajor              = @"";
        self.businessCenterPublicProgectJob                = @"";
        self.businessCenterPublicProgectGraduationtime     = @"";
        
    }
    return self;
}



@end
