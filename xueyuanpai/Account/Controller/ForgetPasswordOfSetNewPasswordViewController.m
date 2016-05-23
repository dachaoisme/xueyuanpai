//
//  ForgetPasswordOfSetNewPasswordViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/23.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ForgetPasswordOfSetNewPasswordViewController.h"

@interface ForgetPasswordOfSetNewPasswordViewController ()<UITextFieldDelegate>
{
    UITextField *inputPasswordTextField;
    UIButton    *sureBtn;
}
@end

@implementation ForgetPasswordOfSetNewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createLeftBackNavBtn];
    self.view.backgroundColor = [CommonUtils colorWithHex:@"e5e5e5"];
    [self setContentView];
    
    
}
-(void)setContentView
{
    float space = 16;
    float width = SCREEN_WIDTH -2*space;
    float height = 48;
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, space+NAV_TOP_HEIGHT, SCREEN_WIDTH, height)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    //请输入密码
    inputPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, 0, width, height)];
    inputPasswordTextField.tag = 2;
    inputPasswordTextField.delegate = self;
    [inputPasswordTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    inputPasswordTextField.textAlignment = NSTextAlignmentLeft;
    inputPasswordTextField.borderStyle = UITextBorderStyleNone;
    inputPasswordTextField.placeholder = @"请设置新密码";
    inputPasswordTextField.adjustsFontSizeToFitWidth = YES;
    inputPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backgroundView addSubview:inputPasswordTextField];
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 3.0;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [sureBtn setFrame:CGRectMake(space, CGRectGetMaxY(backgroundView.frame)+space, width, height)];
    [sureBtn setContentMode:UIViewContentModeCenter];
    [sureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:sureBtn];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)sure:(UIButton *)sender
{
    if (inputPasswordTextField.text.length<=0 ) {
        [CommonUtils showToastWithStr:@"密码不能为空"];
        return;
    }
    /*
     user_id int    必需    用户序号
     passwd   string    必需    新密码
     */
    //校验验证码
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.userId forKey:@"user_id"];
    [dic setObject:inputPasswordTextField.text forKey:@"passwd"];
    [[HttpClient sharedInstance]changePasswordWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            NSString * userId = [[model.responseCommonDic objectForKey:@"data"] objectForKey:@"user_id"];
            //若成功，应该是返回主页面，并且是已经登录状态
            [[UserAccountManager sharedInstance]saveUserAccountWithUserId:self.userId withPhoneNum:self.telephoneNum withPassword:inputPasswordTextField.text];
        }else{
            //验证失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
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
