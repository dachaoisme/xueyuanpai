//
//  HotActivityTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/21.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotActivityModel;
@interface HotActivityTableViewCell : UITableViewCell

//显示详情的lable
@property (nonatomic,strong)UILabel *detailLabel;


- (void)bindModel:(HotActivityModel *)model;

@end
