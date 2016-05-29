//
//  EnumDefine.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#ifndef EnumDefine_h
#define EnumDefine_h

typedef NS_ENUM(NSInteger, ReturnCode){
    Success                   = 10000,
    ParamMistake              = 10001,
    UserNameOrPasswordMistake = 10002,
    ServerAbnormal            = 10003,
    TokenInvalid              = 10004,
    OldPassWordMistake        = 10005,
    UpdateMessageMistake      = 10006,
    UpLoadFileIsEmpty         = 10007,
    SignMistake               = 10008
};

typedef NS_ENUM(NSInteger, BannerLinkToType){
    BannerLinkToWebView              = 0, //0 url地址
    BannerLinkToNewStudentStrategy   = 1, //1 大学生新生攻略
    BannerLinkToPoineeringClassroom  = 2, //2 创业课程
    BannerLinkToPoineeringTrain      = 3, //3 创业实训课程
    
};

//跳转到
typedef NS_ENUM(NSInteger, ResponseCode){
    
    ResponseCodeSuccess  = 1,
    ResponseCodeFail     = 0,
    
};


typedef NS_ENUM(NSInteger, BannerType){
    
    BannerTypeOfIndex        = 1,
    BannerTypeOfIntegral     = 2,
    BannerTypeOfSchoolInvite = 3,
    
};

typedef NS_ENUM(NSInteger, RegisterRoleType){
    
    RegisterRoleOfStudent      = 1,
    RegisterRoleTypeTeacher    = 2,
    
};
///时间银行中：性别
typedef NS_ENUM(NSInteger, SexType){
    
    SexOfManType       =1,
    SexOfWomanType     =2,
    SexOfSecretType    =3
    
};

///时间银行：申领状态  0未申请 1 已申请 2 已通过 3过期 4完成
typedef NS_ENUM(NSInteger, TimeBankState){
    
    TimeBankStateUnApply          =0,
    TimeBankStateAlreadyApply     =1,
    TimeBankStateAlreadyPass      =2,
    TimeBankStateAlreadyOverdue   =3,
    TimeBankStateAlreadyComplete  =4
};

///时间银行：发布需求的时候，需要使用枚举值来标记tag值
typedef NS_ENUM(NSInteger, TimeBankSubmitTag){
    ///标题
    TimeBankSubmitTitleTag       =0,
    ///类型。娱乐、唱歌等
    TimeBankSubmitTypeTag          ,
    ///时间
    TimeBankSubmitTimeTag          ,
    ///地址
    TimeBankSubmitAdressTag        ,
    ///人数
    TimeBankSubmitPersonNumTag     ,
    ///支付方式
    TimeBankSubmitPayWayTag        ,
    ///描述详情
    TimeBankSubmitDescriptionTag   ,
};
///校园招聘
typedef NS_ENUM(NSInteger, SchoolRecruitmentType){
    ///就业招聘
    SchoolRecruitmentTypeJiuYe           =0,
    ///实习招聘
    SchoolRecruitmentTypeShiXi             ,
    ///兼职招聘
    SchoolRecruitmentTypeJianZhi           ,
    ///查看公司其他职位信息
    SchoolRecruitmentTypeCompanyPosition   ,
};
#endif /* EnumDefine_h */
