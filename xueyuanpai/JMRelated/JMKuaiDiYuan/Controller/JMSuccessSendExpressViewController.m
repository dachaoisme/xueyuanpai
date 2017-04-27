//
//  JMSuccessSendExpressViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/27.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSuccessSendExpressViewController.h"

@interface JMSuccessSendExpressViewController ()

@end

@implementation JMSuccessSendExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下单成功";
    [self createLeftBackNavBtn];
    [self setupContentView];
}
-(void)setupContentView
{
    UILabel *titelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 25)];
    titelLabel.textColor = [CommonUtils colorWithHex:@"00c05c"];
    titelLabel.font = [UIFont systemFontOfSize:19];
    titelLabel.textAlignment = NSTextAlignmentCenter;
    titelLabel.text = @"下单成功";
    [self.view addSubview:titelLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titelLabel.frame), SCREEN_WIDTH-30, 40)];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.numberOfLines = 2;
    contentLabel.textColor = [CommonUtils colorWithHex:@"666666"];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.text = [NSString stringWithFormat:@"订单编号%@，请在24小时内去站点寄快递",self.orderId];
    [self.view addSubview:contentLabel];
    
    
    //确定按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, CGRectGetMaxY(contentLabel.frame) + 20, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(makeSureAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
}
-(void)makeSureAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
