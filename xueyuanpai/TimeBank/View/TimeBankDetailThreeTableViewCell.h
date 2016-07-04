//
//  TimeBankDetailThreeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/4.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeBankModel.h"

@protocol TimeBankDetailThreeTableViewCellDelegate <NSObject>

- (void)replyCommentAction:(id)sender;

@end

@interface TimeBankDetailThreeTableViewCell : UITableViewCell

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

///内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

///时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

///回复按钮
@property (weak, nonatomic) IBOutlet UIButton *replyButton;


@property (nonatomic,assign)id<TimeBankDetailThreeTableViewCellDelegate>delegate;

- (void)bindModel:(TimeBankCommentModel *)model;

@end
