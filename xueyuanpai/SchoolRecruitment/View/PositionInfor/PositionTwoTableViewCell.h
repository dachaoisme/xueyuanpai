//
//  PositionTwoTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SchoolRecruitmentModel.h"

@interface PositionTwoTableViewCell : UITableViewCell

///月薪
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

///公司名称
@property (weak, nonatomic) IBOutlet UILabel *componyNameLabel;
///工作地点
@property (weak, nonatomic) IBOutlet UILabel *componyLocationLabel;

///招聘人数
@property (weak, nonatomic) IBOutlet UILabel *peopleNumber;
///学历要求
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;

///性别
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;


///工作年限
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


- (void)bindModel:(SchoolRecruitmentDetailModel * )model;

@end
