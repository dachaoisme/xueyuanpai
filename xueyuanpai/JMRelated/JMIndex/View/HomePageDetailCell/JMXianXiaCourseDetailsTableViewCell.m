//
//  JMXianXiaCourseDetailsTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMXianXiaCourseDetailsTableViewCell.h"

@implementation JMXianXiaCourseDetailsTableViewCell

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
    
    if (_headImageView == nil) {
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 40, 40)];
        _headImageView.image = [UIImage imageNamed:@"placeHoder"];
        _headImageView.layer.cornerRadius = 20;
        _headImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_headImageView];
    }
    
    
    //昵称
    if (_nickNameLabel == nil) {
        
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame) + 10, 15, SCREEN_WIDTH - CGRectGetMaxX(_headImageView.frame) - 35, 16)];
        _nickNameLabel.font = [UIFont systemFontOfSize:14];
        _nickNameLabel.textColor = [CommonUtils colorWithHex:@"666666"];
        _nickNameLabel.text = @"张丽";
        [self.contentView addSubview:_nickNameLabel];
        
    }
    
    if (_showCertificationImageView == nil) {
        _showCertificationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame) + 50, CGRectGetMinY(_nickNameLabel.frame), 12, 12)];
        _showCertificationImageView.image = [UIImage imageNamed:@"v_i_p"];
        [self.contentView addSubview:_showCertificationImageView];
        
    }

    if (_degreeLabel == nil) {
        _degreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 100, 15, 100, 16)];
        _degreeLabel.font = [UIFont systemFontOfSize:14];
        _degreeLabel.textColor = [CommonUtils colorWithHex:@"999999"];
        _degreeLabel.text = @"管理学教授";
        [self.contentView addSubview:_degreeLabel];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
