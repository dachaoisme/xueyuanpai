//
//  RequirementTableViewCell.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RequirementTableViewCell.h"
#import "IQUIView+IQKeyboardToolbar.h"
@implementation RequirementTableViewCell


-(void)setcontentView
{
    self.inputTextField.delegate = self;
    self.inputTextField.tag = self.tag;
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(setInputContentWithContent:withTag:)]) {
        [self.delegate setInputContentWithContent:textField.text withTag:self.tag];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setcontentView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
