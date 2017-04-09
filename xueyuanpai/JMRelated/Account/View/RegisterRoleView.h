//
//  RegisterRoleView.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/11.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterRoleViewDelegate <NSObject>

-(void)registerRoleWithType:(RegisterRoleType )registerRoleType;

@end

@interface RegisterRoleView : UIView

{
    UIButton *personalAccountBtn;
    UIButton *teacherAccountBtn;
    UIControl * control;
}

@property(nonatomic,strong)id<RegisterRoleViewDelegate>delegate;

-(id)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView;
@end
