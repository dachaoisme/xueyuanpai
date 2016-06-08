//
//  BusinessCenterOneStyleTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/9.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessCenterOneStyleTableViewCell.h"

@implementation BusinessCenterOneStyleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
      
        [self setContentView];
    }
    
    return self;
}

-(void)setContentView
{
    
    UIView * view = [UIFactory viewWithFrame:self.bounds backgroundColor:@"ffffff"];
    [self addSubview:view];
    
    UILabel * titileLable = [[UILabel alloc] init];
    titileLable.frame = CGRectMake(15, 16, 80, 17);

    titileLable.font = [UIFont systemFontOfSize:14];
    titileLable.text = @"积分商城";
    [view addSubview:titileLable];
    self.titleLabel = titileLable;
    
    
    UIButton * button = [UIFactory button:nil sel:nil titleColor:@"999999" title:@"查看全部" fontSize:12 frame:CGRectMake(CGRectGetWidth(self.frame)-95, 0, 80,  50)];
    button.userInteractionEnabled = NO;
    [button setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    float length = [CommonUtils getTextSizeWithText:@"查看全部" WithFont:12 WithTextheight:17].width;
    UIImage * arrowImg = [UIImage imageNamed:@"arrow"];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -arrowImg.size.width, 0, 3)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, length+20 , 0, 0)];
    [view addSubview:button];
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
