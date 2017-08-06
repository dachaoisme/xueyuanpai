//
//  JMBaoMingStatusTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/8/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMBaoMingStatusTableViewCell : UITableViewCell

///圆圈
@property (nonatomic,strong)UIImageView *quanImageView;

///竖线
@property (nonatomic,strong)UIView *lineView;


///日期
@property (nonatomic,strong)UILabel *dateLabel;


///内容显示
@property (nonatomic,strong)UILabel *statusLabel;

@end
