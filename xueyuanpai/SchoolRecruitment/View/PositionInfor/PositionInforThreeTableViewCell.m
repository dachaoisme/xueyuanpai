//
//  PositionInforThreeTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "PositionInforThreeTableViewCell.h"

@implementation PositionInforThreeTableViewCell

- (void)bindModel:(SchoolRecruitmentDetailModel *)model{
    
    self.descriptionLabel.text = model.schoolRecruitmentDetailJobDescription;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
