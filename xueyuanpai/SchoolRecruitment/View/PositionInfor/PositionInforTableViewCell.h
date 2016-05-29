//
//  PositionInforTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SchoolRecruitmentModel.h"

@interface PositionInforTableViewCell : UITableViewCell

///市场推广人员
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///更新时间
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;


- (void)bindModel:(SchoolRecruitmentDetailModel * )model;

@end
