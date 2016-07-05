//
//  BusinessProjectDetailTwoTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessProjectDetailTwoTableViewCell.h"

@implementation BusinessProjectDetailTwoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.sendMessageButton.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [self.sendMessageButton setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    
    self.sendMessageButton.layer.cornerRadius = 5;
}


- (IBAction)sendMessageAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(sendChatMessage:)]) {
        [self.delegate sendChatMessage:sender];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
