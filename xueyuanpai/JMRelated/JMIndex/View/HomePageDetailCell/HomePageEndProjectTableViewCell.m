//
//  HomePageEndProjectTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/12.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "HomePageEndProjectTableViewCell.h"

@implementation HomePageEndProjectTableViewCell

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
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 46, 46)];
        _headImageView.image = [UIImage imageNamed:@"placeHoder"];
        _headImageView.layer.cornerRadius = 23;
        _headImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_headImageView];
    }
    
    
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame) + 10, 18, 200, 16)];
        _nickNameLabel.font = [UIFont systemFontOfSize:14];
        _nickNameLabel.textColor = [CommonUtils colorWithHex:@"333333"];
        _nickNameLabel.text = @"张丽";
        [self.contentView addSubview:_nickNameLabel];
    }
    
    
    if (_inforLabel == nil) {
        _inforLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame) + 10, CGRectGetMaxY(_nickNameLabel.frame) + 5, 200, 16)];
        _inforLabel.font = [UIFont systemFontOfSize:14];
        _inforLabel.textColor = [CommonUtils colorWithHex:@"aaaaaa"];
        _inforLabel.text = @"市场营销人员";
        [self.contentView addSubview:_inforLabel];
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
