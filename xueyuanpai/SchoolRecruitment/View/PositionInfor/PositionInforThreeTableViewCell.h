//
//  PositionInforThreeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SchoolRecruitmentModel.h"


@interface PositionInforThreeTableViewCell : UITableViewCell

///职位描述详情
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;



- (void)bindModel:(SchoolRecruitmentDetailModel * )model;
@end
