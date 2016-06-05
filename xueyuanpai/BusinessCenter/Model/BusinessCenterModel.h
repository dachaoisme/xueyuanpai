//
//  BusinessCenterModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessCenterModel : NSObject

@end


#pragma mark - 创业新闻model
@interface BusinessCenterNewsModel : NSObject
/*
 {
 "id":2, //序号
 "title":"dsda", //标题
 "brief":"121" //摘要
 ,"thumbUrl":"\/backend\/web\/uploads\/20160522\/14639220512881.jpg",//缩略图
 "author":"\u989d\u800c\u975e", //作者
 "content":"1\u7684\u65b9\u6cd5 dsdadsadada, //内容
 "create_at":"2016-05-08 08:32:19" //创建时间
 }
 */
 ///用户序号
@property(nonatomic,strong)NSString *businessCenterNewsId;
///标题
@property(nonatomic,strong)NSString *businessCenterNewsTitle;
///摘要
@property(nonatomic,strong)NSString *businessCenterNewsBrief;
///缩略图
@property(nonatomic,strong)NSString *businessCenterNewsImage;
///作者
@property(nonatomic,strong)NSString *businessCenterNewsAuthor;
///内容
@property(nonatomic,strong)NSString *businessCenterNewsContent;
///创建时间
@property(nonatomic,strong)NSString *businessCenterNewsCreateTime;

-(id)initWithDic:(NSDictionary *)dic;
@end
#pragma mark - 创业讲堂model
@interface BusinessCenterSchoolRoomModel : NSObject
/*
 "id":2, //序号
 "title":"dsda", //标题
 "brief":"121", //摘要
 "thumbUrl":"\/backend\/web\/uploads\/20160522\/14639220512881.jpg",//缩略图
 "author":"\u989d\u800c\u975e", //作者
 "content":"1\u7684\u65b9\u6cd5 dsdadsadada, //内容
 "applicants":2, //报名人数
 "create_at":"2016-05-08 08:32:19" //创建时间
 }
 */
///用户序号
@property(nonatomic,strong)NSString *businessCenterSchoolRoomId;
///标题
@property(nonatomic,strong)NSString *businessCenterSchoolRoomTitle;
///摘要
@property(nonatomic,strong)NSString *businessCenterSchoolRoomBrief;
///缩略图
@property(nonatomic,strong)NSString *businessCenterSchoolRoomImage;
///作者
@property(nonatomic,strong)NSString *businessCenterSchoolRoomAuthor;
///内容
@property(nonatomic,strong)NSString *businessCenterSchoolRoomContent;
///报名人数
@property(nonatomic,strong)NSString *businessCenterSchoolRoomPeopleNum;
///创建时间
@property(nonatomic,strong)NSString *businessCenterSchoolRoomCreateTime;

-(id)initWithDic:(NSDictionary *)dic;
@end
#pragma mark - 创业讲堂详情model
@interface BusinessCenterSchoolRoomDetailModel : NSObject
/*
 "id":1,
 "title":" \u662f\u662f\u662f",//标题
 "author":"s",   //作者
 "time":"s",     //时间
 "place":"s",    //地点
 "content":"s111sss dss",//内容
 "applicants":1, //已申请人数
 "isregistered":0,//是否已报名  1已报名 0 未报名
 "create_at":"0000-00-00 00:00:00"
 */
///用户序号
@property(nonatomic,strong)NSString *businessCenterSchoolRoomDetailId;
///标题
@property(nonatomic,strong)NSString *businessCenterSchoolRoomDetailTitle;
///作者
@property(nonatomic,strong)NSString *businessCenterSchoolRoomDetailAuthor;
///时间
@property(nonatomic,strong)NSString *businessCenterSchoolRoomDetailTime;
///地点
@property(nonatomic,strong)NSString *businessCenterSchoolRoomDetailPlace;
///内容
@property(nonatomic,strong)NSString *businessCenterSchoolRoomDetailContent;
///报名人数
@property(nonatomic,strong)NSString *businessCenterSchoolRoomDetailPeopleNum;
///是否已报名
@property(nonatomic,strong)NSString *businessCenterSchoolRoomDetailIsRegistered;
///创建时间
@property(nonatomic,strong)NSString *businessCenterSchoolRoomDetailCreateTime;

-(id)initWithDic:(NSDictionary *)dic;
@end

#pragma mark - 创业大赛model
@interface BusinessCenterCompetitionModel : NSObject
/*
 "id":2, //序号
 "title":"dsda", //标题
 "brief":"121" //摘要
 ,"thumbUrl":"\/backend\/web\/uploads\/20160522\/14639220512881.jpg",//缩略图
 "author":"\u989d\u800c\u975e", //作者
 "content":"1\u7684\u65b9\u6cd5 dsdadsadada, //内容
 "create_at":"2016-05-08 08:32:19" //创建时间
 */
