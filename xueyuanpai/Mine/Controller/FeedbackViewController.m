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
    UITextField *connectTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT + 10, SCREEN_WIDTH, 48)];
    connectTextField.borderStyle = UITextBorderStyleNone;
    connectTextField.backgroundColor = [UIColor whiteColor];
    connectTextField.placeholder = @" 联系方式";
    connectTextField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:connectTextField];
    
    
    //意见反馈
    JKPlaceholderTextView *textView = [[JKPlaceholderTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(connectTextField.frame) + 10, SCREEN_WIDTH, 150)];
    textView.backgroundColor = [UIColor whiteColor];
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
    
    [CommonUtils showToastWithStr:@"提交意见反馈"];
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
