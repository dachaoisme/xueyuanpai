//
//  HomePageDetailTwoTypeTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 17/4/11.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "HomePageDetailTwoTypeTableViewCell.h"

@implementation HomePageDetailTwoTypeTableViewCell

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
    
    //创建中间的竖线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 1.5, 20, 1.5, 40)];
    lineView.backgroundColor = [CommonUtils colorWithHex:@"eeeeee"];
    [self.contentView addSubview:lineView];
    
    
    //左侧视图
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH/2 - 1.5, 40)];
    [self.contentView addSubview:leftView];
    
    
    //添加左侧相关的视图
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 4, 32, 32)];
    leftImageView.image = [UIImage imageNamed:@"detail_icon_type"];
    leftImageView.layer.cornerRadius = 16;
    leftImageView.layer.masksToBounds = YES;
    [leftView addSubview:leftImageView];
    self.showNatureImageView = leftImageView;
    
    
    //添加左侧上边的label
    UILabel *leftTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImageView.frame) + 10, 0, 100, 18)];
    leftTopLabel.text = @"性质";
    leftTopLabel.textColor = [CommonUtils colorWithHex:@"999999"];
    leftTopLabel.font = [UIFont systemFontOfSize:13];
    [leftView addSubview:leftTopLabel];
    self.showNatureTopLabel = leftTopLabel;
    
    //添加左侧下方的label
    UILabel *leftBottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(leftTopLabel.frame), CGRectGetMaxY(leftTopLabel.frame), 100, 20)];
    leftBottomLabel.text = @"实训";
    leftBottomLabel.textColor = [CommonUtils colorWithHex:@"333333"];
    leftBottomLabel.font = [UIFont systemFontOfSize:14];
    [leftView addSubview:leftBottomLabel];
    self.showNatureBottomLabel = leftBottomLabel;
    
    
    //右侧视图
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 20, SCREEN_WIDTH/2, 40)];
    [self.contentView addSubview:rightView];
    
    
    //添加右侧相关的视图
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 4, 32, 32)];
    rightImageView.image = [UIImage imageNamed:@"detail_icon_time"];
    rightImageView.layer.cornerRadius = 16;
    rightImageView.layer.masksToBounds = YES;
    [rightView addSubview:rightImageView];
    self.showTimeImageView = rightImageView;
    
    
    //添加左侧上边的label
    UILabel *rightTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImageView.frame) + 10, 0, 100, 18)];
    rightTopLabel.text = @"报名截止日期";
    rightTopLabel.textColor = [CommonUtils colorWithHex:@"999999"];
    rightTopLabel.font = [UIFont systemFontOfSize:13];
    [rightView addSubview:rightTopLabel];
    self.showTimeTopLabel = rightTopLabel;
    
    //添加左侧下方的label
    UILabel *rightBottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(leftTopLabel.frame), CGRectGetMaxY(leftTopLabel.frame), 100, 20)];
    rightBottomLabel.text = @"实训";
    rightBottomLabel.textColor = [CommonUtils colorWithHex:@"333333"];
    rightBottomLabel.font = [UIFont systemFontOfSize:14];
    [rightView addSubview:rightBottomLabel];
    self.showTimeBottomLabel = rightBottomLabel;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
