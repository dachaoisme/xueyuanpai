//
//  TimeBankDetailTwoStyleTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeBankDetailTwoStyleTableViewCell : UITableViewCell

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///昵称
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

///聊天内容
@property (weak, nonatomic) IBOutlet UILabel *contactContentLabel;

///聊天时间
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end
