//
//  TopUpTwoTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TopUpTwoTableViewCell.h"

@implementation TopUpTwoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - 支付方式
- (IBAction)payStatusAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(payStyleAction:)]) {
        
        [_delegate payStyleAction:sender];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
