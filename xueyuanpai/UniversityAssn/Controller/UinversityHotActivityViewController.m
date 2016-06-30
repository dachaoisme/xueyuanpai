//
//  UinversityHotActivityViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/6/9.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "UinversityHotActivityViewController.h"

#import "LoginViewController.h"

@interface UinversityHotActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int pageSize;
    int pageNum;
    
    ///用于存储热门活动数据的数组
    NSMutableArray *hotActivityDataArray;

}
///用于显示的列表
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation UinversityHotActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    hotActivityDataArray = [NSMutableArray array];
    pageNum = 1;
    pageSize = 10;
    [self createTableView];
    [self requestHotActivityData];
}
#pragma mark - 获取热门活动页面数据
- (void)requestHotActivityData{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%d",pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]getHotActivityDataWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [self.tableView.footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                HotActivityModel * model = [[HotActivityModel alloc]initWithDic:smallDic];
                [hotActivityDataArray addObject:model];
            }
            ///处理上拉加载更多逻辑
            if (pageNum>=[pageModel.responsePageTotalCount integerValue]) {
                //说明是最后一张
                self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
            }
            [self.tableView reloadData];
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

-(void)requestMoreData
{
    pageNum = pageNum+1;
    [self requestHotActivityData];
}
#pragma mark - 创建tableView
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return hotActivityDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotActivityTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[HotActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HotActivityTableViewCell"];
        
        HotActivityModel *model = [hotActivityDataArray objectAtIndex:indexPath.row];
        
        [cell bindModel:model];
        
        
        

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 280 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ActivityDetailViewController *detailVC = [[ActivityDetailViewController alloc] init];
    detailVC.model = [hotActivityDataArray objectAtIndex:indexPath.row];
    [self.superViewController.navigationController pushViewController:detailVC animated:YES];

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
