//
//  BindPhoneViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BindPhoneViewController.h"

#import "BindPhoneLastViewController.h"

@interface BindPhoneViewController ()<UITextFieldDelegate>
{
    NSInteger    timerCount;
    NSTimer     *sendTimer;
    UIButton    *sendMessageBtn;
    
    CollegeModel * theCollegeModel;
    
    UITextField *coderTextField;
}
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
    sendMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendMessageBtn.frame = CGRectMake(SCREEN_WIDTH - 100, 10, 100, 20);
    [sendMessageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendMessageBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendMessageBtn setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    [sendMessageBtn addTarget:self action:@selector(sendmessage:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:sendMessageBtn];
    
    
    
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(phoneLabel.frame) + 20, 60, 20)];
    codeLabel.text = @"验证码";
    codeLabel.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:codeLabel];
    
    
    coderTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(codeLabel.frame), CGRectGetMaxY(phoneLabel.frame) + 20, 100, 20)];
    coderTextField.returnKeyType = UIReturnKeyDone;
    coderTextField.delegate = self;
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
-(void)sendmessage:(UIButton *)sender
{
    
    NSString * phoneNum = [UserAccountManager sharedInstance].userMobile;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phoneNum forKey:@"mobile"];

    [[HttpClient sharedInstance]registerOfSendMessageWithParams:params withSuccessBlock:^(HttpResponseCodeModel *model) {
        
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"发送成功"];
            //请求成功了，才改变发送按钮的倒计时
            [self startTimer];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        
    } withFaileBlock:^(NSError *error) {
        
        
    }];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - 确定按钮的响应方法
- (void)makeSureAction{
    
//    [CommonUtils showToastWithStr:@"确定"];
    
    if (coderTextField.text.length <= 0) {
        [CommonUtils showToastWithStr:@"请输入有效的验证码"];
        return;
    }

    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSString * phoneNum = [UserAccountManager sharedInstance].userMobile;
    
    [params setObject:phoneNum forKey:@"mobile"];
    [params setObject:coderTextField.text forKey:@"code"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[HttpClient sharedInstance] checkSendMessageWithParams:params withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
        if (model.responseCode == ResponseCodeSuccess) {
            
            
            //跳转输入新手机号页面
            BindPhoneLastViewController *bindPhoneLastVC = [[BindPhoneLastViewController alloc] init];
            [self.navigationController pushViewController:bindPhoneLastVC animated:YES];
            
        }else{
            
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        
        
    } withFaileBlock:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];

}


-(void)startTimer
{
    timerCount = 60;
    sendTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(countTimer:)
                                               userInfo:nil
                                                repeats:YES];
    
    sendMessageBtn.userInteractionEnabled = NO;
    [sendMessageBtn setTitle:@"60" forState:UIControlStateNormal];
}
-(void)countTimer:(NSTimer*)timer
{
    timerCount = timerCount-1;
    NSString * btnTittle = [NSString stringWithFormat:@"%lds",(long)timerCount];
    [sendMessageBtn setTitle:btnTittle forState:UIControlStateNormal];
    if (timerCount <= 0) {
        [self killTimer];
    }
}
- (void)killTimer{
    sendMessageBtn.userInteractionEnabled = YES;
    [sendMessageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    
    if(sendTimer)
    {
        [sendTimer invalidate];
        sendTimer = nil;
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
