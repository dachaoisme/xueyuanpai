//
//  BusinessCenterTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/2.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessCenterTableViewCell.h"

@implementation BusinessCenterTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.titleLabel.frame = CGRectMake(123, 15, SCREEN_WIDTH - 123 -10, 40);
    
    self.contentLabel.frame = CGRectMake(123, 65, SCREEN_WIDTH - 123 -10, 40);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
