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
#define baseBackgroundUrl @"http://123.56.27.124"

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
#endif /* NetworkConfigue_h */
