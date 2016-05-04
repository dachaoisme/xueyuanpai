//
//  UIFactory.m
//  MFTour
//
//  Created by lidachao on 15/12/1.
//  Copyright © 2015年 lidachao. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

+(UILabel *)label:(CGRect)frame size:(float)size color:(NSString *)color align:(int)align{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setFont:[UIFont systemFontOfSize:size]];
    [lab setTextColor:[CommonUtils colorWithHex:color]];
    [lab setNumberOfLines:0];
    if (align > 0)[lab setTextAlignment:align];
    return lab;
}

+(UILabel *)borderLabel:(CGRect)frame size:(float)size color:(NSString *)color align:(int)align{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setFont:[UIFont boldSystemFontOfSize:size]];
    [lab setTextColor:[CommonUtils colorWithHex:color]];
    [lab setNumberOfLines:0];
    if (align > 0)[lab setTextAlignment:align];
    return lab;
}
+(UILabel *)italicLabel:(CGRect)frame size:(float)size color:(NSString *)color align:(int)align{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    [lab setBackgroundColor:[UIColor clearColor]];
    [lab setFont:[UIFont italicSystemFontOfSize:size]];
    [lab setTextColor:[CommonUtils colorWithHex:color]];
    [lab setNumberOfLines:0];
    if (align > 0)[lab setTextAlignment:align];
    return lab;
}
+(UILabel *)normalLabel:(CGRect)frame size:(float)size color:(UIColor *)color align:(int)align backColor:(UIColor*)backColor
{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    [lab setFont:[UIFont italicSystemFontOfSize:size]];
    [lab setTextColor:color];
    [lab setBackgroundColor:backColor];
    [lab setNumberOfLines:0];
    if (align > 0)[lab setTextAlignment:align];
    return lab;
}

+(UIImageView *)imageView:(CGRect)frame viewMode:(int)mode image:(NSString *)image{
    UIImageView *iv = [[UIImageView alloc] initWithFrame:frame];
    if(mode != -1)[iv setContentMode:mode];
    if(image)[iv setImage:[UIImage imageNamed:image]];
    return iv;
}

+(UIImageView *)scaleImageView:(CGRect)frame viewMode:(int)mode image:(NSString *)image edge:(UIEdgeInsets)insets{
    UIImageView *iv = [[UIImageView alloc] initWithFrame:frame];
    if(mode != -1)[iv setContentMode:mode];
    
    if(image){
        UIImage *img = [UIImage imageNamed:image];
        UIImage *nimg = [img resizableImageWithCapInsets:insets];
        [iv setImage:nimg];
    };
    return iv;
}

+(UITableView *)table:(CGRect)frame style:(int)style deleteAndDataScource:(id)t_delegate{
    
    UITableView *table = [[UITableView alloc] initWithFrame:frame style:style];
    [table setDataSource:t_delegate];
    [table setDelegate:t_delegate];
    return table;
}

+(UIButton *)scaledButton:(NSString *)norImg sel:(NSString *)selImg title:(NSString *)title fontSize:(float)size frame:(CGRect)frame edge:(UIEdgeInsets)insets{
    UIImage *img = [UIImage imageNamed:norImg];
    UIImage *nimg = [img resizableImageWithCapInsets:insets];
    UIImage *imgh = [UIImage imageNamed:selImg];
    UIImage *nimgh = [imgh resizableImageWithCapInsets:insets];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:nimg forState:UIControlStateNormal];
    [btn setBackgroundImage:nimgh forState:UIControlStateHighlighted];
    if (title)[btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:size]];
    [btn setFrame:frame];
    return btn;
}
+(UIButton *)button:(NSString *)normalImg sel:(NSString *)selectImg titleColor:(NSString *)titleColor title:(NSString *)title fontSize:(float)size frame:(CGRect)frame {
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImg] forState:UIControlStateHighlighted];
    [btn setTitleColor:[CommonUtils colorWithHex:titleColor] forState:UIControlStateNormal];
    if (title)[btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:size]];
    [btn setFrame:frame];
    return btn;
}

+(void)showLineInView:(UIView *)view color:(NSString *)color rect:(CGRect)r
{
    UIView *v = [[UIView alloc] initWithFrame:r];
    [v setBackgroundColor:[CommonUtils colorWithHex:color]];
    [view addSubview:v];
}
+(UIView *)viewWithFrame:(CGRect)rect backgroundColor:(NSString *)color
{
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[CommonUtils colorWithHex:color]];
    return view;
    
}
@end
