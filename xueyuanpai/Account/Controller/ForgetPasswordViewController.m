//
//  ForgetPasswordViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/23.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordOfSetNewPasswordViewController.h"
@interface ForgetPasswordViewController ()<UITextFieldDelegate>
{
    UITextField *phoneTextField;
    UIButton    *sendMessageBtn;
    UITextField *checkingMessageTextField;
    UIButton    *sureBtn;
    
    NSInteger     timerCount;
    NSTimer     *sendTimer;
    
}
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"忘记密码"];
    [self createLeftBackNavBtn];
    self.view.backgroundColor = [CommonUtils colorWithHex:@"e5e5e5"];
    [self setContentView];
}
-(void)setContentView
{
    float space = 16;
    float width = SCREEN_WIDTH -2*space;
    float height = 48;
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, space+NAV_TOP_HEIGHT, SCREEN_WIDTH, height*2)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    //请输入手机号
    phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, 0, width, height)];
    phoneTextField.tag = 2;
    phoneTextField.delegate = self;
    [phoneTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    phoneTextField.textAlignment = NSTextAlignmentLeft;
    phoneTextField.borderStyle   = UITextBorderStyleNone;
    phoneTextField.font = [UIFont systemFontOfSize:14];
    phoneTextField.placeholder   = @"请输入手机号";
    //myTextField.clearsOnBeginEditing = YES;//设置为YES当用点触文本字段时，字段内容会被清除
    phoneTextField.adjustsFontSizeToFitWidth = YES;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.leftViewMode    = UITextFieldViewModeAlways;
    phoneTextField.rightViewMode   = UITextFieldViewModeAlways;
    [backgroundView addSubview:phoneTextField];
    
    sendMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendMessageBtn.layer.cornerRadius = 3.0;
    [sendMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendMessageBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [sendMessageBtn setFrame:CGRectMake(0, 0, 80, 30)];
    [sendMessageBtn setContentMode:UIViewContentModeCenter];
    [sendMessageBtn addTarget:self action:@selector(sendmessage:) forControlEvents:UIControlEventTouchUpInside];
    sendMessageBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [sendMessageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    phoneTextField.rightView = sendMessageBtn;
 
    //请输入验证码
    checkingMessageTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, CGRectGetMaxY(phoneTextField.frame), width, height)];
    checkingMessageTextField.tag = 2;
    checkingMessageTextField.delegate = self;
    [checkingMessageTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    checkingMessageTextField.font = [UIFont systemFontOfSize:14];
    checkingMessageTextField.textAlignment = NSTextAlignmentLeft;
    checkingMessageTextField.borderStyle = UITextBorderStyleNone;
    checkingMessageTextField.placeholder = @"请输入验证码";
    checkingMessageTextField.adjustsFontSizeToFitWidth = YES;
    checkingMessageTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backgroundView addSubview:checkingMessageTextField];
    
    
    float lineHeight = 0.5;
    [UIFactory showLineInView:backgroundView color:@"c7c6cb" rect:CGRectMake(space, CGRectGetMaxY(phoneTextField.frame), width+space,lineHeight)];
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 10;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [sureBtn setFrame:CGRectMake(space, CGRectGetMaxY(backgroundView.frame)+space, width, height)];
    [sureBtn setContentMode:UIViewContentModeCenter];
    [sureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:sureBtn];
}

-(void)sendmessage:(UIButton *)sender
{
    
    NSString * phoneNum = phoneTextField.text;
    if (!(phoneNum.length==11 && [CommonUtils checkPhoneNumIsAvailableWithPhoneNumString:phoneNum])) {
        [CommonUtils showToastWithStr:@"请输入有效手机号"];
        return;
    }
    
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

-(void)sure:(UIButton *)sender
{
    //验证码和手机号验证成功
    if (phoneTextField.text.length<=0 || [CommonUtils checkPhoneNumIsAvailableWithPhoneNumString:phoneTextField.text]!=true) {
        [CommonUtils showToastWithStr:@"请输入有效手机号"];
        return;
    }
    if (checkingMessageTextField.text.length<=0 ||![CommonUtils checkIsNum:checkingMessageTextField.text]) {
        [CommonUtils showToastWithStr:@"请输入有效验证码"];
        return;
    }
    /*
     mobile  string    必需    手机号码
     captcha   string    必需    验证码
     
     */
    //校验验证码
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneTextField.text forKey:@"mobile"];
    [dic setObject:checkingMessageTextField.text forKey:@"captcha"];
    [[HttpClient sharedInstance]validateTelephoneAndSecurityCodeWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            NSString * userId = [model.responseCommonDic objectForKey:@"user_id"];
            //验证码和手机号验证成功
            ForgetPasswordOfSetNewPasswordViewController * forgetPasswordOfSetNewPasswordVC = [[ForgetPasswordOfSetNewPasswordViewController alloc] init];
            forgetPasswordOfSetNewPasswordVC.userId = userId;
            forgetPasswordOfSetNewPasswordVC.telephoneNum = phoneTextField.text;
            [self.navigationController pushViewController:forgetPasswordOfSetNewPasswordVC animated:YES];
            
        }else{
            //验证失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
    
}
#pragma mark - 倒计时相关
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
