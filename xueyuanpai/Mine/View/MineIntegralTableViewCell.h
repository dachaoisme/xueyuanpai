//
//  MineIntegralTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineIntegralTableViewCell : UITableViewCell

///标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///时间
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

///积分
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;


@end
