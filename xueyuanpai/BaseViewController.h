//
//  BaseViewController.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseViewController : UIViewController

{
    //BaseNavView * _nav;
    UIView *contentView;
    
    
}
-(float)setNaveBarHeight;
-(UIView*)createContentView;

- (void)theTabBarHidden:(BOOL)hidden;   // 隐藏或显示 tabBar

///左侧返回按钮
- (void)createLeftBackNavBtn;
///左侧返回按钮事件
- (void)doNavEventBack:(id)sender;

///自定义左侧按钮，如首页左侧的“我的”按钮
-(void)creatLeftNavWithTitle:(NSString *)title;
-(void)creatLeftNavWithImageName:(NSString *)imageName;
-(void)leftItemActionWithBtn:(UIButton *)sender;

///自定义右侧按钮，如“分享”等按钮
-(void)creatRightNavWithTitle:(NSString *)title;
-(void)creatRightNavWithImageName:(NSString *)imageName;
-(void)rightItemActionWithBtn:(UIButton *)sender;
@end
