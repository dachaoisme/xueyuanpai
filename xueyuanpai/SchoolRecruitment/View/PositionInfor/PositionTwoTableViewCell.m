//
//  PositionTwoTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "PositionTwoTableViewCell.h"

@implementation PositionTwoTableViewCell

- (void)bindModel:(SchoolRecruitmentDetailModel *)model{
    self.moneyLabel.text = model.schoolRecruitmentDetailSalary;
    self.componyNameLabel.text = model.schoolRecruitmentDetailCompanyName;
    self.componyLocationLabel.text = model.schoolRecruitmentDetailWorksArea;
    self.peopleNumber.text = model.schoolRecruitmentDetailnumber;
    self.recordLabel.text = model.schoolRecruitmentDetailEducation;
    self.genderLabel.text = model.schoolRecruitmentDetailSex;
    self.dateLabel.text = model.schoolRecruitmentDetailWorkinglife;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
