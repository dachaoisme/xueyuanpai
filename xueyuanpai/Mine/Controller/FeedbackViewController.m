//
//  FeedbackViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "FeedbackViewController.h"

#import "JKPlaceholderTextView.h"

@interface FeedbackViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    UITextField *connectTextField;
    JKPlaceholderTextView *textView1;
}
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"意见反馈";
    
    [self createLeftBackNavBtn];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    

    [self createFeedbackView];
}

#pragma mark - 创建意见反馈视图
- (void)createFeedbackView{
    
    
    //联系方式
    connectTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT + 10, SCREEN_WIDTH, 48)];
    connectTextField.returnKeyType = UIReturnKeyDone;
    connectTextField.borderStyle = UITextBorderStyleNone;
    connectTextField.backgroundColor = [UIColor whiteColor];
    connectTextField.delegate = self;
    connectTextField.placeholder = @" 联系方式";
    connectTextField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:connectTextField];
    
    
    //意见反馈
    textView1 = [[JKPlaceholderTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(connectTextField.frame) + 10, SCREEN_WIDTH, 150)];
    textView1.returnKeyType = UIReturnKeyDone;
    textView1.backgroundColor = [UIColor whiteColor];
    textView1.keyboardType = UIKeyboardTypeDefault;
    textView1.font = [UIFont systemFontOfSize:14];
    textView1.placehoderText = @"你有什么意见或建议？";
    textView1.delegate = self;
    [textView1 setPlacehoderTextLabelTextColor:[CommonUtils colorWithHex:@"c7c6cb"]];
    [self.view addSubview:textView1];


    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, CGRectGetMaxY(textView1.frame) + 10, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self.view addSubview:button];
    
}

#pragma mark - 提交意见反馈按钮
- (void)commitAction{
    if (connectTextField.text.length<=0 ) {
        [CommonUtils showToastWithStr:@"请输入联系方式"];
        return;
    }
    if (textView1.text.length<=0) {
        [CommonUtils showToastWithStr:@"请输入反馈信息"];
    }
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:connectTextField.text forKey:@"contact"];
    [dic setValue:textView1.text forKey:@"content"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]feedBackWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model.responseCode ==ResponseCodeSuccess) {
            ///反馈成功
            [CommonUtils showToastWithStr:@"感谢您的意见宝贵意见，我们会逐步完善。"];
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ///反馈失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    
    return YES;
}

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
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
