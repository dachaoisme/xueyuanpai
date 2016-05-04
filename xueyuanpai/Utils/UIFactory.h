//
//  UIFactory.h
//  MFTour
//
//  Created by lidachao on 15/12/1.
//  Copyright © 2015年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFactory : NSObject

/**
 *  @brief  创建lable
 *
 *  @param  frame 设置frame
 *
 *  @param  size  字体size
 *
 *  @param  color 字体颜色
 *
 *  @param  align 字体对齐方式
 *
 *  @return
 */
+(UILabel *)label:(CGRect)frame size:(float)size color:(NSString *)color align:(int)align;
/**
 *  @brief  创建加粗lable
 *
 *  @param  frame  设置frame
 *
 *  @param  size   字体size
 *
 *  @param  color  字体颜色
 *
 *  @param  align  字体对齐方式
 *
 *  @return
 */
+(UILabel *)borderLabel:(CGRect)frame size:(float)size color:(NSString *)color align:(int)align;
/**
 *  @brief  创建斜体lable
 *
 *  @param  frame  设置frame
 *
 *  @param  size   字体size
 *
 *  @param  color  字体颜色
 *
 *  @param  align  字体对齐方式
 *
 *  @return
 */
+(UILabel *)italicLabel:(CGRect)frame size:(float)size color:(NSString *)color align:(int)align;

/**
 *  @brief  创建UIImageView
 *
 *  @param  frame 设置frame
 *
 *  @param  mode  设置图片展示模式
 *
 *  @param  image 图片名字
 *
 *  @return
 */
+(UIImageView *)imageView:(CGRect)frame viewMode:(int)mode image:(NSString *)image;
/**
 *  @brief  创建可拉伸 UIImageView
 *
 *  @param  frame 设置frame
 *
 *  @param  mode  设置图片展示模式
 *
 *  @param  insets 图片名字
 *
 *  @return
 */
+(UIImageView *)scaleImageView:(CGRect)frame viewMode:(int)mode image:(NSString *)image edge:(UIEdgeInsets)insets;
/**
 *  @brief  创建UITableView
 *
 *  @param  style UITableViewStylePlain,UITableViewStyleGrouped
 *
 *  @param  frame 设置frame
 *
 *  @param  insets
 *
 *  @return
 */
+(UITableView *)table:(CGRect)frame style:(int)style deleteAndDataScource:(id)t_delegate;
/**
 *  @brief  创建UIButton
 *
 *  @param  norImg 普通状态图片
 *
 *  @param  selImg 选中状态照片
 *
 *  @param  title  button展示文字
 *
 *  @param  size   字体font大小
 *
 *  @param  frame  buttonframe
 *
 *  @param  insets
 *
 *  @return
 */
+(UIButton *)scaledButton:(NSString *)norImg sel:(NSString *)selImg title:(NSString *)title fontSize:(float)size frame:(CGRect)frame edge:(UIEdgeInsets)insets;

/**
 *  @brief  创建剪切UIButton
 *
 *  @param  norImg 普通状态图片
 *
 *  @param  selImg 选中状态照片
 *
 *  @param  title  button展示文字
 *
 *  @param  size   字体font大小
 *
 *  @param  frame  buttonframe
 *
 *  @return
 */
+(UIButton *)button:(NSString *)normalImg sel:(NSString *)selectImg titleColor:(NSString *)titleColor title:(NSString *)title fontSize:(float)size frame:(CGRect)frame;

/**
 *  @brief 显示细线
 *
 *  @param
 *
 *  @return
 */
+(void)showLineInView:(UIView *)view color:(NSString *)color rect:(CGRect)r;

/**
 *  @brief 返回一个UIView
 *
 *  @param
 *
 *  @return
 */
+(UIView *)viewWithFrame:(CGRect)rect backgroundColor:(NSString *)color;
/**
 *  @brief 返回一个正常的Label
 *
 *  @param
 *
 *  @return
 */
+(UILabel *)normalLabel:(CGRect)frame size:(float)size color:(UIColor *)color align:(int)align backColor:(UIColor*)backColor;

@end
