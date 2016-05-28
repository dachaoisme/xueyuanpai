//
//  TimeBankTableViewCell.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TimeBankTableViewCell.h"

@interface TimeBankTableViewCell ()

///缩略图
@property (weak, nonatomic) IBOutlet UIImageView *timeBankImageView;

///昵称
@property (weak, nonatomic) IBOutlet UILabel *timeBankNickNameLable;

///性别
@property (weak, nonatomic) IBOutlet UIImageView *timeBankSexImageView;

///标题
@property (weak, nonatomic) IBOutlet UILabel *timeBankTitleLable;

///时间
@property (weak, nonatomic) IBOutlet UILabel *timeBankTimeLable;

///地点
@property (weak, nonatomic) IBOutlet UILabel *timeBankAdressLable;

///详情
@property (weak, nonatomic) IBOutlet UILabel *timeBankDetailLable;


///唱歌运动类型
@property (weak, nonatomic) IBOutlet UILabel *timeBankCategoryLable;

///支付AA制
@property (weak, nonatomic) IBOutlet UILabel *timeBankPaywayLabel;

///过期状态
@property (weak, nonatomic) IBOutlet UIButton *timeBankStateBtn;


///价格

@property (weak, nonatomic) IBOutlet UILabel *timeBankPriceLable;



@end

@implementation TimeBankTableViewCell

-(void)setContentViewWithModel:(TimeBankModel *)model
{
    
    [_timeBankImageView sd_setImageWithURL:[NSURL URLWithString:model.timeBankIcon] placeholderImage:[UIImage imageNamed:@"timebank_icon_user"]];
    _timeBankTitleLable.text     = model.timeBankTitle;
    _timeBankTimeLable.text      = model.timeBankAppointmentTime;
    
    
    _timeBankCategoryLable.text  = model.timeBankPayway;
//    _timeBankCategoryLable.layer.borderColor=[UIColor redColor].CGColor;
//    _timeBankCategoryLable.layer.borderWidth=0.5;
    
    
    _timeBankAdressLable.text    = model.timeBankArea;
    _timeBankDetailLable.text    = model.timeBankBrief;
    _timeBankNickNameLable.text  = model.timeBankUsername;
    if ([model.timeBankSex intValue]== SexOfManType) {
        ///男
        [_timeBankSexImageView setImage:[UIImage imageNamed:@"gender_male"]];
    }else if ([model.timeBankSex intValue]==SexOfWomanType){
        ///女
        [_timeBankSexImageView setImage:[UIImage imageNamed:@"gender_female"]];
    }else{
        ///保密
        [_timeBankSexImageView setImage:[UIImage imageNamed:@"timebank_icon_user"]];
    }
    
    if ([model.timeBankStat intValue]== TimeBankStateUnApply) {
        [_timeBankStateBtn setTitle:@"未申请" forState:UIControlStateNormal];
        [_timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyApply){
        [_timeBankStateBtn setTitle:@"已申请" forState:UIControlStateNormal];
        [_timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyPass){
        [_timeBankStateBtn setTitle:@"已通过" forState:UIControlStateNormal];
        [_timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyOverdue){
        [_timeBankStateBtn setTitle:@"已过期" forState:UIControlStateNormal];
        [_timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyComplete){
        [_timeBankStateBtn setTitle:@"已完成" forState:UIControlStateNormal];
        [_timeBankStateBtn setHidden:NO];
    }else{
        [_timeBankStateBtn setHidden:YES];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
