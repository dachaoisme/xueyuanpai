//
//  BusinessProjectDetailTwoTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessProjectDetailTwoTableViewCell : UITableViewCell

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

///性别
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;

///学校名称
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;

@end
