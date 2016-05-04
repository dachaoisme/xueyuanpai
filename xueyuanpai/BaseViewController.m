//
//  BaseViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabBarViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"\n\nThe Last ViewController is == %@\n\n",NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LLColorBg;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    float navHt=64.0;
    if ([self respondsToSelector:@selector(setNaveBarHeight)]) {
        navHt=[self setNaveBarHeight];
    }
    
    if (navHt>0) {
        _nav=[[BaseNavView alloc] initWithTitle:@"" color:@"f7f7f7"];
        [self.view addSubview:_nav];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_nav]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nav)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[_nav(%f)]",navHt] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nav)]];
    }
    
    contentView=[[UIView alloc] init];
    contentView.translatesAutoresizingMaskIntoConstraints=NO;
    if (_nav) {
        [self.view insertSubview:contentView belowSubview:_nav];
    }else {
        [self.view addSubview:contentView];
    }
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(%f)-[contentView]|",navHt] options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)]];
}
-(UIView*)createContentView //创建背景视图
{
    UIView * view=[[UIView alloc] init];
    view.backgroundColor=[UIColor whiteColor];
    view.translatesAutoresizingMaskIntoConstraints=NO;
    view.clipsToBounds=YES;
    
    UIView * line1=[[UIView alloc] init];
    line1.backgroundColor=[CommonUtils colorWithHex:@"d4d4d4"];
    line1.translatesAutoresizingMaskIntoConstraints=NO;
    [view addSubview:line1];
    
    UIView * line2=[[UIView alloc] init];
    line2.backgroundColor=[CommonUtils colorWithHex:@"d4d4d4"];
    line2.translatesAutoresizingMaskIntoConstraints=NO;
    [view addSubview:line2];
    
    NSDictionary * views=NSDictionaryOfVariableBindings(line1,line2);
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line1]|" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line2]|" options:0 metrics:nil views:views]];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[line1(0.5)]" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line2(0.5)]|" options:0 metrics:nil views:views]];
    
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --orientations
-(float)setNaveBarHeight{
    return 64.0f;
}

- (void)theTabBarHidden:(BOOL)hidden {
    
    if (hidden) {
        UITabBarController *tabBar = self.tabBarController;
        BaseTabBarViewController *vc = (BaseTabBarViewController *)tabBar;
        [vc tabBarHiddenToBottom:NO];
            
    } else {
        UITabBarController *tabBar = self.tabBarController;
        BaseTabBarViewController *vc = (BaseTabBarViewController *)tabBar;
        [vc tabBarShow];
            
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
