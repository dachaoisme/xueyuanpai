//
//  OnSiteMessageListViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/7/1.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "OnSiteMessageListViewController.h"

@interface OnSiteMessageListViewController ()

@end

@implementation OnSiteMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"站内消息";
    
    [self createLeftBackNavBtn];

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