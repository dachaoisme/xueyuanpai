//
//  SendCourierOneTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExpressCenterModel.h"


@interface SendCourierOneTableViewCell : UITableViewCell

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

///性别
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;


///电话
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


///详情

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)bindModel: (ExpressCenterPeopleModel * )model;



@end
