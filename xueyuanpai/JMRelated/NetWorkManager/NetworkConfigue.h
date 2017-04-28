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
#define baseApiUrl @"http://114.215.111.210:999/frontend/web/index.php?r="
///后台管理系统图片的地址
#define baseBackgroundUrlType1 @"http://114.215.111.210/"
#define baseBackgroundUrlType2 @"http://114.215.111.210/backend/web/"

///支付地址
#define WeiXinPayStyleUrl   @"http://114.215.111.210/api/web/v1/pay/weixin/"


/////////////////////////////////////////集梦盒子二期/////////////////////////////////////////
////////实训项目相关相关////////
///首页轮播图
#define METHOD_OF_BANNER    @"focus/index"
///获取实训项目
#define METHOD_OF_TRAIN_PROJECT    @"project/index"
///获取实训项目详情
#define METHOD_OF_TRAIN_PROJECT_DETAIL    @"project/detail"
///添加评论
#define METHOD_OF_ADD_COMMENT @"comment/create"
///获取评论列表
#define METHOD_OF_COMMENT_LIST @"comment/index"
///创业项目点赞
#define METHOD_OF_ADD_FAVOURITE @"project/like"
///创业项目是否已经点过赞
#define METHOD_OF_WHETHER_FAVOURITE @"project/isliked"
///获得岗位列表
#define METHOD_OF_JOB_LIST @"project/jobs"
///是否报名或者收藏过项目或者课程等
#define METHOD_OF_COLLECTION @"user/checkpartin"
///报名
#define METHOD_OF_SIGN_UP @"user/partin"

////////创业课程相关////////
#define METHOD_OF_BANNER_OF_INDEX    @"focus/index"
///集梦创客轮播图
#define METHOD_OF_BANNER_OFCHUANGKE    @"banner/index"
///创业课程列表
#define METHOD_OF_TRAIN_COURSE  @"course/index"
///创业课程详情
#define METHOD_OF_TRAIN_COURSE_DETAIL  @"course/detail" 
///对创业课程点赞接口 （第一次点赞 再次取消点赞）
#define METHOD_OF_TRAIN_COURSE_LIKE  @"course/like"
///检查对创业课程是否点赞过
#define METHOD_OF_TRAIN_COURSE_WHETHER_IS_LIKE  @"course/isliked"
///对创业课程收藏接口
#define METHOD_OF_TRAIN_COURSE_COLLECT  @"mark/create"
////////创业沙龙相关////////
///创业沙龙列表
#define METHOD_OF_TRAIN_SALON  @"salon/index"
///创业沙龙详情
#define METHOD_OF_TRAIN_SALON_DETAIL  @"salon/detail"
///对创业沙龙点赞接口 （第一次点赞 再次取消点赞）
#define METHOD_OF_TRAIN_SALON_LIKE  @"salon/like"
///检查对创业沙龙是否点赞过
#define METHOD_OF_TRAIN_SALON_WHETHER_IS_LIKE  @"salon/isliked"



////我的
///我的实训项目列表
#define METHOD_OF_TRAIN_PROJECT_LIST    @"user/project"
///我的创业课程相关
#define METHOD_OF_TRAIN_COURSE_LIST  @"user/course"
///我的创业沙龙相关
#define METHOD_OF_TRAIN_SALON_LIST  @"user/salon"


