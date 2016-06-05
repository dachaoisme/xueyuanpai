//
//  BusinessCenterTwoStyleTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCenterTwoStyleTableViewCell : UITableViewCell


///背景视图
@property (weak, nonatomic) IBOutlet UIView *backGroundView;

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

///介绍
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;


- (void)bindArray:(NSMutableArray *)array;


@end
