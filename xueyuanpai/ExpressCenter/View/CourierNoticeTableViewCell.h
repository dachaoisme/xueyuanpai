//
//  CourierNoticeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourierNoticeTableViewCell : UITableViewCell
///左侧图片
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;


///显示内容
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

///时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;



@end
