//
//  BusinessTeacherOneTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessTeacherOneTableViewCell : UITableViewCell

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

///职位
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;

///发私信按钮
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;


@end
