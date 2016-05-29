//
//  TimeBankDetailOneStyleTableViewCell.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TimeBankDetailOneStyleTableViewCell.h"

@implementation TimeBankDetailOneStyleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    
    //设置按钮的圆角
    self.activityContentButton.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    self.activityContentButton.layer.cornerRadius = 10;

    
    
    
    _payMethordLabel.layer.borderColor= [CommonUtils colorWithHex:@"00beaf"].CGColor;
    _payMethordLabel.layer.borderWidth=0.5;
    _payMethordLabel.layer.cornerRadius = 2;
    
    _payMethordLabel.textColor = [CommonUtils colorWithHex:@"00beaf"];
    
    
    _singLabel.layer.borderColor= [CommonUtils colorWithHex:@"00beaf"].CGColor;
    _singLabel.layer.borderWidth=0.5;
    _singLabel.layer.cornerRadius = 2;
    _singLabel.textColor = [CommonUtils colorWithHex:@"00beaf"];
    
    
    

}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
