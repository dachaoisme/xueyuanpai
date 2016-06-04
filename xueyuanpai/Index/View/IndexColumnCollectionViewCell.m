//
//  IndexColumnCollectionViewCell.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "IndexColumnCollectionViewCell.h"

@implementation IndexColumnCollectionViewCell


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
    UIImageView * columnImageView = [UIFactory imageView:CGRectMake(0, 0, 45, 45) viewMode:UIViewContentModeScaleAspectFill image:nil];
    [self addSubview:columnImageView];
    self.columnImageView = columnImageView;
    
    UILabel * columnTitileLable = [UIFactory label:10*3 color:@"999999" align:NSTextAlignmentCenter];
    columnTitileLable.frame = CGRectMake(0, CGRectGetMaxY(columnImageView.frame), CGRectGetWidth(columnImageView.frame), 15) ;
    [self addSubview:columnTitileLable];
    self.columnTitileLable = columnTitileLable;
    
}

- (void)layoutSubviews{
    
    
    
}

-(void)setContentViewWithModel:(IndexColumnsModel *)model
{
    
    if ([model.indexColumnsId intValue] == 1) {
        
        [self.columnImageView sd_setImageWithURL:[NSURL URLWithString:model.indexColumnsPicUrl] placeholderImage:[UIImage imageNamed:@"home_icon_community"]];
    }else if ([model.indexColumnsId intValue] == 2) {
        
        [self.columnImageView sd_setImageWithURL:[NSURL URLWithString:model.indexColumnsPicUrl] placeholderImage:[UIImage imageNamed:@"home_icon_timebank"]];
    }else if ([model.indexColumnsId intValue] == 3) {
        
        [self.columnImageView sd_setImageWithURL:[NSURL URLWithString:model.indexColumnsPicUrl] placeholderImage:[UIImage imageNamed:@"home_icon_market"]];
    }else if ([model.indexColumnsId intValue] == 4) {
        
        [self.columnImageView sd_setImageWithURL:[NSURL URLWithString:model.indexColumnsPicUrl] placeholderImage:[UIImage imageNamed:@"home_icon_recruit"]];
    }



    self.columnTitileLable.text = model.indexColumnsName;
}
@end
