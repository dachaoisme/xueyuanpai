//
//  IndexBannerModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndexBannerModel : NSObject

/*
 id = 2;
 linkUrl = "\U7b2c\U4e09\U53d1\U591a\U5c11"; ////链接地址
 linkto = 0; //跳转到  0 url地址  1 大学生新生攻略 2 创业课程 3 创业实训课程
 ord = 99; //排序
 picUrl = "/uploads/20160510/14628708148624.png";
 title = hhh;
 
 */

@property(nonatomic,strong)NSString * IndexBannerID;
@property(nonatomic,strong)NSString * IndexBannerLinkUrl;
@property(nonatomic,strong)NSString * IndexBannerLinkTo;
@property(nonatomic,strong)NSString * IndexBannerOrd;
@property(nonatomic,strong)NSString * IndexBannerPicUrl;
@property(nonatomic,strong)NSString * IndexBannerTitle;

-(id)initWithDic:(NSDictionary *)dic;
@end
