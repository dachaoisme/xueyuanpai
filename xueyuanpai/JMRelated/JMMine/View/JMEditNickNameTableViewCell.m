//
//  JMEditNickNameTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/8/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMEditNickNameTableViewCell.h"

@implementation JMEditNickNameTableViewCell

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
    
    
    ///创建标题视图
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
    _titleLabel.textColor = [UIColor lightGrayColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLabel];
    
    
    ///创建内容视图
    _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(_titleLabel.frame) - 30, 20)];
    _inputTextField.placeholder = @"请输入";
    _inputTextField.returnKeyType = UIReturnKeyDone;
    _inputTextField.textColor = [UIColor blackColor];
    _inputTextField.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_inputTextField];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
