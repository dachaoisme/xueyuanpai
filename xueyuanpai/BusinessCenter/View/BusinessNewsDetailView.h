//
//  BusinessNewsDetailView.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/30.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessNewsDetailView : UIView

///滚动视图
@property (nonatomic,strong)UIScrollView *bottomScrollView;


///显示标题的label
@property (nonatomic,strong)UILabel *titleLabel;

///显示作者
@property (nonatomic,strong)UILabel *authorLable;


///显示详情的webView
@property (nonatomic,strong)UIWebView *webView;


///显示活动的图片
@property (nonatomic,strong)UIImageView *activityImageView;


//根据活动内容调整scrollView和contextLabel的高度
- (void)adjustSubviewsWithContent:(NSString *)content;


@end
