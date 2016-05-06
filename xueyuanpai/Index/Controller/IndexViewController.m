//
//  IndexViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "IndexViewController.h"
#import "MineViewController.h"
@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    [self setTitle:@"首页"];
    [self creatLeftNavWithImageName:@"v_uc_act"];
    [self creatRightNavWithImageName:@"v_uc_act"];
    
}
-(void)leftItemActionWithBtn:(UIButton *)sender
{
    //弹出我的界面
    MineViewController * mineVC = [[MineViewController alloc]init];
    [self.navigationController pushViewController:mineVC animated:YES];
}

-(void)rightItemActionWithBtn:(UIButton *)sender
{
    //收件箱界面
    [CommonUtils showToastWithStr:@"收件箱"];
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
