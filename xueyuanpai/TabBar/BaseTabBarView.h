//
//  BaseTabBarView.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTabBarDelegate <NSObject>

-(void)tabBarSelected:(NSInteger)index;

@end

@interface BaseTabBarView : UIView
{
    NSInteger selIndex;
    UIView * tipView;
}
@property(nonatomic,assign)id<BaseTabBarDelegate> delegate;

@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)NSArray * imgArr;
@property(nonatomic,strong)NSArray * imgSelArr;

-(void)setContentView;
-(void)setSelected:(NSInteger)index;
@end
