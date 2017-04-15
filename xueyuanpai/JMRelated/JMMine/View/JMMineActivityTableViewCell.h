//
//  JMMineActivityTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/14.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMMineActivityTableViewCell : UITableViewCell

//第几期的label
@property (nonatomic,strong)UILabel *periodLabel;


///标题
@property (nonatomic,strong)UILabel *titleLabel;


///副标题
@property (nonatomic,strong)UILabel *subtitleLabel;


///时间
@property (nonatomic,strong)UILabel *dateLabel;


///定位信息
@property (nonatomic,strong)UIButton *locationBtn;

@end
