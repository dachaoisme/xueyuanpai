//
//  JMExpressSiteModel.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/17.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMExpressSiteModel : NSObject
/*
 "id": "1",
 "college_id": 1,
 "site_name": "dsd",
 "ord": 99,
 "create_time": 2017
 
 */
@property(nonatomic,strong)NSString *expressSiteId;
@property(nonatomic,strong)NSString *college_id;
@property(nonatomic,strong)NSString *site_name;
@property(nonatomic,strong)NSString *ord;
@property(nonatomic,strong)NSString *create_time;
@end