///登录
#define METHOD_OF_LOGIN                  @"/student/signin"
///注册
#define METHOD_OF_REGISTER               @"student/signup"
///发送验证码
#define METHOD_OF_SEND_MESSAGE           @"student/sendsms"
///根据关键字查询学校
#define METHOD_OF_COLLEGE_SEARCH         @"college/index"
///上传用户头像
#define METHOD_OF_ADD_ICON_UPLOAD           @"student/upload/"
///更新个人资料
#define METHOD_OF_UPDATE_STUDENT_INFO    @"student/updateuserinfo"
///校验验证码和手机号--->修改密码
#define METHOD_OF_CHECKING_MESSAGE       @"student/validatecaptcha"
///个人中心：意见反馈
#define METHOD_MINE_FEED_BACK             @"feedback/create"
///修改手机号绑定
#define BIND_PHONE_NUMBER                @"user/bindtel"
///修改密码
#define METHOD_OF_UPDATE_PASSWORD        @"student/setpasswd"
///个人中心：根据用户id，获取用户信息
#define METHOD_OF_USERINFO_WITH_USERID            @"student/detail"
////////快递员相关////////
///创建地址--获取地区列表
#define METHOD_OF_AREA_LIST             @"area/index"
///创建地址
#define METHOD_OF_ADD_ADRESS            @"address/create"
///地址列表
#define METHOD_OF_ADDRESS_LIST          @"address/list"
///站点
#define METHOD_OF_EXPRESS_SITE_LIST     @"expresssite/index"
///快递公司列表
#define TWICE_METHOD_OF_EXPRESS_COMPANY  @"expresscompany/list"
///创建/寄快递
#define TWICE_METHOD_OF_SEND_EXPRESS  @"express/create"
///获取寄出的快递列表
#define METHOD_OF_EXPRESS_LIST_ALREADY_SENT    @"express/list"
///获取收取到的快递列表
#define METHOD_OF_EXPRESS_ORDER_LIST_RECEIVE    @"user/orders"
///个人中心：关于我们
#define METHOD_MINE_ABOUT_US                                @"aboutus/index"
///个人中心：检查自动更新
#define METHOD_MINE_CHECK_UPDATE                            @"system/checkforupdate"
///地址：删除地址
#define SYSTEM_ADDRESS_DELETE                                     @"address/delete"
#pragma mark - 消息
///消息：系统未读消息数目   必需  1 系统消息 2 快递消息 3 站内消息
#define METHOD_UNREAD_COUNT                               @"user/unreadmsg"
#define METHOD_MESSAGE_LIST     @"user/messages"


#define ENTITY_TYPE_PROJECT         @"project"  ///创业项目
#define ENTITY_TYPE_SALON           @"salon"    ///创业沙龙
#define ENTITY_TYPE_COURSE          @"course"   ///创业课程














//////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////学院派一期/////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
#pragma mark - 首页相关

///首页栏目
#define METHOD_OF_COLUMNS   @"v1/columns/index?"
///首页大派送接口
#define METHOD_OF_MALL      @"v1/mall/index?"

#pragma mark - 用户相关






///更新导师资料
#define METHOD_OF_UPDATE_TEACHER_INFO    @"v1/user/updateteacherinfo?"

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

///时间银行:申请赴约接口
#define METHOD_TIME_BANK_APPLY_APPOINTMENT    @"v1/timebank/apply?"
///时间银行:申领通过接口
#define METHOD_TIME_BANK_APPLY_PASS           @"v1/timebank/verified/?"
///时间银行：申领拒绝接口
#define METHOD_TIME_BANK_APPLY_REFUSED        @"v1/timebank/reject/?"

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
///创业项目：申领接口
#define METHOD_BUSINESS_CENTER_APPLY_APPOINTMENT               @"v1/project/apply/?"
///创业项目:申领通过接口
#define METHOD_BUSINESS_CENTER_APPLY_PASS                      @"v1/project/verified/?"
///创业项目：申领拒绝接口
#define METHOD_BUSINESS_CENTER_REFUSED                         @"v1/project/reject/?"


#pragma mark - 个人中心“我的”
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


///个人中心：更新用户所属学校
#define METHOD_MINE_USER_USCHOOL                            @"v1/user/updatecollege?"

///个人中心：微信支付
#define WEIXIN_PAY_STYLE                                    @"test/weixin?"


///个人中心：个人主页通过手机号获取
#define METHOD_MINE_HOME_PAGE_BY_MOBILE                     @"v1/user/getuserinfobymobile?"


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
///消息：时间银行申请与拒绝
#define METHOD_EXPRESS_CENTER_TIME_BANK_MESSAGE_LIST              @"v1/message/timebank?"

///消息：删除消息
#define SYSTEM_MESSAGE_Delete                                     @"v1/message/del?"

#pragma mark - 充值&支付&提现相关
///支付:微信支付回调
#define SYSTEM_WXPAY_CALLBACK                                     @"v1/pay/weixinnotify/?"
///支付:获取支付宝回调链接
#define SYSTEM_ALIPAY_CALLBACK                                    @"/v1/pay/alipaynotifyurl/?"

///提现
#define SYSTEM_GET_MONEY                                          @"v1/user/withdrawcash/?"
///添加和更新用户信息
#define SYSTEM_ADD_BANK                                           @"v1/user/addbank?"
///查询某用户的银行卡信息接口
#define SYSTEM_QUERY_BANK                                         @"v1/user/bank?"
///银行列表接口
#define SYSTEM_BANK_LIST                                          @"v1/bank/list?"

#define SHARESDK_URL                                              @"http://fir.im/xueyuanpai"






#endif /* NetworkConfigue_h */
