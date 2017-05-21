//
//  JMSignUpOneTypeTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/12.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSignUpOneTypeTableViewCell.h"

@implementation JMSignUpOneTypeTableViewCell

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
        
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, CGRectGetHeight(self.frame))];
        _leftTitleLabel.font = [UIFont systemFontOfSize:14];
        _leftTitleLabel.text = @"岗位";
        _leftTitleLabel.textColor = [CommonUtils colorWithHex:@"666666"];
        [self.contentView addSubview:_leftTitleLabel];
        
    }
    
    if (_rightContentBtn == nil) {
        _rightContentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightContentBtn setFrame:CGRectMake(CGRectGetMaxX(_leftTitleLabel.frame) + 6, 0,SCREEN_WIDTH-CGRectGetMaxX(_leftTitleLabel.frame)-30, CGRectGetHeight(self.frame))];
        _rightContentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightContentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _rightContentBtn.userInteractionEnabled = NO;
        [_rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];
        _rightContentBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_rightContentBtn setTitleColor:[CommonUtils colorWithHex:@"c7c6cb"] forState:UIControlStateNormal];
        [self.contentView addSubview:_rightContentBtn];
        
    }


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
