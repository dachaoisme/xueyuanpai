//
//  IndexMallCollectionViewCell.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "IndexMallCollectionViewCell.h"

@implementation IndexMallCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setContentView];
    }
    return self;
}

-(void)setContentView
{
    UIImageView * mallImageView = [UIFactory imageView:CGRectMake(0, 0, 40, 40) viewMode:UIViewContentModeScaleAspectFill image:nil];
    mallImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:mallImageView];
    self.mallImageView = mallImageView;
    
    UILabel * mallTitileLable = [UIFactory label:14 color:@"999999" align:NSTextAlignmentCenter];
    mallTitileLable.frame = CGRectMake(0, CGRectGetMaxY(mallImageView.frame), CGRectGetWidth(mallImageView.frame), 15) ;
    [self addSubview:mallTitileLable];
    self.mallTitileLable = mallTitileLable;
    
    UILabel * mallIntegralTitileLable = [UIFactory label:14 color:@"999999" align:NSTextAlignmentCenter];
    mallIntegralTitileLable.frame = CGRectMake(0, CGRectGetMaxY(mallTitileLable.frame), CGRectGetWidth(mallTitileLable.frame), 15) ;
    [self addSubview:mallIntegralTitileLable];
    self.mallIntegralTitileLable = mallIntegralTitileLable;
    
}
-(void)setContentViewWithModel:(IndexMallModel *)model
{
    [self.mallImageView sd_setImageWithURL:[NSURL URLWithString:[CommonUtils getEffectiveUrlWithUrl:model.indexMallThumbUrl]]];
    self.mallTitileLable.text = model.indexMallTitle;
    self.mallIntegralTitileLable.text = [NSString stringWithFormat:@"%@积分",model.indexMallPoints];
}

@end
