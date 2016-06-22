//
//  BannerLunBoView.h
//  MonitorHelper
//
//  Created by ldc on 14-6-16.
//
//

#import <UIKit/UIKit.h>

@interface BannerLunBoView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@property (nonatomic , readonly) UIScrollView *scrollView;
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , assign) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , strong) NSURL *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , strong) void (^TapActionBlock)(NSInteger pageIndex);

@end
