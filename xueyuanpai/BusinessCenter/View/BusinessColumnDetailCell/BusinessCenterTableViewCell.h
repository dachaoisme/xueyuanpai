//
//  BusinessCenterTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/2.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCenterTableViewCell : UITableViewCell
///展示图片的
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

///展示标题的label
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///展示详情的label
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;





@end
