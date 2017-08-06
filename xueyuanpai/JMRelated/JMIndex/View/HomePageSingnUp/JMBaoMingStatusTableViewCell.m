//
//  JMBaoMingStatusTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/8/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMBaoMingStatusTableViewCell.h"



@implementation JMBaoMingStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createContenView];
    }
    
    return self;
}

- (void)createContenView{
    
    _quanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 12, 12)];
    _quanImageView.image = [UIImage imageNamed:@"profile_dot_highlight"];
    [self.contentView addSubview:_quanImageView];
    
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(_quanImageView.frame), CGRectGetMaxY(_quanImageView.frame), 0.5, 60)];
    _lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_lineView];
    
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_quanImageView.frame) + 15, 15, SCREEN_WIDTH - CGRectGetMaxX(_quanImageView.frame) - 30, 14)];
    _dateLabel.text = @"2017-01-02 12:00:00";
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _dateLabel.textColor = [CommonUtils colorWithHex:@"999999"];
    [self.contentView addSubview:_dateLabel];
    
    
    
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_dateLabel.frame), CGRectGetMaxY(_dateLabel.frame) + 5, SCREEN_WIDTH - CGRectGetMaxX(_quanImageView.frame) - 30, 16)];
    _statusLabel.text = @"您已提交报名申请，等待系统审核确认";
    _statusLabel.font = [UIFont systemFontOfSize:14];
    _statusLabel.textColor = [CommonUtils colorWithHex:@"999999"];
    [self.contentView addSubview:_statusLabel];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
