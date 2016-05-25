//
//  NetworkConfigue.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#ifndef NetworkConfigue_h
#define NetworkConfigue_h

#pragma mark - 服务器地址相关
///api的地址
#define baseApiUrl        @"http://123.56.27.124/api/web/"
///后台管理系统图片的地址
#define baseBackgroundUrlType1 @"http://123.56.27.124"
#define baseBackgroundUrlType2 @"http://123.56.27.124/backend/web/"

#pragma mark - 首页相关
///轮播图
#define METHOD_OF_BANNER    @"v1/focus/index?"
///首页栏目
#define METHOD_OF_COLUMNS   @"v1/columns/index?"
///首页大派送接口
#define METHOD_OF_MALL      @"v1/mall/index?"

#pragma mark - 用户相关
///发送验证码
#define METHOD_OF_SEND_MESSAGE           @"v1/user/sendmessage?"
///登录
#define METHOD_OF_LOGIN                  @"v1/user/signin?"
///注册
#define METHOD_OF_REGISTER               @"v1/user/signup?"
///校验验证码和手机号--->修改密码
#define METHOD_OF_CHECKING_MESSAGE       @"v1/user/validatecaptcha?"
///修改密码
#define METHOD_OF_UPDATE_PASSWORD        @"v1/user/v1/user/updatepasswd?"
///更新个人资料
#define METHOD_OF_UPDATE_STUDENT_INFO    @"v1/user/updatestudentinfo?"
///更新导师资料
#define METHOD_OF_UPDATE_TEACHER_INFO    @"v1/user/updateteacherinfo?"
///根据关键字查询学校
#define METHOD_OF_COLLEGE_SEARCH         @"v1/college/search?"
///用户头像上传
#define METHOD_OF_UPLOAD                 @"v1/user/upload?"

///大学社团：热门活动
#define METHOD_OF_UNIVERSITY_ACTIVITY    @"v1/association/hot?"
///大学社团：明星社团
#define METHOD_OF_UNIVERSITY_START_COMMUNITY    @"v1/association/star?"
///大学社团：社团纳新
#define METHOD_OF_UNIVERSITY_COMMUNITY_NEW      @"v1/association/nexeon?"
///大派送-立即兑换礼品
#define METHOD_EXCHANGE_GIFT                    @"v1/exchange/add?"

///时间银行:条件筛选接口
#define METHOD_TIME_BANK_CONDITIONS           @"v1/timebank/conditions?"
///时间银行:支付方式接口
#define METHOD_TIME_BANK_PAYWAY               @"v1/timebank/payway?"
///时间银行:列表接口
#define METHOD_TIME_BANK_LIST                 @"v1/timebank/list?"
///时间银行:添加或者发布时间银行接口
#define METHOD_TIME_BANK_RELEASE              @"v1/timebank/create?"
///时间银行:评论列表接口
#define METHOD_TIME_BANK_COMMENTS             @"v1/timebank/comments?"
///时间银行:添加评论接口
#define METHOD_TIME_BANK_ADD_COMMENTS         @"v1/timebank/addcomment?"
///时间银行:上传用户头像
#define METHOD_TIME_BANK_ADD_UPLOAD           @"v1/timebank/upload/"
///时间银行:申请赴约接口
#define METHOD_TIME_BANK_APPLY_APPOINTMENT    @"v1/timebank/apply/"
///时间银行:申领通过接口
#define METHOD_TIME_BANK_APPLY_PASS           @"v1/timebank/verified/"
///时间银行:详情接口
#define METHOD_TIME_BANK_APPLY_DETAIL         @"v1/timebank/detail"
///时间银行:增加浏览数接口
#define METHOD_TIME_BANK_ADD_SCAN             @"v1/timebank/viewsadd"

#endif /* NetworkConfigue_h */
