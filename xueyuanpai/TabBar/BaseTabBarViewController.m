//
//  BaseTabBarViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "JMKuaiDiYuanViewController.h"
#import "JMHomePageViewController.h"
#import "JMMineViewController.h"
#import "LoginViewController.h"
@interface BaseTabBarViewController ()
{
    JMKuaiDiYuanViewController *kuaiDiVC;
    JMHomePageViewController *homePageVC;
    JMMineViewController *mineVC;
}
@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.hidden = YES;
    kuaiDiVC = [[JMKuaiDiYuanViewController alloc] init];
    UINavigationController * kuaiDiNavVC=[[UINavigationController alloc] initWithRootViewController:kuaiDiVC];
    
    homePageVC = [[JMHomePageViewController alloc] init];
    UINavigationController * homePageNavVC=[[UINavigationController alloc] initWithRootViewController:homePageVC];
    
    mineVC = [[JMMineViewController alloc] init];
    UINavigationController *mineNavVC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    [self setViewControllers:[NSArray arrayWithObjects:
                              kuaiDiNavVC,
                              homePageNavVC,
                              mineNavVC,
                              nil]];
    
    _baseTabBarView=[[BaseTabBarView alloc] init];
    _baseTabBarView.frame =CGRectMake(0, SCREEN_HEIGHT-49-21, SCREEN_WIDTH, 49+21);
    _baseTabBarView.backgroundColor = [UIColor clearColor];
    _baseTabBarView.delegate=self;
    _baseTabBarView.titleArr=[[NSArray alloc] initWithObjects:
                       @"我的快递",
                       @"集梦盒子",
                       @"个人中心",
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
//    UIImage * image = [UIImage imageNamed:@"tab_bg_round"];
//    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, 0, 50, 21)];
//    imageView.image = image;
//    [_baseTabBarView addSubview:imageView];
    
    [_baseTabBarView setContentView];
    [_baseTabBarView setSelected:0];
    
   
    
    
//    if ([UserAccountManager sharedInstance].userId.length<=0) {
//        LoginViewController * loginVC = [[LoginViewController alloc]init];
//        [homePageVC.navigationController pushViewController:loginVC animated:NO];
//    }
    
}
-(void)stateBarHidden
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
-(void)tabBarShow
{
    _baseTabBarView.hidden=NO;
    if (_baseTabBarView.frame.origin.x!=0 || _baseTabBarView.frame.origin.y!=self.view.bounds.size.height-49-21) {
        [UIView animateWithDuration:0 animations:^{
            _baseTabBarView.frame=CGRectMake(0, self.view.bounds.size.height-49-21, SCREEN_WIDTH, 49+21);
        }];
    }
}
-(void)tabBarHiddenToBottom:(BOOL)toBottom
{
    if (_baseTabBarView.frame.origin.x==0 && _baseTabBarView.frame.origin.y==self.view.bounds.size.height-49-21) {
        [UIView animateWithDuration:0 animations:^{
            if (toBottom) {
                _baseTabBarView.frame=CGRectMake(0, self.view.bounds.size.height, SCREEN_WIDTH, 49+21);
            }else
                _baseTabBarView.frame=CGRectMake(-SCREEN_WIDTH, self.view.bounds.size.height-49-21, SCREEN_WIDTH, 49+21);
        }completion:^(BOOL finished){
            if (finished) {
                _baseTabBarView.hidden=YES;
            }
        }];
    }
}

-(void)tabBarSelected:(NSInteger)index
{

    if ([UserAccountManager sharedInstance].isLogin==NO &&index==2) {
        if (self.selectedIndex==0) {
            LoginViewController * loginVC = [[LoginViewController alloc]init];
            [kuaiDiVC.navigationController pushViewController:loginVC  animated:YES];
        }else if (self.selectedIndex==1){
            LoginViewController * loginVC = [[LoginViewController alloc]init];
            [homePageVC.navigationController pushViewController:loginVC  animated:YES];
        }else{
            
        }
    }else{
        self.selectedIndex=index;
        [_baseTabBarView setSelected:index];
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        app.navController=(UINavigationController*)self.selectedViewController;
    }
    
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
