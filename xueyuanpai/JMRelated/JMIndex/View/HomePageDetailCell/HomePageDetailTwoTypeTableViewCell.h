//
//  HomePageDetailTwoTypeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 17/4/11.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageDetailTwoTypeTableViewCell : UITableViewCell


///左侧显示性质的图片
@property (nonatomic,strong)UIImageView *showNatureImageView;
///左侧上方显示性质label
@property (nonatomic,strong)UILabel *showNatureTopLabel;
///左侧下方显示性质label
@property (nonatomic,strong)UILabel *showNatureBottomLabel;


///右侧显示报名时间截止的图片
@property (nonatomic,strong)UIImageView *showTimeImageView;
///右侧上方显示报名截止时间的label
@property (nonatomic,strong)UILabel *showTimeTopLabel;
///右侧下方显示报名具体日期的label
@property (nonatomic,strong)UILabel *showTimeBottomLabel;



@end
