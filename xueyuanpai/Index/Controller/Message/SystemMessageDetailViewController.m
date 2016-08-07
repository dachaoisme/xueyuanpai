//
//  SystemMessageDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/7/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SystemMessageDetailViewController.h"
#import "SystemMessageDetailView.h"

@interface SystemMessageDetailViewController ()

@property (nonatomic,strong)SystemMessageDetailView *detailView;

@end

@implementation SystemMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"系统通知详情";
    
    [self createLeftBackNavBtn];
    
    
    SystemMessageDetailView *detailView = [[SystemMessageDetailView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:detailView];
    self.detailView = detailView;
    
    
    //请求数据
    [self requestDetailData];
    
    
}

- (void)requestDetailData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setValue:self.messageID forKey:@"msg_id"];
    [[HttpClient sharedInstance] getSystemMessageDetailWithParams:paramsDic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        
        if (model.responseCode == ResponseCodeSuccess) {
            
            self.detailView.titleLabel.text = [model.responseCommonDic objectForKey:@"title"];
            self.detailView.authorLable.text = [model.responseCommonDic objectForKey:@"create_at"];
            
            [_detailView adjustSubviewsWithContent: [model.responseCommonDic objectForKey:@"msg"]];

            [self.detailView.webView loadHTMLString: [model.responseCommonDic objectForKey:@"msg"] baseURL:nil];
            
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }

        
    } withFaileBlock:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        
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
