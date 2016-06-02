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
    
    UILabel * titileLable = [UIFactory label:12*3 color:@"999999" align:NSTextAlignmentLeft];
    titileLable.frame = CGRectMake(15, 0, 80, 50);
    titileLable.text = @"积分商城";
    [view addSubview:titileLable];
    self.titileLable = titileLable;
    
    UIButton * button = [UIFactory button:nil sel:nil titleColor:@"999999" title:@"查看更多 >" fontSize:10 frame:CGRectMake(CGRectGetWidth(self.frame)-95, 0, 80,  50)];
    [button addTarget:self action:@selector(getMoreData:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    self.button = button;
    
    [UIFactory showLineInView:self color:@"999999" rect:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.3)];
    
}
-(void)getMoreData:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(getMoreIntegralMall)]) {
        [self.delegate getMoreIntegralMall];
    }
}

@end
