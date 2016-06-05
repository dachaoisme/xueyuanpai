//
//  BusinessCenterOneStyleTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessCenterOneStyleTableViewCell.h"

@implementation BusinessCenterOneStyleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    
    _searchAllButton.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