///用户序号
@property(nonatomic,strong)NSString *businessCenterCompetitionId;
///标题
@property(nonatomic,strong)NSString *businessCenterCompetitionTitle;
///摘要
@property(nonatomic,strong)NSString *businessCenterCompetitionBrief;
///缩略图
@property(nonatomic,strong)NSString *businessCenterCompetitionImage;
///作者
@property(nonatomic,strong)NSString *businessCenterCompetitionAuthor;
///内容
@property(nonatomic,strong)NSString *businessCenterCompetitionContent;
///创建时间
@property(nonatomic,strong)NSString *businessCenterCompetitionCreateTime;

-(id)initWithDic:(NSDictionary *)dic;
@end

#pragma mark - 创业导师model
@interface BusinessCenterTutorModel : NSObject
/*
 "id": 1,
 "username": "王强",
 "icon": "",
 "job": "fsa踩踩踩从",
 "begoodat": "sfdaf当当当",
 "create_at": "2016-05-08 07:20:05"
 */
///用户序号
@property(nonatomic,strong)NSString *businessCenterTutorId;
///用户名
@property(nonatomic,strong)NSString *businessCenterTutorUserName;
///用户图片
@property(nonatomic,strong)NSString *businessCenterTutorImage;
///工作
@property(nonatomic,strong)NSString *businessCenterTutorJob;
///擅长
@property(nonatomic,strong)NSString *businessCenterTutorGoodAt;
///创建时间
@property(nonatomic,strong)NSString *businessCenterTutorCreateTime;

-(id)initWithDic:(NSDictionary *)dic;
@end

#pragma mark - 创业导师详情model
@interface BusinessCenterTutorDetailModel : NSObject
/*
 "id": 1,
 "user_id": 3,
 "icon": "",
 "realname": "adsfa",
 "sex": 1,
 "birth": "1",
 "company": "",
 "job": "",
 "telphone": "",
 "address": "1",
 "email": "",
 "skillful": "",
 "tutorbackground": "",
 "experience": "地方撒发生",
 "message": "请问请问下",
 "cnt": 0,
 "create_at": "2016-05-08 07:20:05"
 */
///序号
@property(nonatomic,strong)NSString *businessCenterTutorDetailId;
///用户id
@property(nonatomic,strong)NSString *businessCenterTutorDetailUserId;
///缩略图
@property(nonatomic,strong)NSString *businessCenterTutorDetailImage;
///真实姓名
@property(nonatomic,strong)NSString *businessCenterTutorDetailRealName;
///性别
@property(nonatomic,strong)NSString *businessCenterTutorDetailSex;
///出生日期
@property(nonatomic,strong)NSString *businessCenterTutorDetailBirth;
///公司
@property(nonatomic,strong)NSString *businessCenterTutorDetailCompany;
///工作
@property(nonatomic,strong)NSString *businessCenterTutorDetailJob;
///电话
@property(nonatomic,strong)NSString *businessCenterTutorDetailTelephone;
///地址
@property(nonatomic,strong)NSString *businessCenterTutorDetailAdress;
///邮箱
@property(nonatomic,strong)NSString *businessCenterTutorDetailEmail;
///技能
@property(nonatomic,strong)NSString *businessCenterTutorDetailSkillFul;
///导师背景
@property(nonatomic,strong)NSString *businessCenterTutorDetailTutorBackground;
///经验
@property(nonatomic,strong)NSString *businessCenterTutorDetailExperience;
///
@property(nonatomic,strong)NSString *businessCenterTutorDetailMessage;
///
@property(nonatomic,strong)NSString *businessCenterTutorDetailCnt;
///创建时间
@property(nonatomic,strong)NSString *businessCenterTutorDetailCreateTime;

-(id)initWithDic:(NSDictionary *)dic;
@end

#pragma mark - 创业项目分类model
@interface BusinessCenterProgectCategoryModel : NSObject
/*
 "id": "10",
 "name": "农业",
 "ord": "1"
 */
///用户序号
@property(nonatomic,strong)NSString *BusinessCenterProgectId;
///名字
@property(nonatomic,strong)NSString *BusinessCenterProgectName;
///
@property(nonatomic,strong)NSString *BusinessCenterProgectOid;

-(id)initWithDic:(NSDictionary *)dic;
@end

#pragma mark - 创业项目model
@interface BusinessCenterProgectModel : NSObject
/*
 "id": 1,
 "title": "dwe ",
 "thumbUrl": "/backend/web/uploads/20160523/14640415244470.jpg",
 "brief": "大",
 "create_at": "0000-00-00 00:00:00"
 */
///用户序号
@property(nonatomic,strong)NSString *businessCenterProgectId;
///标题
@property(nonatomic,strong)NSString *businessCenterProgectTitle;
///摘要
@property(nonatomic,strong)NSString *businessCenterProgectImage;
///缩略图
@property(nonatomic,strong)NSString *businessCenterProgectBrief;
///作者
@property(nonatomic,strong)NSString *businessCenterProgectCreateTime;

