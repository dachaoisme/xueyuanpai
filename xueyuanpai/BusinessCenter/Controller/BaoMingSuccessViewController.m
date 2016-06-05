//
//  BaoMingSuccessViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaoMingSuccessViewController.h"


#import "BusinessClassDetailViewController.h"

@interface BaoMingSuccessViewController ()

@end

@implementation BaoMingSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:nil];
    
    
    self.title = @"报名成功";
    
}


#pragma mark - 返回讲堂详情
- (IBAction)popClassDetailAction:(id)sender {
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[BusinessClassDetailViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    

    
}

#pragma mark - 分享好友
- (IBAction)shareAction:(id)sender {


    [CommonUtils showToastWithStr:@"分享好友"];
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
