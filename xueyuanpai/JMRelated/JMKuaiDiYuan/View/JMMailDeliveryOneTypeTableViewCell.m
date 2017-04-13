//
//  JMMailDeliveryOneTypeTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMailDeliveryOneTypeTableViewCell.h"

@implementation JMMailDeliveryOneTypeTableViewCell

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
    
    ///订单号
    if (_showOrderNumberLabel == nil) {
        _showOrderNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, 200, 16)];
        _showOrderNumberLabel.font = [UIFont systemFontOfSize:14];
        _showOrderNumberLabel.text = @"订单编号123456";
        _showOrderNumberLabel.textColor = [CommonUtils colorWithHex:@"999999"];
        [self.contentView addSubview:_showOrderNumberLabel];
    }
    
    
    ///订单状态
    if (_showStatuesLabel == nil) {
        _showStatuesLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 100, 20, 100, 14)];
        _showStatuesLabel.font = [UIFont systemFontOfSize:12];
        _showStatuesLabel.text = @"未寄出已失效";
        _showStatuesLabel.textColor = [CommonUtils colorWithHex:@"999999"];
        _showStatuesLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_showStatuesLabel];

    }
    
    ///当前日期
    if (_showDateLabel == nil) {
        _showDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_showOrderNumberLabel.frame) + 10, 200, 12)];
        _showDateLabel.font = [UIFont systemFontOfSize:11];
        _showDateLabel.text = @"2017-1-1";
        _showDateLabel.textColor = [CommonUtils colorWithHex:@"aaaaaa"];
        [self.contentView addSubview:_showDateLabel];
    }
    
    
    ///等待寄出的时间
    if (_showWaitTimeLabel == nil) {
        _showWaitTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 100, CGRectGetMaxY(_showOrderNumberLabel.frame) + 10, 100, 12)];
        _showWaitTimeLabel.font = [UIFont systemFontOfSize:11];
        _showWaitTimeLabel.textColor = [CommonUtils colorWithHex:@"aaaaaa"];
        [self.contentView addSubview:_showWaitTimeLabel];
    }



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
