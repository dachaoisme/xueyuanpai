//
//  RegisterViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/11.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RegisterViewController.h"
#import "AddStudentInfoViewController.h"
#import "AddTeacherViewController.h"
#import "CollegeModel.h"
#import "SelectedSchollViewController.h"
@interface RegisterViewController ()<UITextFieldDelegate>
{
    UITextField *phoneTextField;
    UITextField *checkingMessageTextField;
    UITextField *inputPasswordTextField;
    UIButton    *submitAndRegisterBtn;
    
    NSInteger    timerCount;
    NSTimer     *sendTimer;
    UIButton    *sendMessageBtn;
    
    UIView      *schoolView ;
    UIButton    *schoolBtn;
    UIImageView *schoolArrowImageView;
    
    CollegeModel * theCollegeModel;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"注册学院派"];
    [self createLeftBackNavBtn];
    self.view.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    
    [self setContentView];
    
    
    
}

-(void)setContentView
{
    float topSpace = 15;
    float leftSpace = 15;
    float width = SCREEN_WIDTH ;
    float height = 48;

    
    //创建背景视图
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT+topSpace, width, 4 * height)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGroundView];
    
    //请输入手机号
    phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(leftSpace, 15, width-leftSpace, height-30)];
    phoneTextField.tag = 2;
    phoneTextField.delegate = self;
