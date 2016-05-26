//
//  SchoolColumnView.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/24.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SchoolColumnView.h"

@implementation SchoolColumnView

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
-(void)setContentViewWithModel:(IndexColumnsModel *)model
{
    [self.columnImageView sd_setImageWithURL:[NSURL URLWithString:model.indexColumnsPicUrl]];
    self.columnTitileLable.text = model.indexColumnsName;
}

@end
