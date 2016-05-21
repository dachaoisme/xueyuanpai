//
//  BaseTabBarViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BusinessCenterViewController.h"
#import "ExpressCenterViewController.h"
#import "IndexViewController.h"
@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.hidden = YES;
    IndexViewController *IndexVC = [[IndexViewController alloc] init];
    UINavigationController * IndexNavVC=[[UINavigationController alloc] initWithRootViewController:IndexVC];
    
    BusinessCenterViewController *BusinessCenterVC = [[BusinessCenterViewController alloc] init];
    UINavigationController * BusinessCenterNavVC=[[UINavigationController alloc] initWithRootViewController:BusinessCenterVC];
    
    ExpressCenterViewController *ExpressCenterVC = [[ExpressCenterViewController alloc] init];
    UINavigationController *ExpressCenterNavVC = [[UINavigationController alloc] initWithRootViewController:ExpressCenterVC];
    
    [self setViewControllers:[NSArray arrayWithObjects:
                              IndexNavVC,
                              BusinessCenterNavVC,
                              ExpressCenterNavVC,
                              nil]];
    
    _baseTabBarView=[[BaseTabBarView alloc] init];
    _baseTabBarView.frame=CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
    _baseTabBarView.delegate=self;
    _baseTabBarView.titleArr=[[NSArray alloc] initWithObjects:
                       @"首页",
                       @"创业中心",
                       @"我的快递",
                       nil];
    _baseTabBarView.imgArr=[[NSArray alloc] initWithObjects:
                     @"tab_icon_home",
                     @"tab_icon_creativity",
                     @"tab_icon_package",
                     nil];
    _baseTabBarView.imgSelArr=[[NSArray alloc] initWithObjects:
                        @"tab_icon_home_hl",
                        @"tab_icon_creativity",
                        @"tab_icon_package_hl",
                        nil];
    
    [self.view addSubview:_baseTabBarView];
    [_baseTabBarView setContentView];
    [_baseTabBarView setSelected:0];
    
}
-(void)stateBarHidden
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
-(void)tabBarShow
{
    _baseTabBarView.hidden=NO;
    if (_baseTabBarView.frame.origin.x!=0 || _baseTabBarView.frame.origin.y!=self.view.bounds.size.height-49) {
        [UIView animateWithDuration:0.25 animations:^{
            _baseTabBarView.frame=CGRectMake(0, self.view.bounds.size.height-49, SCREEN_WIDTH, 49);
        }];
    }
}
-(void)tabBarHiddenToBottom:(BOOL)toBottom
{
    if (_baseTabBarView.frame.origin.x==0 && _baseTabBarView.frame.origin.y==self.view.bounds.size.height-49) {
        [UIView animateWithDuration:0.3 animations:^{
            if (toBottom) {
                _baseTabBarView.frame=CGRectMake(0, self.view.bounds.size.height, SCREEN_WIDTH, 49);
            }else
                _baseTabBarView.frame=CGRectMake(-SCREEN_WIDTH, self.view.bounds.size.height-49, SCREEN_WIDTH, 49);
        }completion:^(BOOL finished){
            if (finished) {
                _baseTabBarView.hidden=YES;
            }
        }];
    }
}

-(void)tabBarSelected:(NSInteger)index
{

    self.selectedIndex=index;
    [_baseTabBarView setSelected:index];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.navController=(UINavigationController*)self.selectedViewController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
