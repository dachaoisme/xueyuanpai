//
//  JMCourseDetailTwoTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCourseDetailTwoTableViewCell.h"

@implementation JMCourseDetailTwoTableViewCell

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
    
    ///整体背景视图
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    backGroundImageView.image = [UIImage imageNamed:@"lesson_offline_detail_banner"];
    [self.contentView addSubview:backGroundImageView];
    
    
    if (_locationBtn == nil) {
        
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.frame = CGRectMake(12, 12, 200, 15);
        [_locationBtn setImage:[UIImage imageNamed:@"list_icon_weizhi"] forState:UIControlStateNormal];
        _locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_locationBtn setTitle:@"北京大学" forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_locationBtn setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
        [backGroundImageView addSubview:_locationBtn];
    }
    
    //标题显示
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_locationBtn.frame), CGRectGetMaxY(_locationBtn.frame) + 20, SCREEN_WIDTH - 30, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [CommonUtils colorWithHex:@"ffffff"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"如何组建一个优秀的团队";
        [backGroundImageView addSubview:_titleLabel];
    }
    
    //内容
    if (_contentLabel == nil) {
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) + 10, SCREEN_WIDTH - 30, 50)];
        _contentLabel.font = [UIFont systemFontOfSize:11];
        _contentLabel.textColor = [CommonUtils colorWithHex:@"ffffff"];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.text = @"课堂简介课堂简介课堂简介课堂简介课堂简介课堂简介课堂简介课堂简介课堂简介课堂简介";
        [backGroundImageView addSubview:_contentLabel];

    }
    
    
    //课程时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backGroundImageView.frame) + 20, 60, 16)];
    timeLabel.text = @"课程时间";
    timeLabel.textColor = [CommonUtils colorWithHex:@"999999"];
    timeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:timeLabel];
    
    
    if (_courseTimeLabel == nil) {
        _courseTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame), CGRectGetMaxY(backGroundImageView.frame) + 20, 250, 16)];
        _courseTimeLabel.font = [UIFont systemFontOfSize:14];
        _courseTimeLabel.textColor = [CommonUtils colorWithHex:@"3f4446"];
        _courseTimeLabel.text = @"2016-9-10 12:00-14:00";
        [self.contentView addSubview:_courseTimeLabel];
    }
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(timeLabel.frame) + 20, 60, 16)];
    locationLabel.text = @"具体地址";
    locationLabel.textColor = [CommonUtils colorWithHex:@"999999"];
    locationLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:locationLabel];

    
    if (_showLocationLabel == nil) {
        _showLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame), CGRectGetMaxY(timeLabel.frame) + 20, 250, 16)];
        _showLocationLabel.font = [UIFont systemFontOfSize:14];
        _showLocationLabel.textColor = [CommonUtils colorWithHex:@"3f4446"];
        _showLocationLabel.text = @"北京大学教学楼203";
        [self.contentView addSubview:_showLocationLabel];
    }

    
    
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
