//
//  JMChangePasswordViewController.m
//  kuaidiyuan
//
//  Created by dachao li on 2017/3/21.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMChangePasswordViewController.h"

@interface JMChangePasswordViewController ()<UITextFieldDelegate>
{
    
    UITextField *inputOldPasswordTextField;
    UITextField *inputPassNewTextField;
    
    ///确认新密码
    UITextField *makeSureNewTextField;
    
    UIButton    *sureBtn;
}

@end

@implementation JMChangePasswordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  =@"修改密码";
    [self createLeftBackNavBtn];
    self.view.backgroundColor = [CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self setContentView];
    
    
}
-(void)setContentView
{
    float space = 16;
    float width = SCREEN_WIDTH -2*space;
    float backgroundViewHeight = 48*3;
    float height = 48;
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, space+NAV_TOP_HEIGHT, SCREEN_WIDTH, backgroundViewHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    //请输入密码
    inputOldPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, 0, width, height)];
    inputOldPasswordTextField.tag = 2;
    inputOldPasswordTextField.delegate = self;
    [inputOldPasswordTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    inputOldPasswordTextField.textAlignment = NSTextAlignmentLeft;
    inputOldPasswordTextField.borderStyle = UITextBorderStyleNone;
    inputOldPasswordTextField.placeholder = @"请输入旧密码";
    inputOldPasswordTextField.adjustsFontSizeToFitWidth = YES;
    inputOldPasswordTextField.returnKeyType = UIReturnKeyDone;
    inputOldPasswordTextField.secureTextEntry = YES;
    inputOldPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backgroundView addSubview:inputOldPasswordTextField];
    
    //请输入密码
    inputPassNewTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, CGRectGetMaxY(inputOldPasswordTextField.frame), width, height)];
    inputPassNewTextField.tag = 2;
    inputPassNewTextField.delegate = self;
    [inputPassNewTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    inputPassNewTextField.secureTextEntry = YES;
    inputPassNewTextField.textAlignment = NSTextAlignmentLeft;
    inputPassNewTextField.borderStyle = UITextBorderStyleNone;
    inputPassNewTextField.placeholder = @"请输入不少于8位的数字+字母组合的新密码";
    inputPassNewTextField.adjustsFontSizeToFitWidth = YES;
    inputPassNewTextField.returnKeyType = UIReturnKeyDone;
    inputPassNewTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backgroundView addSubview:inputPassNewTextField];
    
    //确认输入密码
    makeSureNewTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, CGRectGetMaxY(inputPassNewTextField.frame), width, height)];
    makeSureNewTextField.tag = 3;
    makeSureNewTextField.delegate = self;
    [makeSureNewTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    makeSureNewTextField.secureTextEntry = YES;
    makeSureNewTextField.textAlignment = NSTextAlignmentLeft;
    makeSureNewTextField.borderStyle = UITextBorderStyleNone;
    makeSureNewTextField.placeholder = @"请再次输入新密码";
    makeSureNewTextField.adjustsFontSizeToFitWidth = YES;
    makeSureNewTextField.returnKeyType = UIReturnKeyDone;
    makeSureNewTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backgroundView addSubview:makeSureNewTextField];

    
    [UIFactory showLineInView:backgroundView color:@"e5e5e5" rect:CGRectMake(0, CGRectGetMaxY(inputOldPasswordTextField.frame)-0.5, SCREEN_WIDTH, 1)];
    
    [UIFactory showLineInView:backgroundView color:@"e5e5e5" rect:CGRectMake(0, CGRectGetMaxY(inputPassNewTextField.frame)-0.5, SCREEN_WIDTH, 1)];

    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 3.0;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[CommonUtils colorWithHex:NORMAL_HEIGHTLIGHT_COLOR]];
    [sureBtn setFrame:CGRectMake(space, CGRectGetMaxY(backgroundView.frame)+space, width, height)];
    [sureBtn setContentMode:UIViewContentModeCenter];
    [sureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:sureBtn];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)sure:(UIButton *)sender
{
    if (inputOldPasswordTextField.text.length<=0 ) {
        [CommonUtils showToastWithStr:@"旧密码不能为空"];
        return;
    }
    if (inputPassNewTextField.text.length<=0 ) {
        [CommonUtils showToastWithStr:@"新密码不能为空"];
        return;
    }
    
    if (inputPassNewTextField.text.length < 8) {
        
        [CommonUtils showToastWithStr:@"密码不可少于8位"];
        
        return;
    }
    
    if ([self checkIsHaveNumAndLetter:inputPassNewTextField.text] == 1) {
        //全部符合数字，表示沒有英文

        [CommonUtils showToastWithStr:@"密码不可以是纯数字"];
        
        return;
    }
    if ([self checkIsHaveNumAndLetter:inputPassNewTextField.text] == 2) {
        //全部符合英文，表示沒有数字

        [CommonUtils showToastWithStr:@"密码不可以是纯字母"];

        return;
    }
    
    if (![inputPassNewTextField.text isEqualToString:makeSureNewTextField.text]) {
        
        [CommonUtils showToastWithStr:@"两次输入的密码不一致"];
        return;
        
    }
    /*
     user_id int    必需    用户序号
     passwd   string    必需    新密码
     */
    //校验验证码
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"student_id"];
    [dic setObject:inputOldPasswordTextField.text forKey:@"old_passwd"];
    [dic setObject:inputPassNewTextField.text forKey:@"new_passwd"];
    [[HttpClient sharedInstance]changePasswordWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            //NSDictionary * userInfoDic = [model.responseCommonDic objectForKey:@"data"];
            
            [CommonUtils showToastWithStr:@"密码修改成功"];
            
            [self performSelector:@selector(comeBackHomePage) withObject:self afterDelay:2.0f];
            
        }else{
            //验证失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}

- (void)comeBackHomePage{
    
    //跳转到编辑个人资料根试图页面
    [self.navigationController popToRootViewControllerAnimated:YES];

    
    //若成功，应该是返回主页面，并且是已经登录状态
    [[UserAccountManager sharedInstance] loginWithUserPhoneNum:[UserAccountManager sharedInstance].userTelphone andPassWord:inputPassNewTextField.text  withUserRole:RegisterRoleOfStudent];
    
}

//直接调用这个方法就行
-(int)checkIsHaveNumAndLetter:(NSString*)password{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, password.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    if (tNumMatchCount == password.length) {
        //全部符合数字，表示沒有英文
        return 1;
    } else if (tLetterMatchCount == password.length) {
        //全部符合英文，表示沒有数字
        return 2;
    } else if (tNumMatchCount + tLetterMatchCount == password.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return 3;
    } else {
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
        return 4;
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
