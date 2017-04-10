//
//  JMHomePageThreeTypeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 17/4/10.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMHomePageThreeTypeTableViewCell : UITableViewCell

///左侧的图片
@property (nonatomic,strong)UIImageView *showImageView;

///标题
@property (nonatomic,strong)UILabel *titleLabel;

///副标题
@property (nonatomic,strong)UILabel *subtitleLabel;


///定位信息显示的btn
@property (nonatomic,strong)UIButton *locationBtn;


///正在招募的人数或者是否已经结束
@property (nonatomic,strong)UILabel *peopleNumberLabel;

@end