-(id)initWithDic:(NSDictionary *)dic;
@end

#pragma mark - 创业项目详情,发布者信息model
@interface BusinessCenterProgectDetailUserModel : NSObject
/*

 "user": { //发布者信息
 "icon": "", //头像
 "nickname": "任志强", //昵称
 "realname": "11", //真实姓名
 "sex": 1,           //性别
 "college": "北京大学" //学校
 },
 
 */
///头像
@property(nonatomic,strong)NSString *businessCenterProgectDetailUserIcon;
///昵称
@property(nonatomic,strong)NSString *businessCenterProgectDetailUserNickName;
///真实姓名
@property(nonatomic,strong)NSString *businessCenterProgectDetailUserRealName;
///性别
@property(nonatomic,strong)NSString *businessCenterProgectDetailUserSex;
///大学
@property(nonatomic,strong)NSString *businessCenterProgectDetailCollege;

-(id)initWithDic:(NSDictionary *)dic;
@end

#pragma mark - 创业项目详情,负责人信息model
@interface BusinessCenterProgectDetailChiefModel : NSObject
/*
 
 "chief": {//负责人信息
 "master_name": "", //负责人姓名
 "telphone": "", //联系电话
 "college": "0",//学校
 "major": "", //专业
 "education": "",//学历
 "graduationtime": ""//毕业时间
 },
 */
///负责人姓名
@property(nonatomic,strong)NSString *businessCenterProgectDetailChiefName;
///负责人联系电话
@property(nonatomic,strong)NSString *businessCenterProgectDetailChiefTelephone;
///负责人学校
@property(nonatomic,strong)NSString *businessCenterProgectDetailChiefCollege;
///负责人专业
@property(nonatomic,strong)NSString *businessCenterProgectDetailChiefMajor;
///负责人学历
@property(nonatomic,strong)NSString *businessCenterProgectDetailChiefEducation;
///负责人毕业时间
@property(nonatomic,strong)NSString *businessCenterProgectDetailChiefGraduationTime;

-(id)initWithDic:(NSDictionary *)dic;
@end

#pragma mark - 创业项目详情,导师信息model
@interface BusinessCenterProgectDetailTutorModel : NSObject
/*
 
 "tutor": { //导师信息
 "icon": "",//导师头像
 "nickname": "任志强", //导师昵称
 "realname": "11", //导师真实姓名
 "company": "11111", //工作单位
 "job": "11" //职位
 },
 */
///负责人姓名
@property(nonatomic,strong)NSString *businessCenterProgectDetailTutorImage;
///负责人联系电话
@property(nonatomic,strong)NSString *businessCenterProgectDetailTutorNickName;
///负责人学校
@property(nonatomic,strong)NSString *businessCenterProgectDetailTutorRealName;
///负责人专业
@property(nonatomic,strong)NSString *businessCenterProgectDetailTutorCompany;
///负责人学历
@property(nonatomic,strong)NSString *businessCenterProgectDetailTutorJob;

-(id)initWithDic:(NSDictionary *)dic;
@end
#pragma mark - 创业项目详情model
@interface BusinessCenterProgectDetailModel : NSObject
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
///用户序号
@property(nonatomic,strong)NSString *businessCenterProgectDetailId;
///拥有者id
@property(nonatomic,strong)NSString *businessCenterProgectDetailOwnId;
///发布者model
@property(nonatomic,strong)BusinessCenterProgectDetailUserModel *businessCenterProgectDetailUserModel;
///负责人model
@property(nonatomic,strong)BusinessCenterProgectDetailChiefModel *businessCenterProgectDetailChiefModel;
///项目标题
@property(nonatomic,strong)NSString *businessCenterProgectDetailTitle;
///时间
@property(nonatomic,strong)NSString *businessCenterProgectDetailDate;
///项目预算
@property(nonatomic,strong)NSString *businessCenterProgectDetailBudge;
///项目领域
@property(nonatomic,strong)NSString *businessCenterProgectDetailField;
///项目简介
@property(nonatomic,strong)NSString *businessCenterProgectDetailDescription;
///项目成员
@property(nonatomic,strong)NSString *businessCenterProgectDetailMember;
///项目背景
@property(nonatomic,strong)NSString *businessCenterProgectDetailBackground;
///实施计划
@property(nonatomic,strong)NSString *businessCenterProgectDetailPlan;
///标签
@property(nonatomic,strong)NSString *businessCenterProgectDetailTags;
///是否已申领
@property(nonatomic,strong)NSString *businessCenterProgectDetailIsApplyed;
///负责人model
@property(nonatomic,strong)BusinessCenterProgectDetailTutorModel *businessCenterProgectDetailTutorModel;
///创建时间
@property(nonatomic,strong)NSString *businessCenterProgectDetailCreatedTime;

-(id)initWithDic:(NSDictionary *)dic;
@end

