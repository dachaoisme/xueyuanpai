//
//  TimeBankDetailThreeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/4.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeBankModel.h"

@interface TimeBankDetailThreeTableViewCell : UITableViewCell

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

///内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

///时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;






- (void)bindModel:(TimeBankCommentModel *)model;

@end
