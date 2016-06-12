//
//  ActivityDetailView.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ActivityDetailView.h"

#define TopHeight  300

@interface ActivityDetailView ()


- (void)p_setupSubviews;

@end

@implementation ActivityDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        [self p_setupSubviews];
        
    }
    return self;
}


- (void)p_setupSubviews
{
    //scrollView
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, self.bounds.size.height)];
    //    _bottomScrollView.backgroundColor = [UIColor cyanColor];
    [self addSubview:bottomScrollView];
    self.bottomScrollView = bottomScrollView;
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 20, 60)];
    titleLabel.text = @"情暖人间，人家打的的设计费呢";
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [CommonUtils colorWithHex:@"333333"];
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    [bottomScrollView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    
    UILabel *authorLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame)+5, CGRectGetWidth(titleLabel.frame), 20)];
    authorLable.text = @"作者 叶圣陶  2015年10月";
    authorLable.font = [UIFont systemFontOfSize:12];
    authorLable.textColor = [CommonUtils colorWithHex:@"999999"];
    [bottomScrollView addSubview:authorLable];
    self.authorLable = authorLable;
    
    
    //时间
    UIImageView * timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(authorLable.frame), CGRectGetMaxY(authorLable.frame)+ 20, 16, 16)];
    timeImageView.image = [UIImage imageNamed:@"shetuan_icon_time"];
    [bottomScrollView addSubview:timeImageView];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMinY(timeImageView.frame), 160, 20)];
    timeLabel.font = [UIFont systemFontOfSize:14.0];
    timeLabel.textColor = [CommonUtils colorWithHex:@"333333"];
    timeLabel.text = @"2016/4/24 17:00";
    [bottomScrollView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    //显示食堂的背景图片
    UIImageView *locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(timeImageView.frame), CGRectGetMaxY(timeImageView.frame) + 10, 16, 16)];
    locationImageView.image = [UIImage imageNamed:@"shetuan_icon_location"];
    [bottomScrollView addSubview:locationImageView];
    
    //显示食堂位置的lable
    UILabel *locationLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(locationImageView.frame) + 5, CGRectGetMaxY(timeImageView.frame) + 10, 160, 20)];
    locationLable.font = [UIFont systemFontOfSize:14.0];
    locationLable.textColor = [CommonUtils colorWithHex:@"333333"];
    locationLable.text = @"一楼食堂";
    [bottomScrollView addSubview:locationLable];
    self.locationLable = locationLable;

//    //显示详情的lable
//    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(locationLable.frame) + 20, [[UIScreen mainScreen] bounds].size.width - 20, 100)];
//    detailLabel.font = [UIFont systemFontOfSize:14.0];
//    detailLabel.numberOfLines = 0;
//    detailLabel.text = @"你好";
//    detailLabel.textColor = [CommonUtils colorWithHex:@"666666"];
//    [bottomScrollView addSubview:detailLabel];
//    self.detailLabel = detailLabel;
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(locationLable.frame) + 20, [[UIScreen mainScreen] bounds].size.width - 20, 100)];
    webView.scrollView.backgroundColor = [UIColor whiteColor];
    webView.backgroundColor = [UIColor whiteColor];
    [bottomScrollView addSubview:webView];
    webView.scrollView.scrollEnabled = NO;
    self.webView = webView;
    

    
    //图片
//    _activityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 60, 88, 130)];
//    _activityImageView.image = [UIImage imageNamed:@"placeHoder.png"];
//    [_bottomScrollView addSubview:_activityImageView];
    
}


- (void)adjustSubviewsWithContent:(NSString *)content
{
    //计算活动内容的高度
    CGRect contentRect = [content boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width - 20, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    
    CGFloat height = TopHeight+contentRect.size.height;
    
    if (height < self.bounds.size.height) {
        
        height = self.bounds.size.height;
    }
    
    _bottomScrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width , height);
    
    
    
    CGRect contentViewRect = _webView.frame;
    contentViewRect.size.height = contentRect.size.height;
    _webView.frame = contentViewRect;
    
  
    
    
}

@end
