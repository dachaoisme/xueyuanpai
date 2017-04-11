//
//  BaseTabBarView.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseTabBarView.h"

@implementation BaseTabBarView
- (id)init
{
    self = [super init];
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
    [line setBackgroundColor:[CommonUtils colorWithHex:@"c6c6c6"]];
    line.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:line];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[line(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
    
    
    
    UIView * lastView=nil;
    for (NSInteger i=0,max=_titleArr.count; i<max; i++) {
        UIImageView * icon=[UIFactory imageViewWithMode:-1 image:[_imgArr objectAtIndex:i]];
        if (!icon.image) {
            icon.image = [UIImage imageNamed:[_imgArr objectAtIndex:i]];
        }
        icon.tag=200+i;
        [self addSubview:icon];
        
        UILabel *lab = [[UILabel alloc] init];
        [lab setFont:[UIFont systemFontOfSize:12]];
        [lab setTextColor:[CommonUtils colorWithHex:@"787b7d"]];
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
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[icon(25)]" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[lab(barButton)]" options:0 metrics:nil views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[icon(25)]-2-[lab]-5-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[barButton]|" options:0 metrics:nil views:views]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:barButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0/max constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:barButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:lab attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:barButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        
        if (i==4) {
            tipView =[[UIView alloc] init];
            tipView.layer.cornerRadius=5;
            tipView.clipsToBounds=YES;
            tipView.translatesAutoresizingMaskIntoConstraints=NO;
            tipView.backgroundColor=[CommonUtils colorWithHex:@"787b7d"];
            tipView.hidden=YES;
            [self addSubview:tipView];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[tipView(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tipView)]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tipView(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tipView)]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:tipView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:icon attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:tipView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:icon attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        }
        
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
                lab.textColor=[CommonUtils colorWithHex:@"787b7d"];
            }
        }
    }
    selIndex=index;
    UIImageView * icon=(UIImageView*)[self viewWithTag:index+200];
    icon.image=[UIImage imageNamed:[_imgSelArr objectAtIndex:selIndex]];
    UILabel * lab=(UILabel*)[self viewWithTag:10+selIndex];
    lab.textColor=[CommonUtils colorWithHex:@"00c05c"];
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
