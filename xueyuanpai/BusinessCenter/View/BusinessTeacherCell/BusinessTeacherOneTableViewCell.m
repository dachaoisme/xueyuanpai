//
//  BusinessTeacherOneTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessTeacherOneTableViewCell.h"

@implementation BusinessTeacherOneTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.sendMessageButton.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [self.sendMessageButton setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    
    self.sendMessageButton.layer.cornerRadius = 5;
}

- (IBAction)sendMessageAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(sendMessage:)]) {
        [_delegate sendMessage:sender];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
