//
//  JMCommentListTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCommentListTableViewCell.h"

@implementation JMCommentListTableViewCell

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
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
        _headImageView.image = [UIImage imageNamed:@"placeHoder"];
        _headImageView.layer.cornerRadius = 20;
        _headImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_headImageView];
    }
    
    if (_showCertificationImageView == nil) {
        _showCertificationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame) - 8, CGRectGetMaxY(_headImageView.frame) - 12, 12, 12)];
        _showCertificationImageView.image = [UIImage imageNamed:@"v_i_p"];
        [self.contentView addSubview:_showCertificationImageView];

    }
    
    
    //昵称
    if (_nickNameLabel == nil) {
        
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame) + 10, 15, SCREEN_WIDTH - CGRectGetMaxX(_headImageView.frame) - 35, 16)];
        _nickNameLabel.font = [UIFont systemFontOfSize:12];
        _nickNameLabel.textColor = [CommonUtils colorWithHex:@"666666"];
        _nickNameLabel.text = @"张丽";
        [self.contentView addSubview:_nickNameLabel];

    }
    
    //内容
    if (_contentLabel == nil) {
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame) + 10, CGRectGetMaxY(_nickNameLabel.frame) + 5, SCREEN_WIDTH - CGRectGetMaxX(_headImageView.frame) - 35, 16)];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [CommonUtils colorWithHex:@"3f4446"];
        _contentLabel.text = @"大家都没看欧东";
        [self.contentView addSubview:_contentLabel];
        

    }
    
    ///时间
    if (_timeLabel == nil) {
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame) + 10, CGRectGetMaxY(_contentLabel.frame) + 5, SCREEN_WIDTH - CGRectGetMaxX(_headImageView.frame) - 35, 16)];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = [CommonUtils colorWithHex:@"999999"];
        _timeLabel.text = @"4小时前";
        [self.contentView addSubview:_timeLabel];
    }
    
    
    
    UIImageView *commentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 20, 30, 20, 20)];
    commentImageView.image = [UIImage imageNamed:@"timebank_detail_reply"];
    [self.contentView addSubview:commentImageView];

    
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
