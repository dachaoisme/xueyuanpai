//
//  PositionInforFourTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SchoolRecruitmentModel.h"

@interface PositionInforFourTableViewCell : UITableViewCell

///联系人
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

///联系电话
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

///提醒内容
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

- (void)bindModel:(SchoolRecruitmentDetailModel * )model;


@end
