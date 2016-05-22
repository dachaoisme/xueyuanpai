//
//  AddTeacherInfoTableViewCell.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AddTeacherInfoTableViewCell.h"

@implementation AddTeacherInfoTableViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setContentView];
    }
    return self;
}

-(void)setContentView
{
    /*
    UILabel * mallTitileLable = [UIFactory label:12*3 color:@"999999" align:NSTextAlignmentLeft];
    mallTitileLable.frame = CGRectMake(0, CGRectGetMaxY(mallImageView.frame), CGRectGetWidth(mallImageView.frame), 20) ;
    [self addSubview:mallTitileLable];
    self.mallTitileLable = mallTitileLable;
    
    //请输入手机号
    phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(leftSpace, NAV_TOP_HEIGHT+topSpace, width, height)];
    phoneTextField.tag = 2;
    phoneTextField.delegate = self;
    [phoneTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    phoneTextField.textAlignment = NSTextAlignmentLeft;
    phoneTextField.borderStyle   = UITextBorderStyleNone;
    phoneTextField.placeholder   = @"请输入手机号";
    //myTextField.clearsOnBeginEditing = YES;//设置为YES当用点触文本字段时，字段内容会被清除
    phoneTextField.adjustsFontSizeToFitWidth = YES;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.leftViewMode    = UITextFieldViewModeAlways;
    phoneTextField.rightViewMode   = UITextFieldViewModeAlways;
    [self.view addSubview:phoneTextField];
    
    UIImageView * mallImageView = [UIFactory imageView:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-40) viewMode:UIViewContentModeScaleAspectFill image:nil];
    [self addSubview:mallImageView];
    self.mallImageView = mallImageView;
    
    
    
    UILabel * mallIntegralTitileLable = [UIFactory label:12*3 color:@"999999" align:NSTextAlignmentLeft];
    mallIntegralTitileLable.frame = CGRectMake(0, CGRectGetMaxY(mallTitileLable.frame), CGRectGetWidth(mallTitileLable.frame), 20) ;
    [self addSubview:mallIntegralTitileLable];
    self.mallIntegralTitileLable = mallIntegralTitileLable;
    */
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
