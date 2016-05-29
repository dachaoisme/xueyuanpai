//
//  PositionInforTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "PositionInforTableViewCell.h"

@implementation PositionInforTableViewCell

- (void)bindModel:(SchoolRecruitmentDetailModel *)model{
    
    self.titleLabel.text = model.schoolRecruitmentDetailTitle;
    self.updateTimeLabel.text = model.schoolRecruitmentDetailUpdateTime;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
