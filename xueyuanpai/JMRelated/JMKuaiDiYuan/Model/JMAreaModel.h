//
//  JMAreaModel.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/17.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMSubAreaModel : NSObject
/*
 {
 "id": 3,
 "name": "济南市",
 "ord": 99
 },
 
 */
@property(nonatomic,strong)NSString *areaId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *ord;
@end

@interface JMAreaModel : NSObject
/*
 {
 "id": 2,
 "name": "山东省",
 "ord": 99,
 "children": [
     {
     "id": 3,
     "name": "济南市",
     "ord": 99
     },
     {
     "id": 4,
     "name": "日照市",
     "ord": 99
     }
 ],
 */
@property(nonatomic,strong)NSString *areaId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *ord;
@property(nonatomic,strong)NSString *parent_id;
@property(nonatomic,strong)NSString *parent;
@property(nonatomic,strong)NSArray <JMSubAreaModel *> *children;
@end
