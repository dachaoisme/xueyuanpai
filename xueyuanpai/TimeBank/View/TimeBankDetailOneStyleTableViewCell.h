//
//  TimeBankDetailOneStyleTableViewCell.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeBankDetailOneStyleTableViewCell : UITableViewCell

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///昵称
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

///性别的图片
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

///活动名称
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;

///约定时间
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

///付款方式
@property (weak, nonatomic) IBOutlet UILabel *payMethordLabel;

///唱歌，跳舞等活动
@property (weak, nonatomic) IBOutlet UILabel *singLabel;


///地点
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;


///人数
@property (weak, nonatomic) IBOutlet UILabel *peopleNumber;


///具体活动内容
@property (weak, nonatomic) IBOutlet UILabel *activityContentLabel;



///赴约按钮

@property (weak, nonatomic) IBOutlet UIButton *activityContentButton;


@end
