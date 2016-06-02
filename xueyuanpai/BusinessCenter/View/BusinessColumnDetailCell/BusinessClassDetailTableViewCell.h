//
//  BusinessClassDetailTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/2.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessClassDetailTableViewCell : UITableViewCell

///时间的label
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

///地点的label
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

///详情内容的label
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;



///详情图片的展示
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;

@end
