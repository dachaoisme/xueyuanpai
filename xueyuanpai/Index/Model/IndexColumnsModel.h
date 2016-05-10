//
//  IndexColumnsModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexColumnsModel : NSObject

/*
 
 "id":1,
 "name":"\u6d4b\u8bd5\u6807\u9898",
 "picUrl":"\/uploads\/20160501\/14620726009400.png",
 "ord":1
 */

@property(nonatomic,strong)NSString * indexColumnsId;
@property(nonatomic,strong)NSString * indexColumnsName;
@property(nonatomic,strong)NSString * indexColumnsPicUrl;
@property(nonatomic,strong)NSString * indexColumnsOrd;

-(id)initWithDic:(NSDictionary *)dic;

@end
