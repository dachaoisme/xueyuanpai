//
//  UniversityAssnHeaderView.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/21.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    PiecewiseInterfaceTypeMobileLin = 1,
    PiecewiseInterfaceTypeBackgroundChange,
    PiecewiseInterfaceTypeCustomImage
}PiecewiseInterfaceType;

@class UniversityAssnHeaderView;
@protocol UniversityAssnHeaderViewDelegate <NSObject>

/**
 *  按钮点击事件
 */
- (void)headerViewSelctAction:(UniversityAssnHeaderView *)headerView index:(NSInteger)index;

@end


@interface UniversityAssnHeaderView : UIView

///按钮标题
@property (nonatomic,strong)NSArray *titleArray;

///选中状态背景颜色
@property (nonatomic,strong)UIColor *backgroundSeletedColor;

///默认状态背景颜色
@property (nonatomic,strong)UIColor *backgroundNormalColor;

///下划线的颜色
@property (nonatomic,strong)UIColor *linColor;

///文字大小
@property (nonatomic,strong)UIFont *textFont;

///文字默认状态颜色
@property (nonatomic,strong)UIColor *textNormalColor;

///文字选中状态颜色
@property (nonatomic,strong)UIColor *textSeletedColor;

///显示类型
@property (nonatomic, assign) PiecewiseInterfaceType type;

@property (assign, nonatomic) id<UniversityAssnHeaderViewDelegate> delegate;


/**
 *  加载标题显示的方法
 */
- (void)loadTitleArray:(NSArray *)titleArray;

/**
 *  加载自定义图片的方法，如果不需要选中显示图片传nil。自定义按钮显示的数量和顺序是根据传入的图片名称数组的顺序和数量来显示的
 */
- (void)loadNormalImage:(NSArray *)normalImages seletedImage:(NSArray *)seletedImage;

@end
