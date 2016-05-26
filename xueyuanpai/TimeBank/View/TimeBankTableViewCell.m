//
//  TimeBankTableViewCell.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/26.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TimeBankTableViewCell.h"

@interface TimeBankTableViewCell ()

{
    UIImageView   *timeBankImageView;
    UILabel       *timeBankTitleLable;
    UILabel       *timeBankTimeLable;
    UILabel       *timeBankCategoryLable;
    UILabel       *timeBankAdressLable;
    UILabel       *timeBankDetailLable;
    UILabel       *timeBankNickNameLable;
    UIImageView   *timeBankSexImageView;
    UIButton      *timeBankStateBtn;
    UILabel       *timeBankPriceLable;
}

@end

@implementation TimeBankTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setContentView];
    }
    return self;
}
-(void)setContentView
{
    
    float space = 16;
    float totalHeight = 120;//CGRectGetHeight(self.frame);
    float imageHeight = totalHeight - space*2;
    float titleHeight = imageHeight/4;
    
    float imageWeight = imageHeight;
    float rightWidth  = 2*space;
    float centerWidth = SCREEN_WIDTH-space*2 -space -imageWeight-rightWidth;
    
    
    ///缩略图
    timeBankImageView = [UIFactory imageView:CGRectMake(0, 0, imageHeight, imageHeight) viewMode:UIViewContentModeScaleAspectFill image:nil];
    [self.contentView addSubview:timeBankImageView];
    
    ///标题
    timeBankTitleLable = [UIFactory label:10*3 color:@"999999" align:NSTextAlignmentCenter];
    timeBankTitleLable.frame = CGRectMake(CGRectGetMaxX(timeBankImageView.frame), CGRectGetMinY(timeBankImageView.frame), centerWidth, titleHeight) ;
    [self.contentView addSubview:timeBankTitleLable];
    ///过期状态
    timeBankStateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [timeBankStateBtn setFrame:CGRectMake(CGRectGetMaxX(timeBankTitleLable.frame), CGRectGetMinY(timeBankTitleLable.frame), rightWidth, titleHeight)];
    [timeBankStateBtn setHidden:YES];
    [timeBankStateBtn setBackgroundImage:[UIImage imageNamed:@"disable_tag"] forState:UIControlStateNormal];
    [self.contentView addSubview:timeBankStateBtn];
    
    ///时间
    timeBankTimeLable = [UIFactory label:10*3 color:@"999999" align:NSTextAlignmentCenter];
    timeBankTimeLable.frame = CGRectMake(CGRectGetMaxX(timeBankImageView.frame), CGRectGetMaxY(timeBankTitleLable.frame), centerWidth/2, titleHeight) ;
    [self.contentView addSubview:timeBankTimeLable];
    ///类别，时间右面的 运动、唱歌等类别
    timeBankCategoryLable = [UIFactory label:10*3 color:@"999999" align:NSTextAlignmentCenter];
    timeBankCategoryLable.frame = CGRectMake(CGRectGetMaxX(timeBankTimeLable.frame), CGRectGetMinY(timeBankTimeLable.frame), centerWidth/2, titleHeight) ;
    [self.contentView addSubview:timeBankCategoryLable];
    //价格
    timeBankPriceLable = [UIFactory label:10*3 color:@"999999" align:NSTextAlignmentCenter];
    timeBankPriceLable.frame = CGRectMake(CGRectGetMaxX(timeBankCategoryLable.frame), CGRectGetMinY(timeBankTimeLable.frame), rightWidth, titleHeight) ;
    [self.contentView addSubview:timeBankPriceLable];
    
    ///地点
    timeBankAdressLable = [UIFactory label:10*3 color:@"999999" align:NSTextAlignmentCenter];
    timeBankAdressLable.frame = CGRectMake(CGRectGetMaxX(timeBankImageView.frame), CGRectGetMaxY(timeBankTimeLable.frame), centerWidth, titleHeight) ;
    [self.contentView addSubview:timeBankAdressLable];
    ///详情
    timeBankDetailLable = [UIFactory label:10*3 color:@"999999" align:NSTextAlignmentCenter];
    timeBankDetailLable.frame = CGRectMake(CGRectGetMaxX(timeBankImageView.frame), CGRectGetMaxY(timeBankAdressLable.frame), centerWidth, titleHeight) ;
    [self.contentView addSubview:timeBankDetailLable];
    ///昵称
    timeBankNickNameLable = [UIFactory label:10*3 color:@"999999" align:NSTextAlignmentCenter];
    timeBankNickNameLable.frame = CGRectMake(0, CGRectGetMaxY(timeBankImageView.frame), imageWeight/2, space) ;
    [self.contentView addSubview:timeBankNickNameLable];
    ///性别
    timeBankSexImageView = [UIFactory imageView:CGRectMake(CGRectGetMaxX(timeBankNickNameLable.frame), CGRectGetMinY(timeBankNickNameLable.frame), imageWeight/2, space) viewMode:UIViewContentModeScaleAspectFill image:nil];
    [self.contentView addSubview:timeBankSexImageView];
    
}
-(void)setContentViewWithModel:(TimeBankModel *)model
{
    [timeBankImageView sd_setImageWithURL:[NSURL URLWithString:model.timeBankIcon] placeholderImage:[UIImage imageNamed:@"timebank_icon_user"]];
    timeBankTitleLable.text     = model.timeBankTitle;
    timeBankTimeLable.text      = model.timeBankAppointmentTime;
    timeBankCategoryLable.text  = model.timeBankPayway;
    timeBankAdressLable.text    = model.timeBankArea;
    timeBankDetailLable.text    = model.timeBankBrief;
    timeBankNickNameLable.text  = model.timeBankUsername;
    if ([model.timeBankSex intValue]== SexOfManType) {
        ///男
        [timeBankSexImageView setImage:[UIImage imageNamed:@"gender_male"]];
    }else if ([model.timeBankSex intValue]==SexOfWomanType){
        ///女
        [timeBankSexImageView setImage:[UIImage imageNamed:@"gender_female"]];
    }else{
        ///保密
        [timeBankSexImageView setImage:[UIImage imageNamed:@"timebank_icon_user"]];
    }
    
    if ([model.timeBankStat intValue]== TimeBankStateUnApply) {
        [timeBankStateBtn setTitle:@"未申请" forState:UIControlStateNormal];
        [timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyApply){
        [timeBankStateBtn setTitle:@"已申请" forState:UIControlStateNormal];
        [timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyPass){
        [timeBankStateBtn setTitle:@"已通过" forState:UIControlStateNormal];
        [timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyOverdue){
        [timeBankStateBtn setTitle:@"已过期" forState:UIControlStateNormal];
        [timeBankStateBtn setHidden:NO];
    }else if ([model.timeBankStat intValue]== TimeBankStateAlreadyComplete){
        [timeBankStateBtn setTitle:@"已完成" forState:UIControlStateNormal];
        [timeBankStateBtn setHidden:NO];
    }else{
        [timeBankStateBtn setHidden:YES];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
