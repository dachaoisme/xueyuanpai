//
//  HomePageDetailOneTypeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 17/4/11.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageDetailOneTypeTableViewCell : UITableViewCell

///标题
@property (nonatomic,strong)UILabel *titleLabel;

///定位信息
@property (nonatomic,strong)UIButton *locationBtn;


///显示发表时间的label
@property (nonatomic,strong)UILabel *timeLabel;

@end
