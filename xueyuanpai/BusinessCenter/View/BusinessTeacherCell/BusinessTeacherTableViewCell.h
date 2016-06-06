//
//  BusinessTeacherTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessTeacherTableViewCell : UITableViewCell

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

///职位
@property (weak, nonatomic) IBOutlet UILabel *jobNameLabel;

///擅长领域
@property (weak, nonatomic) IBOutlet UILabel *goodAtLabel;






@end
