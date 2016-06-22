//
//  BaseTabBarView.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseTabBarView.h"

@implementation BaseTabBarView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[CommonUtils colorWithHex:@"f7f7f7"];
        self.clipsToBounds=YES;
        
        
    }
    return self;
}
-(void)setContentView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTipState) name:NOTI_BADGE_CHANGE object:nil];
    
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:[CommonUtils colorWithHex:@"fafafa"]];
    line.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:line];
    line.layer.borderWidth = 0.5;
    line.layer.borderColor = [CommonUtils colorWithHex:@"c2c3c4"].CGColor;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-21-[line(49)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
    
    
    
    UIView * lastView=nil;
    for (NSInteger i=0,max=_titleArr.count; i<max; i++) {
        
        if (i==1) {
            UIImage * image = [UIImage imageNamed:@"tab_bg_round"];
            
            UIImageView * courierImageVIew=[[UIImageView alloc] init];
            courierImageVIew.image = image;
            courierImageVIew.translatesAutoresizingMaskIntoConstraints=NO;
            [self addSubview:courierImageVIew];
            float space = (CGRectGetWidth(self.frame)-50)/2;
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"|-(%f)-[courierImageVIew(50)]|",space] options:0 metrics:nil views:NSDictionaryOfVariableBindings(courierImageVIew)]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[courierImageVIew(22)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(courierImageVIew)]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:courierImageVIew attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        }
        
        
        UIImageView * icon=[UIFactory imageViewWithMode:-1 image:[_imgArr objectAtIndex:i]];
        if (!icon.image) {
            icon.image = [UIImage imageNamed:[_imgArr objectAtIndex:i]];
        }
        icon.tag=200+i;
        [self addSubview:icon];
        
        UILabel *lab = [[UILabel alloc] init];
        [lab setFont:[UIFont systemFontOfSize:12]];
        [lab setTextColor:[CommonUtils colorWithHex:@"5a5e60"]];
        lab.translatesAutoresizingMaskIntoConstraints=NO;
        lab.textAlignment=NSTextAlignmentCenter;
        lab.text=[_titleArr objectAtIndex:i];
        lab.tag=10+i;
        [self addSubview:lab];
        
        UIButton * barButton=[UIButton buttonWithType:UIButtonTypeCustom];
        barButton.tag=i;
        barButton.translatesAutoresizingMaskIntoConstraints=NO;
        [barButton addTarget:self action:@selector(buttonOnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:barButton];
        
        NSDictionary * views=nil;
        if (lastView) {
            views=NSDictionaryOfVariableBindings(icon,lab,barButton,lastView);
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[lastView][barButton]" options:0 metrics:nil views:views]];
        }else{
            views=NSDictionaryOfVariableBindings(icon,lab,barButton);
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[barButton]" options:0 metrics:nil views:views]];
        }
        
        
        if (i==1) {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[icon(38)]" options:0 metrics:nil views:views]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[lab(barButton)]" options:0 metrics:nil views:views]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[icon(38)]-9-[lab]-5-|" options:0 metrics:nil views:views]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[barButton]|" options:0 metrics:nil views:views]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:barButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0/max constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:barButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:lab attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:barButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        }else{
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[icon(25)]" options:0 metrics:nil views:views]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[lab(barButton)]" options:0 metrics:nil views:views]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-26-[icon(25)]-2-[lab]-5-|" options:0 metrics:nil views:views]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[barButton]|" options:0 metrics:nil views:views]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:barButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0/max constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:barButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:lab attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:barButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        }
        
        
//        if (i==4) {
//            tipView =[[UIView alloc] init];
//            tipView.layer.cornerRadius=5;
//            tipView.clipsToBounds=YES;
//            tipView.translatesAutoresizingMaskIntoConstraints=NO;
//            tipView.backgroundColor=[CommonUtils colorWithHex:@"ff4861"];
//            tipView.hidden=YES;
//            [self addSubview:tipView];
//            
//            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[tipView(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tipView)]];
//            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tipView(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tipView)]];
//            [self addConstraint:[NSLayoutConstraint constraintWithItem:tipView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:icon attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
//            [self addConstraint:[NSLayoutConstraint constraintWithItem:tipView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:icon attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
//        }
        
        lastView=barButton;
        selIndex=-1;
    }
    [self setTipState];
}
-(void)buttonOnclick:(UIButton*)sender
{
    if (selIndex!=sender.tag) {
        if (_delegate) {
            [_delegate tabBarSelected:sender.tag];
        }
    }
}
-(void)setSelected:(NSInteger)index
{
    if (selIndex>=0) {
        for (NSInteger i=0,max=_titleArr.count; i<max; i++) {
            if (i!=index) {
                UIImageView * icon=(UIImageView*)[self viewWithTag:i+200];
                icon.image=[UIImage imageNamed:[_imgArr objectAtIndex:i]];
                UILabel * lab=(UILabel*)[self viewWithTag:10+i];
                lab.textColor=[CommonUtils colorWithHex:@"c2c3c4"];
            }
        }
    }
    selIndex=index;
    UIImageView * icon=(UIImageView*)[self viewWithTag:index+200];
    icon.image=[UIImage imageNamed:[_imgSelArr objectAtIndex:selIndex]];
    UILabel * lab=(UILabel*)[self viewWithTag:10+selIndex];
    lab.textColor=[CommonUtils colorWithHex:@"00beaf"];
}
-(void)setTipState
{
    //    NSInteger number=[UIApplication sharedApplication].applicationIconBadgeNumber;
    //    tipView.hidden=(number==0);
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
