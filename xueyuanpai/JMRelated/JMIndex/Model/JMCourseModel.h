//
//  JMCourseModel.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/15.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 presenter =     (
 {
 iconUrl = "http://114.215.111.210:999/backend/web/uploads/20170511/14944921203353.png";
 name = "\U6d4b\U8bd5\U4e3b\U8bb2\U4eba";
 title = test;
 }
 );
 
 */
///主讲人
@interface JMPresenter : NSObject

@property(nonatomic,strong)NSString *iconUrl;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *title;

@end

@interface JMCourseModel : NSObject
/////////////////////实训项目列表item/////////////////////
/*
 
 "id": 1,
 "title": "title",
 "description": "zhaiyao",
 "content": "11",
 "thumbUrl": "http://admin.jm.com/uploads/20170323/14902576218693.jpg",
 "bannerUrl": "http://admin.jm.com/uploads/20170323/14902576154778.png",
 "author": "1",
 "videoUrl": "",
 "count_like": 0,
 "count_comment": 0,
 "count_mark": 0,
 "college_id": 1,
 "course_time": "1233",
 "course_addr": "11112",
 "create_time": "2017-03-23 15:27:05",
 "update_time": "2017-03-23 16:32:49",
 "colllege_name": "化工学院"
 
 is_online  1:线上 0线下
 */

@property(nonatomic,strong)NSString *courseItemId;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *courseDescription;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *thumbUrl;
@property(nonatomic,strong)NSString *bannerUrl;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *videoUrl;
@property(nonatomic,strong)NSString *count_like;
@property(nonatomic,strong)NSString *count_comment;
@property(nonatomic,strong)NSString *count_mark;
@property(nonatomic,strong)NSString *college_id;
@property(nonatomic,strong)NSString *course_time;
@property(nonatomic,strong)NSString *course_addr;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *update_time;
@property(nonatomic,strong)NSString *colllege_name;
@property(nonatomic,strong)NSString *online;
@property(nonatomic,strong)NSArray<JMPresenter *> *presenter;
@end


/*
 author = 1;
 bannerUrl = "";
 "college_id" = 1;
 "colllege_name" = "\U5316\U5de5\U5b66\U9662";
 content = 11;
 "count_comment" = 0;
 "count_like" = 0;
 "count_mark" = 0;
 "course_addr" = 11112;
 "course_time" = 1;
 "create_time" = "2017-03-23 15:27:05";
 description = zhaiyao;
 id = 1;
 thumbUrl = 1;
 title = title;
 "update_time" = "2017-03-23 15:36:37";
 videoUrl = 1;
 
 
 */
