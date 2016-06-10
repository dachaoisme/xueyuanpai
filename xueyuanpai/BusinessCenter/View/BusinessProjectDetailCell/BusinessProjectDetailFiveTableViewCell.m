//
//  BusinessProjectDetailFiveTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessProjectDetailFiveTableViewCell.h"

@implementation BusinessProjectDetailFiveTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - 打电话
- (IBAction)callAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(callPhoneNumberAction)]) {
        [_delegate callPhoneNumberAction];
    }
}


- (void)bindModel:(BusinessCenterProgectDetailChiefModel *)model{
    
    _timeLabel.text = model.businessCenterProgectDetailChiefName;
    _phoneLabel.text = model.businessCenterProgectDetailChiefTelephone;
    _schoolLabel.text = [NSString stringWithFormat:@"%@%@",model.businessCenterProgectDetailChiefCollege,model.businessCenterProgectDetailChiefMajor];
    
    _recordLabel.text = model.businessCenterProgectDetailChiefEducation;
    
    
    _timeLabel.text = model.businessCenterProgectDetailChiefGraduationTime;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
