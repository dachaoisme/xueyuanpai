//
//  BindPhoneViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BindPhoneViewController.h"

@interface BindPhoneViewController ()

@end

@implementation BindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    self.title = @"修改手机绑定";
    
    [self createLeftBackNavBtn];
    
    [self bindPhoneView];
}

#pragma mark - 创建绑定视图
- (void)bindPhoneView{
    
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT + 10, SCREEN_WIDTH, 97)];
    
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGroundView];
    
    
    UILabel *bindLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 20)];
    bindLabel.text = @"已绑定";
    bindLabel.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:bindLabel];
    
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bindLabel.frame), 10, 100, 20)];
    phoneLabel.text = [UserAccountManager sharedInstance].userMobile;
    phoneLabel.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:phoneLabel];
    
    
    //发送验证码
    UIButton *sendMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendMessageButton.frame = CGRectMake(SCREEN_WIDTH - 100, 10, 100, 20);
    [sendMessageButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [sendMessageButton setFont:[UIFont systemFontOfSize:14]];
    [sendMessageButton setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    [sendMessageButton addTarget:self action:@selector(sendMessageAction) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:sendMessageButton];
    
    
    
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(phoneLabel.frame) + 20, 60, 20)];
    codeLabel.text = @"验证码";
    codeLabel.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:codeLabel];
    
    
    UITextField *coderTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(codeLabel.frame), CGRectGetMaxY(phoneLabel.frame) + 20, 100, 20)];
    coderTextField.placeholder = @"请输入";
    coderTextField.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:coderTextField];


    
    //确定按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, CGRectGetMaxY(backGroundView.frame) + 10, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(makeSureAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button];

    
}

#pragma mark - 发送验证码
- (void)sendMessageAction{
    
    [CommonUtils showToastWithStr:@"发送短信验证码"];
}

#pragma mark - 确定按钮的响应方法
- (void)makeSureAction{
    
    [CommonUtils showToastWithStr:@"确定"];
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
