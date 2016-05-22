//
//  SelectedSexView.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SelectedSexView.h"

@interface SelectedSexView ()
{
    UIControl * control;
}
@end

@implementation SelectedSexView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setContentViewWithFrame:frame];
    }
    return self;
}

-(void)setContentViewWithFrame:(CGRect)frame
{
    float space = 5;
    float width = frame.size.width;
    float height = (frame.size.height-space)/3;
    UIButton * manBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"男" fontSize:15 frame:CGRectMake(0,0 , width, height)];
    [manBtn setBackgroundColor:[UIColor whiteColor]];
    manBtn.tag = 10001;
    manBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [manBtn addTarget:self action:@selector(selectedSxe:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:manBtn];
    
    UIButton * womanBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"女" fontSize:15 frame:CGRectMake(0,CGRectGetMaxY(manBtn.frame), width, height)];
    [womanBtn setBackgroundColor:[UIColor whiteColor]];
    womanBtn.tag = 10002;
    womanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [womanBtn addTarget:self action:@selector(selectedSxe:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:womanBtn];
    
    UIButton * cancelBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"取消" fontSize:15 frame:CGRectMake(0,CGRectGetMaxY(womanBtn.frame)+space, width, height)];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    cancelBtn.tag = 10003;
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [cancelBtn addTarget:self action:@selector(selectedSxe:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    [UIFactory showLineInView:self color:@"e5e5e5" rect:CGRectMake(0, CGRectGetMaxY(manBtn.frame)-0.25, SCREEN_WIDTH, 0.5)];
    control = [UIFactory contolBackgroundWithAlph:0.5];
    control.backgroundColor = [UIColor blackColor];
    
}

-(void)selectedSxe:(UIButton *)sender
{
    if (sender.tag ==10001) {
        //选择男
        NSString * sex = @"男";
        self.callBackBlock(sex);
    }else if (sender.tag ==10002){
        //选择女
        NSString * sex = @"女";
        self.callBackBlock(sex);
    }else{
        //取消
        
    }
    [control removeFromSuperview];
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
