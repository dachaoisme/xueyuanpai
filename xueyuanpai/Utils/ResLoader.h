//
//  ResLoader.h
//  PanoTrip
//
//  Created by 建强 孙 on 14-1-28.
//  Copyright (c) 2014年 建强 孙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResLoader : NSObject
//根据文件名，和扩展名获取图片，设置是否显示默认图片
+(UIImage *)loadImage:(NSString *)name extend:(NSString *)extend useDefault:(BOOL)use;
//根据文件名，和扩展名获取图片
+(UIImage *)loadImage:(NSString *)name extend:(NSString *)extend;
//根据文件全名获取图片，设置是否显示默认图片
+(UIImage *)loadImage:(NSString *)name useDefault:(BOOL)use;
//根据文件全名获取图片
+(UIImage *)loadImage:(NSString *)name;
//根据文件全名获取json
+(NSString *)loadJson:(NSString *)name;
@end
