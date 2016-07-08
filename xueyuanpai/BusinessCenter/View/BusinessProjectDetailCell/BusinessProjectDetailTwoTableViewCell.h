//
//  BusinessProjectDetailTwoTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  BusinessProjectDetailTwoTableViewCellDelegate <NSObject>

- (void)sendChatMessage:(id)sender;

//点击头像的响应事件
- (void)clickHeadImageViewAction:(id)sender;

@end

@interface BusinessProjectDetailTwoTableViewCell : UITableViewCell

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

///性别
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;

///学校名称
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;

///发送消息按钮
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;


@property (strong,nonatomic)id<BusinessProjectDetailTwoTableViewCellDelegate>delegate;

@end
