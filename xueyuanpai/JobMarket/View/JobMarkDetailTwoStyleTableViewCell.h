//
//  JobMarkDetailTwoStyleTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/1.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JobMarketModel.h"

@protocol JobMarkDetailTwoStyleTableViewCellDelegate <NSObject>

//打电话
- (void)callAction;

//点击头像的响应事件
- (void)clickHeadImageViewAction:(id)sender;

@end

@interface JobMarkDetailTwoStyleTableViewCell : UITableViewCell

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

///性别
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

///大学
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;

///电话号码
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;


- (void)bindModel:(JobMarketDetailModel *)model;


@property (nonatomic,assign)id<JobMarkDetailTwoStyleTableViewCellDelegate>delegate;


@end
