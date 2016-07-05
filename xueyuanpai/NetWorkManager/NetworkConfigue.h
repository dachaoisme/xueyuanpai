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
#define METHOD_OF_UPDATE_PASSWORD        @"v1/user/updatepasswd?"
///更新个人资料
#define METHOD_OF_UPDATE_STUDENT_INFO    @"v1/user/updatestudentinfo?"
///更新导师资料
#define METHOD_OF_UPDATE_TEACHER_INFO    @"v1/user/updateteacherinfo?"
///根据关键字查询学校
#define METHOD_OF_COLLEGE_SEARCH         @"v1/college/search?"
///用户头像上传
#define METHOD_OF_UPLOAD                 @"v1/user/upload/"

///大学社团：热门活动
#define METHOD_OF_UNIVERSITY_ACTIVITY    @"v1/association/hot?"
///大学社团：明星社团
#define METHOD_OF_UNIVERSITY_START_COMMUNITY    @"v1/association/star?"
///大学社团：社团纳新
#define METHOD_OF_UNIVERSITY_COMMUNITY_NEW      @"v1/association/nexeon?"
///大派送-立即兑换礼品
#define METHOD_EXCHANGE_GIFT                    @"v1/exchange/add?"


///校园招聘网址
#define METHOD_SCHOOL_BANNER    @"v1/recruitment/columns?"

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
#define METHOD_TIME_BANK_APPLY_APPOINTMENT    @"v1/timebank/apply?"
///时间银行:申领通过接口
#define METHOD_TIME_BANK_APPLY_PASS           @"v1/timebank/verified/"
///时间银行:详情接口
#define METHOD_TIME_BANK_APPLY_DETAIL         @"v1/timebank/detail?"
///时间银行:增加浏览数接口
#define METHOD_TIME_BANK_ADD_SCAN             @"v1/timebank/viewsadd?"

///大学招聘：校园招聘栏目接口SchoolRecruitmentViewController
#define METHOD_TIME_SCHOOL_RECRUITEMENT_COLUMNS        @"v1/recruitment/columns?"
#define METHOD_TIME_SCHOOL_RECRUITEMENT_LIST           @"v1/recruitment/list?"
#define METHOD_TIME_SCHOOL_RECRUITEMENT_Detail         @"v1/recruitment/detail?"

///跳蚤市场:跳蚤市场分类接口
#define METHOD_JOB_MARKET_CONDITION_CATEGORY           @"v1/fleamarket/category/"
///跳蚤市场:跳蚤市场列表接口
#define METHOD_JOB_MARKET_LIST                         @"v1/fleamarket/list?"
///跳蚤市场:跳蚤市场上传照片接口
#define METHOD_JOB_MARKET_IMAGEUPLOAD                  @"v1/fleamarket/imageupload/"
///跳蚤市场:添加跳蚤接口
#define METHOD_JOB_MARKET_ADD                          @"v1/fleamarket/create/?"
///跳蚤市场:跳蚤详情接口
#define METHOD_JOB_MARKET_DETAIL                       @"v1/fleamarket/detail/?"

///创业中心:创业新闻
#define METHOD_BUSINESS_CENTER_NEWS_LIST                       @"v1/news/list?"
///创业中心:创业讲堂 schoolroom
#define METHOD_BUSINESS_CENTER_SCHOOLROOM_LIST                 @"v1/forum/list?"
///创业中心:创业讲堂详情
#define METHOD_BUSINESS_CENTER_SCHOOLROOM_Detail               @"v1/forum/detail?"
///创业中心:创业讲堂报名
#define METHOD_BUSINESS_CENTER_SCHOOLROOM_APPLY                @"v1/forum/apply?"
///创业中心:创业大赛列表
#define METHOD_BUSINESS_CENTER_COMPETITION_LIST                @"v1/competition/list?"
///创业中心:创业导师列表
#define METHOD_BUSINESS_CENTER_TUTOR_LIST                      @"v1/tutor/list?"
///创业中心:创业导师详情
#define METHOD_BUSINESS_CENTER_TUTOR_DETAIL                    @"v1/tutor/detail?"
///创业中心:创业项目分类
#define METHOD_BUSINESS_CENTER_PROGECT_CATEGORY_LIST           @"v1/project/category?"
///创业中心:创业项目列表
#define METHOD_BUSINESS_CENTER_PROGECT_LIST                    @"v1/project/list?"
///创业中心:创业项目详情
#define METHOD_BUSINESS_CENTER_PROGECT_DETAIL                  @"v1/project/detail?"
///创业中心:添加创业项目
#define METHOD_BUSINESS_CENTER_PROGECT_CREATE                  @"v1/project/create?"

