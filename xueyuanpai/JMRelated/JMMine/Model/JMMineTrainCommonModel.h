//
//  JMMineTrainCommonModel.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/15.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMMineTrainCommonModel : NSObject
/*
 "id": 4,
                 "user_id": "1",
                 "entity_id": "1",
                 "entity_type": "course",
                 "job": "abcqq",
                 "name": "test",
                 "telphone": "13718360863",
                 "icon": "http://admin.jm.com/uploads/20170326/14904952012965.png",
                 "reason": "11111",
                 "status": "1",
                 "create_time": "2017-03-23 06:09:59",
                 "colllege_name": "",
                 "count_like": 0,
                 "count_comment": 0,
                 "count_mark": 0,
                 "college_id": 0

                "count_partin": 0 ///创业沙龙才有
 */

@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *entity_id;
@property(nonatomic,strong)NSString *entity_type;
@property(nonatomic,strong)NSString *job;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *telphone;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *reason;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *colllege_name;
@property(nonatomic,strong)NSString *count_like;
@property(nonatomic,strong)NSString *count_comment;
@property(nonatomic,strong)NSString *count_mark;
@property(nonatomic,strong)NSString *college_id;
@property(nonatomic,strong)NSString *count_partin;
@end
