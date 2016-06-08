//
//  BusinessPublishProjectTwoTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessPublishProjectTwoTableViewCell.h"

@implementation BusinessPublishProjectTwoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.contentLabel.textColor = [CommonUtils colorWithHex:@"c7c6cb"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
