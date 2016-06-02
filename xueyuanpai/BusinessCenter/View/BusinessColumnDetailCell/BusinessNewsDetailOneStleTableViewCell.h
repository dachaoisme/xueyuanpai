//
//  BusinessNewsDetailOneStleTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/2.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessNewsDetailOneStleTableViewCell : UITableViewCell

///显示标题的label
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///显示作者的
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;


///显示时间的label
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
