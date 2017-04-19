//
//  JMMailDeliveryTwoTypeTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMailDeliveryTwoTypeTableViewCell.h"

@implementation JMMailDeliveryTwoTypeTableViewCell

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
    
    if (_jiImageView == nil) {
        _jiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 15, 15)];
        ///两种状态两种图片
        _jiImageView.image = [UIImage imageNamed:@"package_address_a_grey"];
        _jiImageView.image = [UIImage imageNamed:@"package_address_a"];
        [self.contentView addSubview:_jiImageView];
    }
    
    if (_jiAddressLabel == nil) {
        _jiAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_jiImageView.frame) + 8, 10, SCREEN_WIDTH - 40 - 15, 40)];
        _jiAddressLabel.text = @"";
        _jiAddressLabel.numberOfLines = 2;
        _jiAddressLabel.font = [UIFont systemFontOfSize:14];
        _jiAddressLabel.textColor = [CommonUtils colorWithHex:@"c7c6cb"];
        
        _jiImageView.center = CGPointMake(_jiImageView.center.x, _jiAddressLabel.center.y) ;
        [self.contentView addSubview:_jiAddressLabel];
        
    }
    
    
    if (_quImageView == nil) {
        _quImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_jiAddressLabel.frame) + 15, 15, 15)];
        ///两种状态两种图片
        _quImageView.image = [UIImage imageNamed:@"package_address_b_grey"];
        _quImageView.image = [UIImage imageNamed:@"package_address_b"];
        [self.contentView addSubview:_quImageView];
    }
    
    if (_quAddressLabel == nil) {
        _quAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_quImageView.frame) + 8, CGRectGetMaxY(_jiAddressLabel.frame) + 10, SCREEN_WIDTH - 40 - 15, 40)];
        _quAddressLabel.text = @"";
        _quAddressLabel.numberOfLines = 2;
        _quAddressLabel.font = [UIFont systemFontOfSize:14];
        _quAddressLabel.textColor = [CommonUtils colorWithHex:@"c7c6cb"];
        [self.contentView addSubview:_quAddressLabel];
        
        _quImageView.center = CGPointMake(_quImageView.center.x, _quAddressLabel.center.y) ;
        
    }


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
