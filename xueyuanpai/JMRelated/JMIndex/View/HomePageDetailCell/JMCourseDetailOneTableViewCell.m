//
//  JMCourseDetailOneTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCourseDetailOneTableViewCell.h"

@implementation JMCourseDetailOneTableViewCell

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
    
    if (_showImageView == nil) {
        
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 200)];
        _showImageView.image = [UIImage imageNamed:@"placeHoder"];
        _showImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_showImageView];
    }
    
    if (_playImageView == nil) {
        UIImage *playImage = [UIImage imageNamed:@"play"];
        _playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, playImage.size.width, playImage.size.height)];
        _playImageView.image =playImage;
        _playImageView.userInteractionEnabled = YES;
        _playImageView.center = _showImageView.center;
        [self.contentView addSubview:_playImageView];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
