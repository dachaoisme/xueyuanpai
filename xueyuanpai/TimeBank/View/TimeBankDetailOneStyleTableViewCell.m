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
    self.activityContentButton.backgroundColor = [CommonUtils colorWithHex:@"cccccc"];
    self.activityContentButton.layer.cornerRadius = 10;

    
    
    
    _payMethordLabel.layer.borderColor= [CommonUtils colorWithHex:@"00beaf"].CGColor;
    _payMethordLabel.layer.borderWidth=0.5;
    _payMethordLabel.layer.cornerRadius = 3;
    
    _payMethordLabel.textColor = [CommonUtils colorWithHex:@"00beaf"];
    
    
    _singLabel.layer.borderColor= [CommonUtils colorWithHex:@"00beaf"].CGColor;
    _singLabel.layer.borderWidth=0.5;
    _singLabel.layer.cornerRadius = 3;
    _singLabel.textColor = [CommonUtils colorWithHex:@"00beaf"];
    
    
    _moneyLabel.textColor = [CommonUtils colorWithHex:@"00beaf"];
    
    _activityContentLabel.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];


}


#pragma mark - 赴约button按钮的响应方法
- (IBAction)activityButtonAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(getActivityContentButtonStatus)]) {
        [self.delegate getActivityContentButtonStatus];
    }

}

//设置数据
- (void)bindModel:(TimeBankDetailModel *)model{
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.timeBankDetailIcon] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    
    self.nickNameLabel.text = model.timeBankDetailUserName;
    
    
    //     sex            int     非必需    性别          默认0  0不限 1男 2女
    
    if ([model.timeBankDetailSex intValue]== SexOfManType) {
        ///男
        [_sexImageView setImage:[UIImage imageNamed:@"gender_male"]];
    }else if ([model.timeBankDetailSex intValue]==SexOfWomanType){
        ///女
        [_sexImageView setImage:[UIImage imageNamed:@"gender_female"]];
    }else{
        ///保密
        [_sexImageView setImage:[UIImage imageNamed:@"timebank_icon_user"]];
    }
    
    self.activityNameLabel.text = model.timeBankDetailTitle;
    
    
    NSString *noonStr = @"";
    if ([model.timeBankDetailNoon isEqualToString:@"1"]) {
        
        noonStr = @"上午";
    }else if ([model.timeBankDetailNoon isEqualToString:@"2"]) {
        
        noonStr = @"中午";
    }else if ([model.timeBankDetailNoon isEqualToString:@"3"]){
        
        noonStr = @"下午";

    }
    self.dateLabel.text = [NSString stringWithFormat:@"%@  %@",model.timeBankDetailAppointmentTime,noonStr];
    
    self.payMethordLabel.text = model.timeBankDetailPayWay;
    
    self.singLabel.text = model.timeBankDetailTasks;
    
    self.locationLabel.text = model.timeBankDetailArea;
    
    
    self.peopleNumber.text = [NSString stringWithFormat:@"人数 %@",model.timeBankDetailNumber];
    
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",model.timeBankDetailPrice];
    
    
    self.activityContentLabel.text = model.timeBankDetailContent;
    
    
    /*
     ///申领状态 申领状态  0未申请 1 已申请 2 已通过 3过期 4完成
     @property(nonatomic,strong)NSString *timeBankDetailStat;

     */
    
    switch ([model.timeBankDetailStat intValue]) {
        case 0:{
            NSLog(@"未申请");
        }
            break;
        case 1:{
            NSLog(@"已申请");
            
            [_activityContentButton setTitle:@"您已申请赴约,请等待" forState:UIControlStateNormal];
            
            [_activityContentButton setBackgroundColor:[CommonUtils colorWithHex:@"cccccc"]];
            _activityContentButton.userInteractionEnabled = NO;
            
        }
            break;
        case 2:{
            NSLog(@"已通过");
            
            UIImage *image = [UIImage imageNamed:@"timebank_status_done"];
            
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            
            [_activityContentButton setImage:image forState:UIControlStateNormal];
            
            
            [_activityContentButton setTitle:@"已达成，请按时赴约" forState:UIControlStateNormal];

            
            
        }
            break;
        case 3:{
            NSLog(@"过期");
            
            UIImage *image = [UIImage imageNamed:@"timebank_status_time"];
            
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

            
            [_activityContentButton setImage:image forState:UIControlStateNormal];
            
            
            [_activityContentButton setTitle:@"已过期" forState:UIControlStateNormal];
            
            [_activityContentButton setBackgroundColor:[CommonUtils colorWithHex:@"cccccc"]];
            _activityContentButton.userInteractionEnabled = NO;

        }
            break;
        case 4:{
            NSLog(@"完成");
            
            UIImage *image = [UIImage imageNamed:@"timebank_status_done"];
            
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            
            [_activityContentButton setImage:image forState:UIControlStateNormal];
            
            
            [_activityContentButton setTitle:@"已满额" forState:UIControlStateNormal];
            
            [_activityContentButton setBackgroundColor:[CommonUtils colorWithHex:@"cccccc"]];
            _activityContentButton.userInteractionEnabled = NO;
        }
            break;

        default:
            break;
    }
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
