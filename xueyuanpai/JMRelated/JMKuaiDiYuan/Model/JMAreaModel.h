//
//  JMAreaModel.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/17.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMAreaModel : NSObject
/*
 "id": 1,
 "name": "北京市",
 "ord": 99,
 "parent_id": 0
 */
@property(nonatomic,strong)NSString *areaId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *ord;
@property(nonatomic,strong)NSString *parent_id;

@end
