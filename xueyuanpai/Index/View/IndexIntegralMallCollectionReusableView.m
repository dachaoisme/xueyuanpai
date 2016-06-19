//
//  IndexIntegralMallCollectionReusableView.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/9.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "IndexIntegralMallCollectionReusableView.h"

@implementation IndexIntegralMallCollectionReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentView];
    }
    
    return self;
}

-(void)setContentView
{
    
    
    UIView * view = [UIFactory viewWithFrame:self.bounds backgroundColor:@"ffffff"];
    [self addSubview:view];
    
//    UILabel * titileLable = [UIFactory label:12*3 color:@"999999" align:NSTextAlignmentLeft];
//    titileLable.frame = CGRectMake(15, 0, 80, 50);
//    titileLable.text = @"积分商城";
//    [view addSubview:titileLable];
//    self.titileLable = titileLable;
    
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 10)];
    grayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view addSubview:grayView];

    
    UIImageView * showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 28, 50, 17)];
    showImageView.image = [UIImage imageNamed:@"home_big_pi"];
    [view addSubview:showImageView];
    self.showImageView = showImageView;
    
    
    UIButton * button = [UIFactory button:nil sel:nil titleColor:@"999999" title:@"查看全部" fontSize:12 frame:CGRectMake(CGRectGetWidth(self.frame)-95, 10, 80,  50)];
    [button setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    float length = [CommonUtils getTextSizeWithText:@"查看全部" WithFont:12 WithTextheight:17].width;
    UIImage * arrowImg = [UIImage imageNamed:@"arrow"];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -arrowImg.size.width, 0, 3)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, length+20 , 0, 0)];
    [button addTarget:self action:@selector(getMoreData:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    self.button = button;
    
//    [UIFactory showLineInView:self color:@"999999" rect:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.3)];
    
}
-(void)getMoreData:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(getMoreIntegralMall)]) {
        [self.delegate getMoreIntegralMall];
    }
}

@end
