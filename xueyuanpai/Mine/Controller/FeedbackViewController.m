//
//  FeedbackViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "FeedbackViewController.h"

#import "JKPlaceholderTextView.h"

@interface FeedbackViewController ()<UITextViewDelegate>
{
    UITextField *connectTextField;
    JKPlaceholderTextView *textView;
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
    connectTextField.borderStyle = UITextBorderStyleNone;
    connectTextField.backgroundColor = [UIColor whiteColor];
    connectTextField.placeholder = @" 联系方式";
    connectTextField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:connectTextField];
    
    
    //意见反馈
    textView = [[JKPlaceholderTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(connectTextField.frame) + 10, SCREEN_WIDTH, 150)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.keyboardType = UIKeyboardTypeDefault;
    textView.font = [UIFont systemFontOfSize:14];
    textView.placehoderText = @"你有什么意见或建议？";
    [textView setPlacehoderTextLabelTextColor:[CommonUtils colorWithHex:@"c7c6cb"]];
    [self.view addSubview:textView];


    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, CGRectGetMaxY(textView.frame) + 10, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
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
    if (textView.text.length<=0) {
        [CommonUtils showToastWithStr:@"请输入反馈信息"];
    }
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:connectTextField.text forKey:@"contact"];
    [dic setValue:textView.text forKey:@"suggestions"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]feedBackWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model.responseCode ==ResponseCodeSuccess) {
            ///反馈成功
            [CommonUtils showToastWithStr:@"反馈成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ///反馈失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
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
