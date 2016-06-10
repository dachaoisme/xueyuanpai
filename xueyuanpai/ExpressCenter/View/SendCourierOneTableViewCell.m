//
//  SendCourierOneTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SendCourierOneTableViewCell.h"

@implementation SendCourierOneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - 打电话
- (IBAction)callAction:(id)sender {
    
    /**/
}

- (void)bindModel: (ExpressCenterPeopleModel * )model{
        
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.ExpressCenterPeopleImg] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    
    _nameLabel.text = model.ExpressCenterPeopleRealName;
    
    _phoneLabel.text = model.ExpressCenterPeopleMobile;
    
    _contentLabel.text = model.ExpressCenterPeopleGrade;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
