//
//  EmploymentRecruitmentTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "EmploymentRecruitmentTableViewCell.h"

@implementation EmploymentRecruitmentTableViewCell

-(void)bindModel:(SchoolRecruitmentModel *)model
{
    self.positionLabel.text = model.schoolRecruitmentTitle;
    self.compony.text = model.schoolRecruitmentCompany;
    
    self.studentLabel.text = [NSString stringWithFormat:@"%@|%@",model.schoolRecruitmentEducation,model.schoolRecruitmentWorkinglife];
    
    self.dateLabel.text = model.schoolRecruitmentDay;
    self.offerLabel.text = model.schoolRecruitmentSalary;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
