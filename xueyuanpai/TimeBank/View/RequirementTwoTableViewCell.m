//
//  RequirementTwoTableViewCell.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RequirementTwoTableViewCell.h"

@implementation RequirementTwoTableViewCell


#pragma mark - 请选择按钮的响应方法
- (IBAction)selectAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectedContentWithwithTag: withBtn:)]) {
        [self.delegate selectedContentWithwithTag:self.tag withBtn:sender];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
