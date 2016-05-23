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
    UIImageView * mallImageView = [UIFactory imageView:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-40) viewMode:UIViewContentModeScaleAspectFill image:nil];
    [self addSubview:mallImageView];
    self.mallImageView = mallImageView;
    
    UILabel * mallTitileLable = [UIFactory label:12*3 color:@"999999" align:NSTextAlignmentLeft];
    mallTitileLable.frame = CGRectMake(0, CGRectGetMaxY(mallImageView.frame), CGRectGetWidth(mallImageView.frame), 20) ;
    [self addSubview:mallTitileLable];
    self.mallTitileLable = mallTitileLable;
    
    UILabel * mallIntegralTitileLable = [UIFactory label:12*3 color:@"999999" align:NSTextAlignmentLeft];
    mallIntegralTitileLable.frame = CGRectMake(0, CGRectGetMaxY(mallTitileLable.frame), CGRectGetWidth(mallTitileLable.frame), 20) ;
    [self addSubview:mallIntegralTitileLable];
    self.mallIntegralTitileLable = mallIntegralTitileLable;
    
}
-(void)setContentViewWithModel:(IndexMallModel *)model
{
    [self.mallImageView sd_setImageWithURL:[NSURL URLWithString:model.indexMallThumbUrl] placeholderImage:[UIImage imageNamed:@"test.jpg"]];//[NSURL URLWithString:@"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg"]];
    self.mallTitileLable.text = model.indexMallTitle;
    self.mallIntegralTitileLable.text = [NSString stringWithFormat:@"%@积分",model.indexMallPoints];
}

@end
