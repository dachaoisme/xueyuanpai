//
//  HomePageDetailOneTypeTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 17/4/11.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "HomePageDetailOneTypeTableViewCell.h"

@implementation HomePageDetailOneTypeTableViewCell

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
    
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 18)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"开发一个移动电商平台";
        [self.contentView addSubview:_titleLabel];

    }
    
    
    //定位信息的显示
    if (_locationBtn == nil) {
        
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) + 5, 100, 15);
        [_locationBtn setImage:[UIImage imageNamed:@"list_icon_weizhi"] forState:UIControlStateNormal];
        _locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_locationBtn setTitle:@"北京" forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_locationBtn setTitleColor:[CommonUtils colorWithHex:@"bbbbbb"] forState:UIControlStateNormal];
        [self.contentView addSubview:_locationBtn];
    }

    //时间的显示
    if (_timeLabel == nil) {
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 200, CGRectGetMinY(_locationBtn.frame), 200, 15)];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [CommonUtils colorWithHex:@"bbbbbb"];
        _timeLabel.text = @"2015-9-10";
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
        
    }
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
