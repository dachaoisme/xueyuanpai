//
//  JMSelectAddressTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSelectAddressTableViewCell.h"

@implementation JMSelectAddressTableViewCell

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
 
    if (_nameAndPhoneLabel == nil) {
        
        _nameAndPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, SCREEN_WIDTH - 30, 16)];
        _nameAndPhoneLabel.font = [UIFont systemFontOfSize:14];
        _nameAndPhoneLabel.text = @"李林  18511870286";
        _nameAndPhoneLabel.textColor = [CommonUtils colorWithHex:@"666666"];
        [self.contentView addSubview:_nameAndPhoneLabel];

    }
    
    
    if (_addressLabel == nil) {
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_nameAndPhoneLabel.frame) + 10, SCREEN_WIDTH - 30, 16)];
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.text = @"北京市海淀区惠新西街小区23号楼201";
        _addressLabel.textColor = [CommonUtils colorWithHex:@"666666"];
        [self.contentView addSubview:_addressLabel];
        
    }
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
        [_editBtn setFrame:CGRectMake(SCREEN_WIDTH - 15 - 22, 25, 22, 22)];
        [self.contentView addSubview:_editBtn];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
