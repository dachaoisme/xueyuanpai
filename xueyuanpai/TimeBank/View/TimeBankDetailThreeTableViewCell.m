//
//  TimeBankDetailThreeTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/4.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TimeBankDetailThreeTableViewCell.h"



@implementation TimeBankDetailThreeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)bindModel:(TimeBankCommentModel *)model{
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.timeBankCommentIcon] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    
    
    self.nameLabel.text = model.timeBankCommentUserName;
    
    self.contentLabel.text = model.timeBankCommentContent;
    
    self.timeLabel.text = model.timeBankCommentCreateTime;
    
    
}



- (IBAction)replyAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(replyCommentAction:)]) {
        
        [_delegate replyCommentAction:sender];
    }
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
