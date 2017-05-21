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
    
    
    
    ///确认新密码
    UITextField *makeSureNewTextField;

}
@end

@implementation ForgetPasswordOfSetNewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置新密码";
    
    [self createLeftBackNavBtn];
    self.view.backgroundColor = [CommonUtils colorWithHex:@"e5e5e5"];
    [self setContentView];
    
    
}
-(void)setContentView
{
    float space = 16;
    float width = SCREEN_WIDTH -2*space;
    float height = 48;
    
    UIView * backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, space+NAV_TOP_HEIGHT, SCREEN_WIDTH, height * 2)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    //请输入密码
    inputPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, 0, width, height)];
    inputPasswordTextField.tag = 2;
    inputPasswordTextField.delegate = self;
    [inputPasswordTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    inputPasswordTextField.secureTextEntry = YES;
    inputPasswordTextField.textAlignment = NSTextAlignmentLeft;
    inputPasswordTextField.borderStyle = UITextBorderStyleNone;
    inputPasswordTextField.placeholder = @"请设置新密码";
    inputPasswordTextField.adjustsFontSizeToFitWidth = YES;
    inputPasswordTextField.returnKeyType = UIReturnKeyDone;
    inputPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backgroundView addSubview:inputPasswordTextField];
    
    
    //确认输入密码
    makeSureNewTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, CGRectGetMaxY(inputPasswordTextField.frame), width, height)];
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
    
    
    [UIFactory showLineInView:backgroundView color:@"e5e5e5" rect:CGRectMake(0, CGRectGetMaxY(inputPasswordTextField.frame)-0.5, SCREEN_WIDTH, 1)];

    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 3.0;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:[CommonUtils colorWithHex:@"00c05c"]];
    [sureBtn setFrame:CGRectMake(space, CGRectGetMaxY(backgroundView.frame)+space, width, height)];
    [sureBtn setContentMode:UIViewContentModeCenter];
    [sureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sureBtn];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)sure:(UIButton *)sender
{
    if (inputPasswordTextField.text.length <= 0 ) {
        [CommonUtils showToastWithStr:@"密码不能为空"];
        return;
    }
    
    if (inputPasswordTextField.text.length < 8) {
        
        [CommonUtils showToastWithStr:@"密码不可少于8位"];
        
        return;
    }
    
    if ([self checkIsHaveNumAndLetter:inputPasswordTextField.text] == 1) {
        //全部符合数字，表示沒有英文
        
        [CommonUtils showToastWithStr:@"密码不可以是纯数字"];
        
        return;
    }
    if ([self checkIsHaveNumAndLetter:inputPasswordTextField.text] == 2) {
        //全部符合英文，表示沒有数字
        
        [CommonUtils showToastWithStr:@"密码不可以是纯字母"];
        
        return;
    }
    
    if (![inputPasswordTextField.text isEqualToString:makeSureNewTextField.text]) {
        
        [CommonUtils showToastWithStr:@"两次输入的密码不一致"];
        return;
        
    }

    /*
     user_id int    必需    用户序号
     passwd   string    必需    新密码
     */
    //校验验证码
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.telephoneNum forKey:@"telphone"];
    [dic setObject:inputPasswordTextField.text forKey:@"passwd"];
    [[HttpClient sharedInstance]changePasswordWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            //若成功，应该是返回主页面，并且是已经登录状态
            [[UserAccountManager sharedInstance]loginWithUserPhoneNum:self.telephoneNum andPassWord:inputPasswordTextField.text withUserRole:RegisterRoleOfStudent];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            //验证失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
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
