//
//  TimeBankTableViewCell.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TimeBankTableViewCell.h"
#import "UIImage+ChangeImageColor.h"

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
    
    [_timeBankImageView sd_setImageWithURL:[NSURL URLWithString:model.timeBankIcon] placeholderImage:[UIImage imageNamed:@"placeHoder.png"]];
    _timeBankTitleLable.text     = model.timeBankTitle;
    _timeBankTimeLable.text      = model.timeBankAppointmentTime;
    
    
    _timeBankCategoryLable.text  = model.timeBankPayway;
   
    
    _timeBankAdressLable.text    = model.timeBankArea;
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[model.timeBankBrief dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    _timeBankDetailLable.attributedText = attrStr;
//    _timeBankDetailLable.text    = model.timeBankBrief;
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
        
        UIImage *image = [[UIImage imageNamed:@"disable_tag"] imageWithTintColor:[CommonUtils colorWithHex:@"00beaf"]];
        
        [_timeBankStateBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyApply){
        [_timeBankStateBtn setTitle:@"已申请" forState:UIControlStateNormal];
         [_timeBankStateBtn setBackgroundImage:[UIImage imageNamed:@"disable_tag"] forState:UIControlStateNormal];
        [_timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyPass){
        [_timeBankStateBtn setTitle:@"已通过" forState:UIControlStateNormal];
        
        UIImage *image = [[UIImage imageNamed:@"disable_tag"] imageWithTintColor:[CommonUtils colorWithHex:@"00beaf"]];
        
        [_timeBankStateBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyOverdue){
        [_timeBankStateBtn setTitle:@"已过期" forState:UIControlStateNormal];
        [_timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyComplete){
        [_timeBankStateBtn setTitle:@"已完成" forState:UIControlStateNormal];
        
        UIImage *image = [[UIImage imageNamed:@"disable_tag"] imageWithTintColor:[CommonUtils colorWithHex:@"00beaf"]];
        
        [_timeBankStateBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_timeBankStateBtn setHidden:NO];
    }else{
        [_timeBankStateBtn setHidden:YES];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _timeBankCategoryLable.layer.borderColor= [CommonUtils colorWithHex:@"00beaf"].CGColor;
    _timeBankCategoryLable.layer.borderWidth=0.5;
    _timeBankCategoryLable.layer.cornerRadius = 2;
    
    _timeBankCategoryLable.textColor = [CommonUtils colorWithHex:@"00beaf"];
    
    
    _timeBankPaywayLabel.layer.borderColor= [CommonUtils colorWithHex:@"00beaf"].CGColor;
    
    _timeBankPaywayLabel.layer.borderWidth=0.5;
    _timeBankPaywayLabel.layer.cornerRadius = 3;
     _timeBankPaywayLabel.textColor = [CommonUtils colorWithHex:@"00beaf"];
    
    
    _timeBankPriceLable.textColor = [CommonUtils colorWithHex:@"00beaf"];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
