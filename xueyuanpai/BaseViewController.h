//
//  BaseViewController.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavView.h"
@interface BaseViewController : UIViewController

{
    BaseNavView * _nav;
    UIView *contentView;
    
    
}
-(float)setNaveBarHeight;
-(UIView*)createContentView;

- (void)theTabBarHidden:(BOOL)hidden;   // 隐藏或显示 tabBar



@end
