//
//  SelectSchoolViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/9.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SelectSchoolViewController.h"

@interface SelectSchoolViewController ()

@end

@implementation SelectSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择学校";
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
