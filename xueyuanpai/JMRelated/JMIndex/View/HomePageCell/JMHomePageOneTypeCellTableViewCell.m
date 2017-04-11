//
//  JMHomePageOneTypeCellTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 17/4/10.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMHomePageOneTypeCellTableViewCell.h"

@implementation JMHomePageOneTypeCellTableViewCell

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
    
    
    //创建左侧集梦创客视图
    UIView *leftSetDreamView = [[UIView alloc] initWithFrame:CGRectMake(60, 25, 60, 70)];
    [self.contentView addSubview:leftSetDreamView];
    
    
    //创建集梦创客图片视图
    UIImageView *setDreamImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 44, 44)];
    setDreamImageView.image = [UIImage imageNamed:@"home_icon_chuangke"];
    setDreamImageView.userInteractionEnabled = YES;
    [leftSetDreamView addSubview:setDreamImageView];
    
    
    //创建显示集梦创客的label
    UILabel *showDreamLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(setDreamImageView.frame) + 10, 60, 15)];
    showDreamLabel.text = @"集梦创客";
    showDreamLabel.userInteractionEnabled = YES;
    showDreamLabel.font = [UIFont systemFontOfSize:13];
    showDreamLabel.textAlignment = NSTextAlignmentCenter;
    [leftSetDreamView addSubview:showDreamLabel];
    
    
    
    
    //创建右侧集梦空间视图
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50 - 60, CGRectGetMinY(leftSetDreamView.frame), CGRectGetWidth(leftSetDreamView.frame), CGRectGetHeight(leftSetDreamView.frame))];
    [self.contentView addSubview:rightView];
    
    
    //创建集梦创客图片视图
    UIImageView *setDreamSpaceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 44, 44)];
    setDreamSpaceImageView.image = [UIImage imageNamed:@"home_icon_kongjian"];
    setDreamSpaceImageView.userInteractionEnabled = YES;
    [rightView addSubview:setDreamSpaceImageView];
    
    
    //创建显示集梦创客的label
    UILabel *showDreamSpaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(setDreamImageView.frame) + 10, 60, 15)];
    showDreamSpaceLabel.text = @"集梦空间";
    showDreamSpaceLabel.userInteractionEnabled = YES;
    showDreamSpaceLabel.textAlignment = NSTextAlignmentCenter;
    showDreamSpaceLabel.font = [UIFont systemFontOfSize:13];
    [rightView addSubview:showDreamSpaceLabel];

    
    
    //添加集梦创客、集梦空间点击事件
    UITapGestureRecognizer *tap1Action = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action)];
    [leftSetDreamView addGestureRecognizer:tap1Action];
    
    
    UITapGestureRecognizer *tap2Action = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action)];
    [rightView addGestureRecognizer:tap2Action];
    
    
}

#pragma mark - 添加集梦创客点击事件
- (void)tap1Action{
    
    
    if ([_delegate respondsToSelector:@selector(tapDreamGuestAction)]) {
        
        [_delegate tapDreamGuestAction];
    }
    
}


#pragma mark - 添加集梦空间点击事件
- (void)tap2Action{
    
    if ([_delegate respondsToSelector:@selector(tapDreamSpaceAction)]) {
        
        [_delegate tapDreamSpaceAction];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
