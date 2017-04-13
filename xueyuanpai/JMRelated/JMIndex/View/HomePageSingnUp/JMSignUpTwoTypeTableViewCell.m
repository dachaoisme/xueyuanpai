//
//  JMSignUpTwoTypeTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/12.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSignUpTwoTypeTableViewCell.h"

@implementation JMSignUpTwoTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initContentCell];
    }
    return self;
}


- (void)initContentCell{
    
    if (_leftTitleLabel == nil) {
        
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 18)];
        _leftTitleLabel.font = [UIFont systemFontOfSize:14];
        _leftTitleLabel.text = @"姓名";
        _leftTitleLabel.textColor = [CommonUtils colorWithHex:@"666666"];
        [self.contentView addSubview:_leftTitleLabel];
        
    }
    
    
    if (_rightTextFeild == nil) {
        
        
        _rightTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftTitleLabel.frame) + 6, 15, 100, 18)];
        _rightTextFeild.font = [UIFont systemFontOfSize:14];
        _rightTextFeild.placeholder = @"请输入";
        _rightTextFeild.returnKeyType = UIReturnKeyDone;
        _rightTextFeild.delegate = self;
        [self.contentView addSubview:_rightTextFeild];

    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _rightTextFeild.tag = self.tag;
    if ([self.delegate respondsToSelector:@selector(inputEndWithText:withRow:)]) {
        [self.delegate inputEndWithText:textField.text withRow:textField.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
