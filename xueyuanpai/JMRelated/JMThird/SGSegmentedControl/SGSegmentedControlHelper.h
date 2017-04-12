
//
//  SGSegmentedControlHelper.h
//  SGSegmentedControlExample
//
//  Created by Sorgle on 16/12/7.
//  Copyright © 2015年 Sorgle. All rights reserved.
//

#ifndef SGSegmentedControlHelper_h
#define SGSegmentedControlHelper_h

/*
    使用说明
        建议（可不采取）
        创建底部滚动视图，最好底部视图的高度等于整个屏幕的高度，如是里面的子控制器里面创建UITableView，建议修改UITableView的contentInset属性
 */

#import "UIView+SGExtension.h"
/** 指示器默认颜色 */
#define SG_indicatorColor [CommonUtils colorWithHex:@"1a1a1a"]
/** 指示器默认标题颜色 */
#define SG_titleColor [CommonUtils colorWithHex:@"1a1a1a"]
/** 指示器默认标题选中时的颜色 */
#define SG_selectedTitleColor [CommonUtils colorWithHex:@"1a1a1a"]

/** 指示器的高度 */
static CGFloat SG_indicatorHeight = 3;
/** 指示器的动画移动时间 */
static CGFloat SG_indicatorAnimationTime = 0.1;
/** 默认标题字体大小 */
static CGFloat SG_defaultTitleFont = 17;
/** 按钮之间的间距(滚动时按钮之间的间距) */
static CGFloat SG_btnMargin = 15;
/** 标题按钮文字的缩放倍数 */
static CGFloat SG_btnScale = 0.14;
/** 默认SGImageButton_Horizontal图片的宽度 */
static CGFloat SG_defaultHorizontalImageWidth = 20;


#endif /* SGSegmentedControlHelper_h */
