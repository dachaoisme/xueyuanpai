//
//  SchoolRecruitmentTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/26.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SchoolRecruitmentTableViewCell.h"

@interface SchoolRecruitmentTableViewCell ()
///显示title
@property (weak, nonatomic) IBOutlet UILabel *showTitleLabel;
///显示公司名字
@property (weak, nonatomic) IBOutlet UILabel *showContentLabel;

///显示学历的label
@property (weak, nonatomic) IBOutlet UILabel *showRecordLabel;

///显示时间的label
@property (weak, nonatomic) IBOutlet UILabel *showTimeLabel;

///显示工作薪金
@property (weak, nonatomic) IBOutlet UILabel *showMoneyLabel;



@end
@implementation SchoolRecruitmentTableViewCell


- (void)awakeFromNib {
    // Initialization code
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
