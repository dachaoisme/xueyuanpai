//
//  HotActivityModel.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 热门活动接口
 接口地址 ：v1/association/hot
 参数:
 page int  非必需    第几页        默认1
 size int  非必需    每页多少条     默认10
 
 */

@interface HotActivityModel : NSObject

///热门活动的ID号
@property (nonatomic,strong)NSString * hotActivityID;
///热门活动的标题
@property (nonatomic,strong)NSString * title;
///地址
@property (nonatomic,strong)NSString * place;
///热门活动的活动图片
@property (nonatomic,strong)NSString * logoUrl;
///内容
@property (nonatomic,strong)NSString * content;
///创建时间
@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * author;
@property (nonatomic,strong)NSString * brief;


-(id)initWithDic:(NSDictionary *)dic;



@end
