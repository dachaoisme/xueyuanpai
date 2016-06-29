//
//  LoginViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/11.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "RegisterRoleView.h"
#import "ForgetPasswordViewController.h"


@interface LoginViewController ()<RegisterRoleViewDelegate>
{
    UITextField *phoneTextField;
    UITextField *passwordTextField;
    UIButton    *personalAccountBtn;
    UIButton    *teacherAccountBtn;
    UIButton    *loginBtn;
    UIButton    *registerBtn;
    UIButton    *justToLook;
    RegisterRoleView * registerRoleAlertView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setContentView];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [self theTabBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
-(void)setContentView
{
    float topSpace = 96;
    float leftSpace = 39;
    float rightSpace = 35;
    float width = SCREEN_WIDTH - 35*2;
    float height = 48;
    float smallSpace = 15;
    float smallHeight = 36;
    //大的背景图
    UIImageView * backgroundImageView = [UIFactory imageView:self.view.frame viewMode:UIViewContentModeScaleToFill image:@"login_bg.jpg"];
    [self.view addSubview:backgroundImageView];
    //logo
    UIImage * logoImage = [UIImage imageNamed:@"login_logo"];
    UIImageView * logoImageView = [UIFactory imageView:CGRectMake(leftSpace, topSpace, logoImage.size.width, logoImage.size.height) viewMode:UIViewContentModeScaleToFill image:@"login_logo"];
    [self.view addSubview:logoImageView];
    
    float boardHeight = 0.5;
    
    UIView *textFieldbackgroundView = [[UIView alloc]initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(logoImageView.frame)+60 , width, height *2)];
    textFieldbackgroundView.layer.borderColor = [CommonUtils colorWithHex:@"c2c3c4"].CGColor;
    textFieldbackgroundView.layer.borderWidth = boardHeight;
    [self.view addSubview:textFieldbackgroundView];
    
    //手机号输入框
    UIImageView * phoneImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_phone"]];
    phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(boardHeight, boardHeight, CGRectGetWidth(textFieldbackgroundView.frame)-2*boardHeight, height-boardHeight)];
    phoneTextField.tag = 1;
    phoneTextField.delegate = self;
    phoneTextField.textAlignment = NSTextAlignmentLeft;
    phoneTextField.borderStyle = UITextBorderStyleNone;
    phoneTextField.returnKeyType = UIReturnKeyDone;
    phoneTextField.font = [UIFont systemFontOfSize:14];
    phoneTextField.placeholder = @"请输入手机号";
    phoneTextField.adjustsFontSizeToFitWidth = YES;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    phoneTextField.leftView = phoneImageView;
    [textFieldbackgroundView addSubview:phoneTextField];
    
    //密码输入框
    UIImageView * passwordImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_password"]];
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(boardHeight, CGRectGetMaxY(phoneTextField.frame), CGRectGetWidth(textFieldbackgroundView.frame)-2*boardHeight, height-boardHeight)];
    passwordTextField.tag = 2;
    passwordTextField.delegate = self;
    passwordTextField.textAlignment = NSTextAlignmentLeft;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.font = [UIFont systemFontOfSize:14];
    passwordTextField.returnKeyType = UIReturnKeyDone;
    //myTextField.clearsOnBeginEditing = YES;//设置为YES当用点触文本字段时，字段内容会被清除
    passwordTextField.adjustsFontSizeToFitWidth = YES;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    passwordTextField.leftView = passwordImageView;
    passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    [textFieldbackgroundView addSubview:passwordTextField];
    
    [UIFactory showLineInView:textFieldbackgroundView color:@"c2c3c4" rect:CGRectMake(0, CGRectGetMaxY(phoneTextField.frame), CGRectGetWidth(textFieldbackgroundView.frame), 0.5)];
    
    UIButton * forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPasswordBtn setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    [forgetPasswordBtn setFrame:CGRectMake(0, 0, 50, 30)];
    [forgetPasswordBtn addTarget:self action:@selector(forgetPasswordAccount:) forControlEvents:UIControlEventTouchUpInside];
    [forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    passwordTextField.rightView = forgetPasswordBtn;
    
    
    personalAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [personalAccountBtn setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    personalAccountBtn.selected = YES;
    personalAccountBtn.tag = 10001;
    personalAccountBtn.layer.cornerRadius = 3.0;
    [personalAccountBtn setTitleColor:[CommonUtils colorWithHex:@"999999"] forState:UIControlStateNormal];
    [personalAccountBtn setImage: [UIImage imageNamed:@"login_type_check"] forState:UIControlStateSelected];
    
    [personalAccountBtn setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateSelected];
    [personalAccountBtn setFrame:CGRectMake(leftSpace, CGRectGetMaxY(textFieldbackgroundView.frame)+smallSpace, (SCREEN_WIDTH-smallSpace-2*leftSpace)/2, smallHeight)];
    [personalAccountBtn setImageEdgeInsets:UIEdgeInsetsMake(smallHeight - 39/2, (SCREEN_WIDTH-smallSpace-2*leftSpace)/2 - 39/2, 0, 0)];
    
    [personalAccountBtn addTarget:self action:@selector(selectedLoginMethodWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [personalAccountBtn setTitle:@"个人账号" forState:UIControlStateNormal];
    personalAccountBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:personalAccountBtn];
    
    teacherAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [teacherAccountBtn setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    teacherAccountBtn.tag = 10002;
    teacherAccountBtn.layer.cornerRadius = 3.0;
    [teacherAccountBtn setTitleColor:[CommonUtils colorWithHex:@"999999"] forState:UIControlStateNormal];
    [teacherAccountBtn setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateSelected];
    
    [teacherAccountBtn setImage: [UIImage imageNamed:@"login_type_check"] forState:UIControlStateSelected];
    [teacherAccountBtn setImageEdgeInsets:UIEdgeInsetsMake(smallHeight - 39/2, (SCREEN_WIDTH-smallSpace-2*leftSpace)/2 - 39/2, 0, 0)];
    
    [teacherAccountBtn setFrame:CGRectMake(CGRectGetMaxX(personalAccountBtn.frame)+smallSpace, CGRectGetMaxY(textFieldbackgroundView.frame)+smallSpace, CGRectGetWidth(personalAccountBtn.frame), smallHeight)];
    [teacherAccountBtn addTarget:self action:@selector(selectedLoginMethodWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [teacherAccountBtn setTitle:@"导师账号" forState:UIControlStateNormal];
    teacherAccountBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:teacherAccountBtn];
    
    //登陆按钮
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    loginBtn.tag = 10002;
    loginBtn.layer.cornerRadius = 5.0;
    [loginBtn setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [loginBtn setFrame:CGRectMake(leftSpace, CGRectGetMaxY(personalAccountBtn.frame)+smallSpace, width, height)];
    [loginBtn addTarget:self action:@selector(loginAccount:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    loginBtn.layer.masksToBounds = YES;

    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:loginBtn];
    
    //注册按钮
    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    registerBtn.tag = 10002;
    registerBtn.layer.cornerRadius = 5.0;
    registerBtn.layer.masksToBounds = YES;
    [registerBtn setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    [registerBtn setFrame:CGRectMake(leftSpace, CGRectGetMaxY(loginBtn.frame)+smallSpace, width, height)];
    [registerBtn addTarget:self action:@selector(registerAccount:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:registerBtn];
    
    justToLook = [UIButton buttonWithType:UIButtonTypeCustom];
    [justToLook setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [justToLook setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [justToLook setFrame:CGRectMake(SCREEN_WIDTH-rightSpace-100, SCREEN_HEIGHT - 50, 100, height)];
    [justToLook addTarget:self action:@selector(justToLook:) forControlEvents:UIControlEventTouchUpInside];
    [justToLook setTitle:@"随便逛逛 >" forState:UIControlStateNormal];
    justToLook.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:justToLook];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignTheTextField];
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self resignTheTextField];
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self resignTheTextField];
}

-(void)resignTheTextField
{
    if (phoneTextField.isFirstResponder) {
        [phoneTextField resignFirstResponder];
    }
    if (passwordTextField.isFirstResponder) {
        [passwordTextField resignFirstResponder];
    }
}
#pragma mark - 选择个人账号登录或者企业账号登陆
-(void)selectedLoginMethodWithBtn:(UIButton *)sender
{
    if (sender.tag == 10001) {
        if (personalAccountBtn.selected) {
        }else{
            personalAccountBtn.selected = YES;
            teacherAccountBtn.selected = NO;
        }
    }else{
        if (teacherAccountBtn.selected) {
        }else{
            teacherAccountBtn.selected = YES;
            personalAccountBtn.selected = NO;
        }
    }
}

#pragma mark - 忘记密码
-(void)forgetPasswordAccount:(UIButton *)sender
{
    ForgetPasswordViewController * forgetPasswordVC = [[ForgetPasswordViewController alloc]init];
    forgetPasswordVC.registerRoleType = personalAccountBtn.selected?RegisterRoleOfStudent:RegisterRoleTypeTeacher;
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}
#pragma mark - 登陆
-(void)loginAccount:(UIButton *)sender
{
    NSString * phoneNum = phoneTextField.text;
    if (!(phoneNum.length==11 && [CommonUtils checkPhoneNumIsAvailableWithPhoneNumString:phoneNum])) {
        [CommonUtils showToastWithStr:@"请输入有效手机号"];
        return;
    }
    if (passwordTextField.text.length<=0 ) {
        [CommonUtils showToastWithStr:@"密码不能为空"];
        return;
    }
    /*
  mobile  string    必需    手机号码
  passwd   string    必需    密码
  role     string    必需    角色 1学生 2导师
  
  */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:phoneTextField.text forKey:@"mobile"];
    [dic setObject:passwordTextField.text forKey:@"passwd"];
    [dic setObject:personalAccountBtn.selected?@"1":@"2" forKey:@"role"];
    
    
    [[HttpClient sharedInstance]loginWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"登陆成功"];
            [[UserAccountManager sharedInstance]saveUserAccountWithUserInfoDic:model.responseCommonDic];
            
            //登陆的时候,先进行环信登陆判断,然后再进行密码判断
            EMError *error = [[EMClient sharedClient] loginWithUsername:phoneTextField.text password:passwordTextField.text];
            if (!error) {
                
                //环信登陆成功
                [self.navigationController popViewControllerAnimated:YES];

            }

    
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];

        
    

    
    
}
#pragma mark - 注册
-(void)registerAccount:(UIButton *)sender
{
    
    
    if (registerRoleAlertView) {
        registerRoleAlertView = nil;
    }
    registerRoleAlertView = [[RegisterRoleView alloc]initWithFrame:CGRectMake(35, self.view.center.y-75, SCREEN_WIDTH-35*2, 150) withSuperView:self.view];
    registerRoleAlertView.delegate = self;
    registerRoleAlertView.clipsToBounds = YES;
    registerRoleAlertView.layer.cornerRadius = 10.0;
    registerRoleAlertView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:registerRoleAlertView];
    
}
-(void)registerRoleWithType:(RegisterRoleType)registerRoleType
{
    
    RegisterViewController * registerVC = [[RegisterViewController alloc]init];
    registerVC.registerRoleType = registerRoleType;
    [self.navigationController pushViewController:registerVC animated:YES];
    [registerRoleAlertView removeFromSuperview];
    registerRoleAlertView = nil;
}
#pragma mark - 随便看看
-(void)justToLook:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
