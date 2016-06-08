//
//  RegisterRoleView.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/11.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RegisterRoleView.h"

@implementation RegisterRoleView
-(id)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentViewWithSuperView:superView];
    }
    return self;
}

-(void)setContentViewWithSuperView:(UIView *)superView
{
    control = [[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
    control.backgroundColor = [UIColor blackColor];
    [control addTarget:self action:@selector(removeTheView) forControlEvents:UIControlEventTouchUpInside];
    control.alpha = 0.3;
    [superView addSubview:control];
    
    
    
    CGRect leftRect = CGRectMake(0,0,CGRectGetWidth(self.frame)/2,CGRectGetHeight(self.frame));
    CGRect rightRect = CGRectMake(CGRectGetWidth(self.frame)/2,0,CGRectGetWidth(self.frame)/2,CGRectGetHeight(self.frame));
    
    teacherAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [teacherAccountBtn setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    teacherAccountBtn.tag = 10001;
    UIImage *image = [UIImage imageNamed:@"signup_teacher"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [teacherAccountBtn setImage:image forState:UIControlStateNormal];
    
    teacherAccountBtn.imageEdgeInsets = UIEdgeInsetsMake(20,teacherAccountBtn.center.x + 30,21,teacherAccountBtn.titleLabel.bounds.size.width);
    teacherAccountBtn.titleEdgeInsets = UIEdgeInsetsMake(71, -teacherAccountBtn.titleLabel.bounds.size.width-50, 0, 0);
    
    [teacherAccountBtn setTitleColor:[CommonUtils colorWithHex:@"999999"] forState:UIControlStateNormal];
    [teacherAccountBtn setFrame:leftRect];
    [teacherAccountBtn addTarget:self action:@selector(selectedLoginMethodWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [teacherAccountBtn setTitle:@"我是导师" forState:UIControlStateNormal];
    
    
    
    teacherAccountBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:teacherAccountBtn];
    
    
    
    personalAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [personalAccountBtn setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    personalAccountBtn.tag = 10002;
    [personalAccountBtn setImage:[UIImage imageNamed:@"signup_student"] forState:UIControlStateNormal];
    [personalAccountBtn setTitleColor:[CommonUtils colorWithHex:@"999999"] forState:UIControlStateNormal];
    [personalAccountBtn setFrame:rightRect];
    [personalAccountBtn addTarget:self action:@selector(selectedLoginMethodWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [personalAccountBtn setTitle:@"我是学生" forState:UIControlStateNormal];
    personalAccountBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:personalAccountBtn];
    float height = CGRectGetHeight(self.frame);
    float width = CGRectGetWidth(self.frame);
    float lineWidth = 0.5;
    [UIFactory showLineInView:self color:@"999999" rect:CGRectMake(width/2-lineWidth/2, height/6, lineWidth, height*2/3)];
}

-(void)removeTheView
{
    [control removeFromSuperview];
    [self removeFromSuperview];
}
-(void)selectedLoginMethodWithBtn:(UIButton *)sender
{
    [control removeFromSuperview];
    if (sender.tag == 10001) {
        if ([self.delegate respondsToSelector:@selector(registerRoleWithType:)]) {
            [CommonUtils showToastWithStr:@"我是导师"];
            [self.delegate registerRoleWithType:RegisterRoleTypeTeacher];
        }
        
        
    }else{
        if ([self.delegate respondsToSelector:@selector(registerRoleWithType:)]) {
            [self.delegate registerRoleWithType:RegisterRoleOfStudent];
            [CommonUtils showToastWithStr:@"我是学生"];
        }
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
