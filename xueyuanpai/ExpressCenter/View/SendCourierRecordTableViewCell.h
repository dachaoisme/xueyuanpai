//
//  SendCourierRecordTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExpressCenterModel.h"


@protocol SendCourierRecordTableViewCellDelegate <NSObject>

//店电话
- (void)call;

//取消取件
- (void)cancleTakeThing;

@end

@interface SendCourierRecordTableViewCell : UITableViewCell
///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
///详情
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

///时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

///取件地址
@property (weak, nonatomic) IBOutlet UILabel *takeAdress;

///取件时间
@property (weak, nonatomic) IBOutlet UILabel *takeTime;


///取件状态
@property (weak, nonatomic) IBOutlet UILabel *takeStatues;

///取消取件按钮显示
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;


@property (nonatomic,assign)id<SendCourierRecordTableViewCellDelegate>delegate;


- (void)bindModel:(ExpressCenterExpressInfoModel *)model;

@end
