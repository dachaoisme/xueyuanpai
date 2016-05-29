//
//  RecruitmentOneStyleTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RecruitmentOneStyleTableViewCell.h"

@implementation RecruitmentOneStyleTableViewCell

- (void)bindModel:(SchoolRecruitmentDetailModel *)model{
    
    //设置数据
    self.componyName.text = model.schoolRecruitmentDetailCompanyName;
    
    self.licenseTextLabel.text = model.schoolRecruitmentDetailBusinesslicense;
    self.industryLabel.text = model.schoolRecruitmentDetailIndustry;
    self.pepoleLabel.text = model.schoolRecruitmentDetailScale;
    self.natureLabel.text = model.schoolRecruitmentDetailCompanyProperty;
    self.locationLabel.text = model.schoolRecruitmentDetailCompanyAddress;
}

- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
