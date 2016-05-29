//
//  TimeBankDetailTwoStyleTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TimeBankDetailTwoStyleTableViewCell.h"

@implementation TimeBankDetailTwoStyleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    //设置imageView的圆角
    self.headImageView.layer.cornerRadius = 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