//    [phoneTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    phoneTextField.textAlignment = NSTextAlignmentLeft;
    phoneTextField.font = [UIFont systemFontOfSize:14];
    phoneTextField.borderStyle   = UITextBorderStyleNone;
    phoneTextField.placeholder   = @"请输入手机号";
    phoneTextField.returnKeyType = UIReturnKeyDone;
    //myTextField.clearsOnBeginEditing = YES;//设置为YES当用点触文本字段时，字段内容会被清除
    phoneTextField.adjustsFontSizeToFitWidth = YES;
    phoneTextField.clearButtonMode = UITextFieldViewModeNever;
    phoneTextField.leftViewMode    = UITextFieldViewModeAlways;
    phoneTextField.rightViewMode   = UITextFieldViewModeAlways;
    [backGroundView addSubview:phoneTextField];
    
    sendMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendMessageBtn.layer.cornerRadius = 3.0;
    [sendMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendMessageBtn setBackgroundColor:[CommonUtils colorWithHex:@"00c05c"]];
    [sendMessageBtn setFrame:CGRectMake(SCREEN_WIDTH - 80 - 15,  9, 80, 30)];
    [sendMessageBtn setContentMode:UIViewContentModeCenter];
    [sendMessageBtn addTarget:self action:@selector(sendmessage:) forControlEvents:UIControlEventTouchUpInside];
    [sendMessageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendMessageBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [backGroundView addSubview:sendMessageBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 48, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [backGroundView addSubview:lineView];
//
    //请输入验证码
    checkingMessageTextField = [[UITextField alloc]initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(lineView.frame) + 15, width, height-30)];
    checkingMessageTextField.tag = 2;
    checkingMessageTextField.delegate = self;
    checkingMessageTextField.font = [UIFont systemFontOfSize:14];
    checkingMessageTextField.returnKeyType = UIReturnKeyDone;
    [checkingMessageTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    checkingMessageTextField.textAlignment = NSTextAlignmentLeft;
    checkingMessageTextField.borderStyle = UITextBorderStyleNone;
    checkingMessageTextField.placeholder = @"请输入验证码";
    checkingMessageTextField.adjustsFontSizeToFitWidth = YES;
    checkingMessageTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backGroundView addSubview:checkingMessageTextField];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(15, 48 * 2, SCREEN_WIDTH, 1)];
    lineView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [backGroundView addSubview:lineView1];


    
    //请输入密码
    inputPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(leftSpace, CGRectGetMaxY(lineView1.frame) + 15, width, height - 30)];
    inputPasswordTextField.returnKeyType = UIReturnKeyDone;
    inputPasswordTextField.tag = 2;
    inputPasswordTextField.delegate = self;
    [inputPasswordTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
    inputPasswordTextField.font = [UIFont systemFontOfSize:14];
    inputPasswordTextField.textAlignment = NSTextAlignmentLeft;
    inputPasswordTextField.borderStyle = UITextBorderStyleNone;
    inputPasswordTextField.placeholder = @"请设置密码";
    inputPasswordTextField.adjustsFontSizeToFitWidth = YES;
    inputPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [backGroundView addSubview:inputPasswordTextField];
    
    ///选择学校
    float arrowWidth = 25;
    schoolView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(inputPasswordTextField.frame)+15, SCREEN_WIDTH, height-30)];
    [schoolView setBackgroundColor:[UIColor whiteColor]];
    [backGroundView addSubview:schoolView];
    schoolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    schoolBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [schoolBtn setFrame:CGRectMake(leftSpace, 0, width-arrowWidth-leftSpace, height)];
    [schoolBtn setTitle:@"请选择学校" forState:UIControlStateNormal];
    [schoolBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    schoolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [schoolBtn addTarget:self action:@selector(selectedSchool:) forControlEvents:UIControlEventTouchUpInside];
    [schoolView addSubview:schoolBtn];
    schoolArrowImageView = [UIFactory imageView:CGRectMake(CGRectGetMaxX(schoolBtn.frame), 0, arrowWidth, height) viewMode:UIViewContentModeCenter image:@"arrow"];
    [schoolArrowImageView setBackgroundColor:[UIColor whiteColor]];
    [schoolView addSubview:schoolArrowImageView];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(15, 48 * 3, SCREEN_WIDTH, 1)];
    lineView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [backGroundView addSubview:lineView2];
    
    //提交并注册
    submitAndRegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitAndRegisterBtn setBackgroundColor:[CommonUtils colorWithHex:@"00c05c"]];
    submitAndRegisterBtn.tag = 10002;
    submitAndRegisterBtn.layer.cornerRadius = 5.0;
    [submitAndRegisterBtn setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [submitAndRegisterBtn setFrame:CGRectMake(topSpace, CGRectGetMaxY(backGroundView.frame)+topSpace, width-2*topSpace, height)];
    [submitAndRegisterBtn addTarget:self action:@selector(submitAndRegister:) forControlEvents:UIControlEventTouchUpInside];
    [submitAndRegisterBtn setTitle:@"提交并注册" forState:UIControlStateNormal];
    submitAndRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:submitAndRegisterBtn];
    
    
}
-(void)sendmessage:(UIButton *)sender
{
    
    NSString * phoneNum = phoneTextField.text;
    if (!(phoneNum.length==11 && [CommonUtils checkPhoneNumIsAvailableWithPhoneNumString:phoneNum])) {
        [CommonUtils showToastWithStr:@"请输入有效手机号"];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phoneNum forKey:@"telphone"];
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
#pragma mark - 选择学校
-(void)selectedSchool:(UIButton *)sender
{
    SelectedSchollViewController * schollVC = [[SelectedSchollViewController alloc]init];
    schollVC.callBackBlock = ^(CollegeModel *collegeModel) {
        [schoolBtn setTitle:collegeModel.collegeName forState:UIControlStateNormal];
        theCollegeModel = collegeModel;
        [schoolBtn setTitle:theCollegeModel.collegeName forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:schollVC animated:YES];
}
-(void)submitAndRegister:(UIButton *)sender
{
    
    /*
     
     参数:
     mobile string    必需    手机号
     role   string    必需    角色      1学生 2导师
     passwd string   必需     密码
     captcha sting    必需    验证码
     返回结果:
     
     */
    
    //如果是学生，则注册成功，则返回登录页面
    //如果是导师，则注册成功后，跳转到设置资料页面？
//    if ([CommonUtils checkPhoneNumIsAvailableWithPhoneNumString:phoneTextField.text]) {
//        [CommonUtils showToastWithStr:@"请输入有效手机号"];
//        return;
//    }
    
    if (inputPasswordTextField.text.length<=0) {
        [CommonUtils showToastWithStr:@"请输入密码"];
        return;
    }
    if (checkingMessageTextField.text.length<=0) {
        [CommonUtils showToastWithStr:@"请输入验证码"];
        return;
    }
    if (!(theCollegeModel &&theCollegeModel.collegeID.length>0)) {
        [CommonUtils showToastWithStr:@"请选择大学"];
        return;
    }
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setObject:phoneTextField.text forKey:@"telphone"];
    [params setObject:inputPasswordTextField.text forKey:@"passwd"];
    [params setObject:checkingMessageTextField.text forKey:@"captcha"];
    [params setObject:theCollegeModel.collegeID forKey:@"college_id"];
    
    [[HttpClient sharedInstance]registerAndSubmitWithParams:params withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSString * userId = [listDic stringForKey:@"user_id"];

                //学生->跳转到设置用户资料界面，直接登录成功
                AddStudentInfoViewController * studentInfoVC = [[AddStudentInfoViewController alloc]init];
                studentInfoVC.userId = userId;
                [self.navigationController pushViewController:studentInfoVC animated:YES];
                //保存学生的用户信息
                [[UserAccountManager sharedInstance]loginWithUserPhoneNum:phoneTextField.text andPassWord:inputPasswordTextField.text withUserRole:1];
                
           
        }else{
            
            
            [CommonUtils showToastWithStr:responseModel.responseMsg];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
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
