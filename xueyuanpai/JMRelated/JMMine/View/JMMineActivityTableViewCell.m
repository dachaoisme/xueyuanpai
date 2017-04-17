//
//  JMMineActivityTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/14.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMineActivityTableViewCell.h"

@implementation JMMineActivityTableViewCell

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
    
    //创建整体背景视图
    UIImageView *backGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 190)];
    backGroundView.layer.cornerRadius = 4;
    backGroundView.layer.masksToBounds = YES;
    backGroundView.backgroundColor = [[CommonUtils colorWithHex:@"00beaf"] colorWithAlphaComponent:0.5];
    [self.contentView addSubview:backGroundView];
    
    self.backGroundView = backGroundView;

    
    //第几期的label
    if (_periodLabel == nil) {
        
        _periodLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 18)];
        _periodLabel.font = [UIFont systemFontOfSize:14];
        _periodLabel.text = @"";
        _periodLabel.textColor = [CommonUtils colorWithHex:@"ffffff"];
        [backGroundView addSubview:_periodLabel];
    }
    
    ///标题
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_periodLabel.frame) + 20, CGRectGetWidth(backGroundView.frame) - 30, 18)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.text = @"沙龙活动标题";
        _titleLabel.textColor = [CommonUtils colorWithHex:@"ffffff"];
        [backGroundView addSubview:_titleLabel];
    }
    
    if (_subtitleLabel == nil) {
        
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_titleLabel.frame) + 5, CGRectGetWidth(_titleLabel.frame), 18)];
        _subtitleLabel.font = [UIFont systemFontOfSize:15];
        _subtitleLabel.text = @"沙龙活动副标题";
        _subtitleLabel.textColor = [CommonUtils colorWithHex:@"ffffff"];
        [backGroundView addSubview:_subtitleLabel];
    }

    
    if (_dateLabel == nil) {
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_subtitleLabel.frame) + 15, CGRectGetWidth(_titleLabel.frame), 16)];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.text = @"2017-1-23 下午2：30";
        _dateLabel.textColor = [CommonUtils colorWithHex:@"ffffff"];
        [backGroundView addSubview:_dateLabel];
    }
    
    if (_locationBtn == nil) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.frame = CGRectMake(CGRectGetMinX(_dateLabel.frame), CGRectGetMaxY(_dateLabel.frame) + 5, CGRectGetWidth(_titleLabel.frame), 15);
        [_locationBtn setImage:[UIImage imageNamed:@"list_icon_weizhi"] forState:UIControlStateNormal];
        _locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_locationBtn setTitle:@"北京" forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_locationBtn setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
        [backGroundView addSubview:_locationBtn];

    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
