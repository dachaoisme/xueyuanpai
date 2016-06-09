//
//  MineOneStyleTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MineOneStyleTableViewCell.h"

@implementation MineOneStyleTableViewCell

//初始化cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //创建视图
        [self createView];
        
    }
    
    return self;
    
    
}

#pragma mark - 创建视图
- (void)createView{
    
    
    //创建左侧背景视图
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2-1, 60)];
    leftView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:leftView];
    
    //创建中间的竖线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) + 1, 0, 1, 60)];
    lineView.backgroundColor = [CommonUtils colorWithHex:@"cccccc"];
    [self.contentView addSubview:lineView];
    
    //创建右侧视图
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame), 0, SCREEN_WIDTH/2, 60)];
    rightView.backgroundColor = [UIColor whiteColor];

    [self.contentView addSubview:rightView];
    
    
    
    //创建左侧视图的两个label
    UILabel *myWalletLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(leftView.frame) / 2 - 30, 11, 60, 14)];
    myWalletLabel.font = [UIFont systemFontOfSize:14];
    myWalletLabel.text = @"我的钱包";
    [leftView addSubview:myWalletLabel];
    
    
    //创建金额的label
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(myWalletLabel.frame), CGRectGetMaxY(myWalletLabel.frame)+10, CGRectGetWidth(myWalletLabel.frame), CGRectGetHeight(myWalletLabel.frame))];
    _moneyLabel.font = [UIFont systemFontOfSize:16];
    _moneyLabel.text = @"￥0";
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    _moneyLabel.textColor = [CommonUtils colorWithHex:@"00beaf"];
    [leftView addSubview:_moneyLabel];
    
    
    //创建右侧视图的两个label
    UILabel *jifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(rightView.frame) / 2 - 30, 11, 60, 14)];
    jifenLabel.font = [UIFont systemFontOfSize:14];
    jifenLabel.text = @"我的积分";
    [rightView addSubview:jifenLabel];
    
    
    _integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(jifenLabel.frame), CGRectGetMaxY(jifenLabel.frame)+10, CGRectGetWidth(jifenLabel.frame), CGRectGetHeight(jifenLabel.frame))];
    _integralLabel.font = [UIFont systemFontOfSize:16];
    _integralLabel.text = @"0";
    _integralLabel.textAlignment = NSTextAlignmentCenter;

    _integralLabel.textColor = [CommonUtils colorWithHex:@"00beaf"];
    [rightView addSubview:_integralLabel];
    
    
    //给左侧和右侧视图添加tap手势
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapAction:)];
    
    leftTap.delegate = self;
    [leftView addGestureRecognizer:leftTap];
    
    
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapAction:)];
    
    rightTap.delegate = self;
    [rightView addGestureRecognizer:rightTap];
}

#pragma mark - 左侧视图的响应方法
-(void) leftTapAction:(UITapGestureRecognizer*) tap {
   
    if ([_delegate respondsToSelector:@selector(leftAction)]) {
        [_delegate leftAction];
    }
    
}

#pragma mark - 右侧视图响应的方法
-(void) rightTapAction:(UITapGestureRecognizer*) tap {
    
    
    if ([_delegate respondsToSelector:@selector(rightAction)]) {
        [_delegate rightAction];
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
