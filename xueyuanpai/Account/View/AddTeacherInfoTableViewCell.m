//
//  AddTeacherInfoTableViewCell.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AddTeacherInfoTableViewCell.h"

@interface AddTeacherInfoTableViewCell ()<UITextFieldDelegate>
{
   
    UITextField * titleTextField;
}
@end

@implementation AddTeacherInfoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setContentView];
    }
    return self;
    
}


-(void)setContentView
{
    float leftWidth = 60;
    float space = 16;
    float rightWidth = 30;
    float centerWidth = SCREEN_WIDTH-leftWidth-rightWidth-2*space;
    float height = 44;
    
    _titleLable = [UIFactory label:12*3 color:@"c7c7cb" align:NSTextAlignmentLeft];
    _titleLable.frame = CGRectMake(space, 0, leftWidth, height) ;
    [self.contentView addSubview:_titleLable];
    
    //请输入手机号
    titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLable.frame),0, centerWidth, height)];
    titleTextField.tag = self.tag;
    titleTextField.delegate = self;
    titleTextField.textColor = [CommonUtils colorWithHex:@"c7c7cb"];
    titleTextField.textAlignment = NSTextAlignmentLeft;
    titleTextField.borderStyle   = UITextBorderStyleNone;
    //myTextField.clearsOnBeginEditing = YES;//设置为YES当用点触文本字段时，字段内容会被清除
    titleTextField.adjustsFontSizeToFitWidth = YES;
    titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    titleTextField.leftViewMode    = UITextFieldViewModeAlways;
    titleTextField.rightViewMode   = UITextFieldViewModeAlways;
    [self.contentView addSubview:titleTextField];
    
    UILabel * tipsLable = [UIFactory label:12*3 color:@"c7c7cb" align:NSTextAlignmentLeft];
    tipsLable.frame = CGRectMake(CGRectGetMaxX(titleTextField.frame),0 , rightWidth, height) ;
    tipsLable.text = @"必填";
    [self.contentView addSubview:tipsLable];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.delegate respondsToSelector:@selector(updateInputInfoWithIndex:withTextFieldText:)]) {
        [self.delegate updateInputInfoWithIndex:textField.tag withTextFieldText:string];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
