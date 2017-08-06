//
//  JMSignUpProcessingViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/8/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSignUpProcessingViewController.h"
#import "YYModel.h"
#import "JMSignUpProcessingLogModel.h"
@interface JMSignUpProcessingViewController ()
{
    NSMutableArray *dataArray;
    int currentPage;
    int nextPage;
    int pageSize;
}
@end

@implementation JMSignUpProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestData];
}
-(void)requestData
{
    /*
     entity_id   string 序号      必需
     entity_type string 类型     必需   可选项: project 创业项目  salon创业沙龙 course 创业课程
     user_id      int   用户序号
     content     string 评论内容
     
     */
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.entity_id forKey:@"entity_id"];
    [dic setObject:self.entity_type forKey:@"entity_type"];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [[HttpClient sharedInstance]signUpProcessingWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        //[self.tableView.footer endRefreshing];
        
        NSArray * listArray = [model.responseCommonDic objectForKey:@"lists"];
        
        if (listArray.count == 0) {
            //说明是最后一张
            //self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMSignUpProcessingLogModel *model = [JMSignUpProcessingLogModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            //[self.tableView reloadData];
        }
        
    } withFaileBlock:^(NSError *error) {
        //[self.tableView.footer endRefreshing];
    }];
    
}
-(void)requestMoreData
{
    currentPage =currentPage+1;
    [self requestData];
}
-(void)refreshData
{
    [dataArray removeAllObjects];
    //[self.tableView reloadData];
    nextPage=currentPage=1;
    [self requestData];
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