///个人中心:我的项目
#define METHOD_MINE_PROGECT_LIST                               @"v1/my/project?"
///个人中心:我的跳蚤市场
#define METHOD_MINE_JOB_MARKET_LIST                            @"v1/my/fleamarket?"
///个人中心:我的收藏
#define METHOD_MINE_COLLECTION_LIST                            @"v1/mark/list?"
///个人中心:我的时间银行
#define METHOD_MINE_TIME_BANK_LIST                            @"v1/my/timebank?"
///个人中心:我的积分
#define METHOD_MINE_POINTS_LIST                               @"v1/my/integral?"
///个人中心：我的钱包记录列表接
#define METHOD_MINE_WALLET_LIST                               @"v1/my/wallet?"
///个人中心：意见反馈
#define METHOD_MINE_FEED_BACK                               @"v1/feedback/add/?"

///个人中心：关于我们
#define METHOD_MINE_ABOUT_US                                @"v1/aboutus/index?"

///收藏相关-添加收藏
#define METHOD_COLLECTION_ADD                                 @"v1/mark/add?"
///收藏相关-取消收藏
#define METHOD_COLLECTION_CANCEL                              @"v1/mark/cancel?"
///收藏相关-是否已经添加收藏
#define METHOD_COLLECTION_CHECK                               @"v1/mark/check?"


#pragma mark - 快递中心
///快递中心：正在接收快递的快递员人数
#define METHOD_EXPRESS_CENTER_COUNT                               @"v1/express/working?"
///快递中心：分配快递员接口
#define METHOD_EXPRESS_CENTER_DISTRIBUTE                          @"v1/express/getcourier?"
///快递中心：发快递接口
#define METHOD_EXPRESS_CENTER_SEND_EXPRESS                        @"v1/express/send?"
///快递中心：取消发快递接口
#define METHOD_EXPRESS_CENTER_CANCEL_EXPRESS                      @"v1/express/cancel?"
///快递中心：我的发快递历史记录接口
#define METHOD_EXPRESS_CENTER_EXPRESS_HISTORY                     @"v1/express/history?"


#pragma mark - 消息
///消息：系统未读消息数目
#define SYSTEM_MESSAGE_UNREAD_COUNT                               @"v1/message/syscnt?"
///消息：系统消息设置为已读
#define SYSTEM_MESSAGE_STATUES                                    @"v1/message/setread?"
///消息：系统消息列表
#define SYSTEM_MESSAGE_LIST                                       @"v1/message/system?"
///消息：系统消息详情
#define SYSTEM_MESSAGE_Detail                                     @"v1/message/usermessagedetail?"
///消息：创业项目消息
#define SYSTEM_PROGECT_MSG_LIST                                   @"v1/message/project?"
///消息：快递通知列表以及消息记录
#define METHOD_EXPRESS_CENTER_EXPRESS_RECEIVE_LIST                @"v1/message/express?"
///消息：站内消息
#define METHOD_EXPRESS_CENTER_INBOX_INSIDE_MESSAGE_LIST           @"v1/message/all?"

///消息：删除消息
#define SYSTEM_MESSAGE_Delete                                     @"v1/message/dell?"

#endif /* NetworkConfigue_h */
