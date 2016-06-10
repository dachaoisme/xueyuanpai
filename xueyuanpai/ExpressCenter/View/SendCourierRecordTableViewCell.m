//
//  SendCourierRecordTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SendCourierRecordTableViewCell.h"

@implementation SendCourierRecordTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)bindModel:(ExpressCenterExpressInfoModel *)model{
    
    self.nameLabel.text = model.expressCenterExpressInfoExpressPeopleName;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[CommonUtils getEffectiveUrlWithUrl:model.expressCenterExpressInfoExpressPeopleImg withType:1]] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    
    self.timeLabel.text = model.expressCenterExpressInfoCreateTime;
    
    self.takeAdress.text = model.expressCenterExpressInfoAdress;
    
    self.takeTime.text = model.expressCenterExpressInfoFetchTime;
    
    
    if ([model.expressCenterExpressInfoStatus intValue] == -1) {
        
        //取消取件
        self.takeStatues.text = @"已取消取件";
        self.cancleButton.hidden = YES;
        
    }else if ([model.expressCenterExpressInfoStatus intValue] == 0){
        
        //等待取件
        self.takeStatues.text = @"等待取件";
        
        
    }else if([model.expressCenterExpressInfoStatus intValue] == 1){
        
        //已取件
        
        self.takeStatues.text = [NSString stringWithFormat:@"已于%@取件",model.expressCenterExpressInfoDetailCreateTime];
        self.cancleButton.hidden = YES;
        
    }
    
}

#pragma mark - 拨打电话
- (IBAction)callButtonAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(call)]) {
        [_delegate call];
    }
}

#pragma mark - 取消取件按钮
- (IBAction)cancleButtonAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(cancleTakeThing)]) {
        [_delegate cancleTakeThing];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
