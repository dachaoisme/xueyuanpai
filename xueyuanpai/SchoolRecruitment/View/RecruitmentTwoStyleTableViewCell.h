//
//  RecruitmentTwoStyleTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SchoolRecruitmentModel.h"

@interface RecruitmentTwoStyleTableViewCell : UITableViewCell

///职位描述
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

///职位详情介绍
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


- (void)bindModel:(SchoolRecruitmentDetailModel *)model;

@end
