//
//  JMHomePageThreeTypeTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 17/4/10.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMHomePageThreeTypeTableViewCell.h"

@implementation JMHomePageThreeTypeTableViewCell

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
    
    
    ///创建图片
    if (_showImageView == nil) {
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 93, 70)];
        _showImageView.image = [UIImage imageNamed:@"placeHoder"];
        [self.contentView addSubview:_showImageView];
    }
    
    ///创建标题
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_showImageView.frame) + 15, CGRectGetMinY(_showImageView.frame), 200, 18)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"开发一个移动电商平台";
        [self.contentView addSubview:_titleLabel];
    }
    
    //创建副标题
    if (_subtitleLabel == nil) {
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) + 4, CGRectGetWidth(_titleLabel.frame), 14)];
        _subtitleLabel.font = [UIFont systemFontOfSize:13];
        _subtitleLabel.textColor = [CommonUtils colorWithHex:@"999999"];
        _subtitleLabel.text = @"一句话项目简介";
        [self.contentView addSubview:_subtitleLabel];
    }
    
    
    //定位信息的显示
    if (_locationBtn == nil) {
        
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.frame = CGRectMake(CGRectGetMinX(_subtitleLabel.frame), CGRectGetMaxY(_subtitleLabel.frame) + 10, 50, 12);
        [_locationBtn setImage:[UIImage imageNamed:@"list_icon_weizhi"] forState:UIControlStateNormal];
        [_locationBtn setTitle:@"北京" forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_locationBtn setTitleColor:[CommonUtils colorWithHex:@"999999"] forState:UIControlStateNormal];
        [self.contentView addSubview:_locationBtn];
    }
    
    ///显示多少人的label
    if (_peopleNumberLabel == nil) {
        _peopleNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 100, CGRectGetMinY(_locationBtn.frame), 100, 12)];
        _peopleNumberLabel.text = @"已招募3人";
        _peopleNumberLabel.textColor = [CommonUtils colorWithHex:@"999999"];
        _peopleNumberLabel.font = [UIFont systemFontOfSize:11];
        _peopleNumberLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_peopleNumberLabel];
    }
    
    
    //创建分割线
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(15, 99, SCREEN_WIDTH, 1)];
    grayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:grayView];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
