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
    UIImageView * columnImageView = [UIFactory imageView:CGRectMake(0, 0, 40, 40) viewMode:UIViewContentModeScaleAspectFill image:nil];
    columnImageView.backgroundColor = [UIColor redColor];
    [self addSubview:columnImageView];
    self.columnImageView = columnImageView;
    
    UILabel * columnTitileLable = [UIFactory label:14 color:@"999999" align:NSTextAlignmentCenter];
    columnTitileLable.frame = CGRectMake(0, CGRectGetMaxY(columnImageView.frame), CGRectGetWidth(columnImageView.frame), 15) ;
    [self addSubview:columnTitileLable];
    self.columnTitileLable = columnTitileLable;
    
}
-(void)setContentViewWithModel:(IndexColumnsModel *)model
{
    [self.columnImageView sd_setImageWithURL:[NSURL URLWithString:[CommonUtils getEffectiveUrlWithUrl:model.indexColumnsPicUrl]]];
    self.columnTitileLable.text = model.indexColumnsName;
}
@end
