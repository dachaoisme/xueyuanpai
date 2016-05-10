//
//  IndexMallModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexMallModel : NSObject

/*
 "id":2,             //序号
 "title":"xcdddd",  //标题
 "thumbUrl":"http:\/\/admin.c.com\/uploads\/20160504\/14624022816617.png", //缩略图
 "points":"q"   //积分
 */

@property(nonatomic,strong)NSString * indexMallId;
@property(nonatomic,strong)NSString * indexMallTitle;
@property(nonatomic,strong)NSString * indexMallThumbUrl;
@property(nonatomic,strong)NSString * indexMallPoints;

-(id)initWithDic:(NSDictionary *)dic;

@end
