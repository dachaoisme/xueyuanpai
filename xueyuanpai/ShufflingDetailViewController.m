//
//  ShufflingDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/7/8.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ShufflingDetailViewController.h"

@interface ShufflingDetailViewController ()<UIWebViewDelegate>

@end

@implementation ShufflingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self theTabBarHidden:YES];
    
    self.title = @"轮播图详情";
    
    [self createLeftBackNavBtn];
    
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    webView.delegate = self;
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"]];
    [webView loadRequest:urlRequest];
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
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
