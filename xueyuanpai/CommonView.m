//
//  CommonView.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/27.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "CommonView.h"

@implementation CommonView


+(void)emptyViewWithView:(UIView *)backGroundView
{
    ///@3x
    UIImage *image = [UIImage imageNamed:@"public_empty"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT,image.size.width , image.size.height)];
    imageView.image = image;
    imageView.center = backGroundView.center;
    [backGroundView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), SCREEN_WIDTH, 20)];
    label.text = @"暂时没有信息";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [CommonUtils colorWithHex:NORMAL_SUBTITLE_BLACK_COLOR];
    [backGroundView addSubview:label];
    
}


@end
