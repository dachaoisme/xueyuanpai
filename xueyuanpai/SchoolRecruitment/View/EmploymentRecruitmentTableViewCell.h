//
//  EmploymentRecruitmentTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmploymentRecruitmentTableViewCell : UITableViewCell

///职位的label
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

///公司的label
@property (weak, nonatomic) IBOutlet UILabel *compony;


///招收的学生
@property (weak, nonatomic) IBOutlet UILabel *studentLabel;

///工作时间
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

///工作薪水
@property (weak, nonatomic) IBOutlet UILabel *offerLabel;


@end
