//
//  JMHomePageModel.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/10.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMHomePageModel : NSObject

@property(nonatomic,strong)NSString *bannerId;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *picUrl;
@property(nonatomic,strong)NSString *ord;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *update_time;
@end

/////////////////////实训项目列表item/////////////////////
/*
 "id": "1",      //项目序号
 "title": "sww", //标题
 "description": "q", //摘要
 "college_id": 1,  //学校序号
 "thumbUrl": "http://admin.jm.com/uploads/20170319/14898953617295.jpg",
 //缩略图
 "recruitment_number": "1", //报名数
 "status": 1, //状态 1 正在招募 0  已结束
 "type": "dsd", //性质
 "end_time": "0000-00-00", //截止日期
 "job_name": "111", //招募岗位
 "content": "11",    //内容
 "count_like": 0,   //点赞数
 "count_comment": 0,  //评论数
 "create_time": "2017-03-19 11:29:17", //创建时间
 "update_time": "2017-03-19 11:29:17"， //更新时间
 "colllege_name": "化工学院"
is_online  1:线上 0线下
 */
 @interface JMTrainProjectModel : NSObject

@property(nonatomic,strong)NSString *trainProjectId;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *trainProjectDescription;
@property(nonatomic,strong)NSString *college_id;
@property(nonatomic,strong)NSString *thumbUrl;
@property(nonatomic,strong)NSString *recruitment_number;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *job_name;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *count_like;
@property(nonatomic,strong)NSString *count_comment;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *update_time;
@property(nonatomic,strong)NSString *colllege_name;
@property(nonatomic,strong)NSString *is_online;
@end

/////////////////////实训项目详情/////////////////////
/*
 
 "members": [   //项目成员
 {
 "id": 3,
 "job": "abc",  //职位
 "name": "test", //姓名
 "icon": "http://admin.jm.com/uploads/20170323/14902490234408.png" //头像
 },
 {
 "id": 4,
 "job": "abcqq",
 "name": "test",
 "icon": "http://admin.jm.com/uploads/20170323/14902490099468.png"
 ]
 
 */
@interface JMTrainProjectPeopleModel : NSObject

@property(nonatomic,strong)NSString *trainProjectPeopleId;
@property(nonatomic,strong)NSString *job;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *icon;

@end
/*
 "data": {
     "id": 1,
     "title": "sww",
     "description": "q",
     "college_id": 1,
     "thumbUrl": "http://admin.jm.com/uploads/20170319/14898953617295.jpg",
     "recruitment_number": 1,
     "status": 1,
     "type": "dsd",
     "end_time": "0000-00-00",
     "job_name": "PHP,Java,IOS",
     "content": "11",
     "count_like": 0,
     "count_comment": 0,
     "create_time": "2017-03-19 11:29:17",
     "update_time": "2017-03-19 11:29:17",
     "colllege_name": "化工学院",
    "is_signed": 1, //是否报名过  1报名过 0 未报名
     "members": [   //项目成员
     {
         "id": 3,
         "job": "abc",  //职位
         "name": "test", //姓名
         "icon": "http://admin.jm.com/uploads/20170323/14902490234408.png" //头像
         },
         {
         "id": 4,
         "job": "abcqq",
         "name": "test",
         "icon": "http://admin.jm.com/uploads/20170323/14902490099468.png"
         }
     ]
 }
 */
@interface JMTrainProjectDetailModel : NSObject

@property(nonatomic,strong)NSString *trainProjectDetailId;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *trainProjectDescription;
@property(nonatomic,strong)NSString *college_id;
@property(nonatomic,strong)NSString *thumbUrl;
@property(nonatomic,strong)NSString *recruitment_number;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *job_name;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *count_like;
@property(nonatomic,strong)NSString *count_comment;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *update_time;
@property(nonatomic,strong)NSString *colllege_name;
@property(nonatomic,strong)NSString *is_signed;
@property (nonatomic, strong) NSMutableArray<JMTrainProjectPeopleModel *> *members;
@end

