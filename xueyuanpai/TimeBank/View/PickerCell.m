//
//  PickerCell.m
//  DatePicker
//
//  Created by dida on 16/3/23.
//  Copyright © 2016年 Amiee. All rights reserved.
//

#import "PickerCell.h"

@implementation PickerCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.titleLabel];
    }
    return self;
}



-(UILabel *)titleLabel
{
    if (_titleLabel)
    {
        return _titleLabel;
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    label.textColor = [UIColor blackColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont systemFontOfSize:20];
    
    _titleLabel = label;
    
    return _titleLabel;
}

@end
