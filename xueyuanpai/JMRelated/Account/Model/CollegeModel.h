//
//  CollegeModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollegeModel : NSObject

/*
 {
    "id":"3",
    "name":"\u5317\u4eac\u5e08\u8303\u5927\u5b66",\
    "province_id":"1",
    "ord":"99"
 }
 
 */
@property(nonatomic,strong)NSString * collegeID;
@property(nonatomic,strong)NSString * collegeName;
@property(nonatomic,strong)NSString * collegeProvinceID;
@property(nonatomic,strong)NSString * collegeOrd;

-(id)initWithDic:(NSDictionary *)dic;

@end
