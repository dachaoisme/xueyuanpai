//
//  IndexScrollView.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^scrollViewSelectBlock)(NSInteger index);
@interface IndexScrollView : UIView

/** 图片路径数组 **/
@property (strong, nonatomic) NSArray *pics;
/** pageControl 颜色 **/
@property (strong, nonatomic) UIColor *pageColor;
@property (strong, nonatomic) UIColor *pageSelColor;
@property (nonatomic, copy) scrollViewSelectBlock imgViewSelectBlock; // 图片点击事件
- (void)returnIndex:(scrollViewSelectBlock)block; //代码块回调

/** 赋值以后，调用此方法刷新视图 **/
- (void) reloadView;
@end
