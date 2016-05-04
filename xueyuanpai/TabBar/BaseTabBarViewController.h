//
//  BaseTabBarViewController.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarView.h"
@interface BaseTabBarViewController : UITabBarController<BaseTabBarDelegate>

-(void)tabBarShow;
-(void)tabBarHiddenToBottom:(BOOL)toBottom;
-(void)tabBarSelected:(NSInteger)index;
-(void)beatyImgShow;

@property(nonatomic,assign)BOOL isLoaded;
@property(nonatomic,strong)BaseTabBarView *baseTabBarView;



@end
