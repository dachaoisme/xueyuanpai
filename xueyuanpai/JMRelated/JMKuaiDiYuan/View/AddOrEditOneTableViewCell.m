//
//  AddOrEditOneTableViewCell.m
//  KLRecreationFamily
//
//  Created by 王园园 on 16/7/26.
//  Copyright © 2016年 Wangyuanyuan. All rights reserved.
//

#import "AddOrEditOneTableViewCell.h"

@implementation AddOrEditOneTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.rightInputContentTextField.delegate = self;
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
