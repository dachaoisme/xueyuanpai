//
//  JMCourseDetailTwoTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMCourseDetailTwoTableViewCell : UITableViewCell

///定位信息
@property (nonatomic,strong)UIButton *locationBtn;


///标题
@property (nonatomic,strong)UILabel *titleLabel;


///内容
@property (nonatomic,strong)UILabel *contentLabel;

///课程时间
@property (nonatomic,strong)UILabel *courseTimeLabel;

///位置显示
@property (nonatomic,strong)UILabel *showLocationLabel;

@end
