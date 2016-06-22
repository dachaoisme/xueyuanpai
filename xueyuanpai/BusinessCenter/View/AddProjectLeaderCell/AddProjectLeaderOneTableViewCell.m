//
//  AddProjectLeaderOneTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/9.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AddProjectLeaderOneTableViewCell.h"

@implementation AddProjectLeaderOneTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.inputContentTextField.delegate = self;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.tag==0) {
        //姓名
        self.publicProgectModel.businessCenterPublicProgectRealName = textField.text;
    }else if (self.tag==1){
        //身份证
        self.publicProgectModel.businessCenterPublicProgectIdentityCard = textField.text;
    }else if (self.tag==2){
        //联系电话
        self.publicProgectModel.businessCenterPublicProgectTelephone = textField.text;
    }else if (self.tag ==3){
        //专业
        self.publicProgectModel.businessCenterPublicProgectMajor = textField.text;
    }else{
        
    }
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
