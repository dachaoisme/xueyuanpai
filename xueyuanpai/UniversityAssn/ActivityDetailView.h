//
//  ActivityDetailView.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDetailView : UIView

///滚动视图
@property (nonatomic,strong)UIScrollView *bottomScrollView;


///显示标题的label
@property (nonatomic,strong)UILabel *titleLabel;

///显示作者
@property (nonatomic,strong)UILabel *authorLable;

///显示时间
@property (nonatomic,strong)UILabel *timeLabel;

///显示位置
@property (nonatomic,strong)UILabel *locationLable;

///显示详情的lable
//@property (nonatomic,strong)UILabel *detailLabel;

@property (nonatomic,strong)UIWebView *webView;




//根据活动内容调整scrollView和contextLabel的高度
- (void)adjustSubviewsWithContent:(NSString *)content;


@end
