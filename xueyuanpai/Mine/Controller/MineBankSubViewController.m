//
//  MineBankSubViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MineBankSubViewController.h"

@interface MineBankSubViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * timebankModelListArr;
    int pageNum;
    int pageSize;
}
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation MineBankSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pageNum = 1;
    pageSize = 10;
    timebankModelListArr = [NSMutableArray array];
    [self createTableView];
}

#pragma mark - tableview UITableViewDataSource,UITableViewDelegate
-(void)createTableView
{
    
    UITableView * tableView    = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor  = [CommonUtils colorWithHex:@"f3f3f3"];
    tableView.separatorInset   = UIEdgeInsetsZero;
    tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    tableView.dataSource       = self;
    tableView.delegate         = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"TimeBankTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //游玩日期
    return 120;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return timebankModelListArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //游玩日期
    NSString * cellResuable = [NSString stringWithFormat:@"cell"];
    TimeBankTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellResuable forIndexPath:indexPath];
    
    TimeBankModel * timeBankModel = [timebankModelListArr objectAtIndex:indexPath.row];
    [cell setContentViewWithModel:timeBankModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TimeBankModel * model = [timebankModelListArr objectAtIndex:indexPath.row];
    //点击进入时间银行详情
    TimeBankDetailViewController *detailVC = [[TimeBankDetailViewController alloc] init];
        detailVC.timeBankId = model.timeBankId;
    [self.navigationController pushViewController:detailVC animated:YES];

}

-(void)setMineTimeBankStatus:(MineTimeBankStatus)mineTimeBankStatus
{
    _mineTimeBankStatus = mineTimeBankStatus;
    [self requestToGetTimeBankList];
}
-(void)requestToGetTimeBankList
{
    /*
     
     user_id          int     必需   用户序号
     page           int     非必需    第几页        默认1
     size           int     非必需    每页多少条     默认10
     status         int     非必需    申领状态       //0 未申请 1 已申请 2 已通过 3 过期 4 完成
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.mineTimeBankStatus] forKey:@"type"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]mineToGetTimeBankListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                TimeBankModel * model = [[TimeBankModel alloc]initWithDic:smallDic];
                [timebankModelListArr  addObject:model];
            }
            if (pageNum>=[pageModel.responsePageTotalCount integerValue]) {
                //说明是最后一张
                self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
    }];
    
}
-(void)requestMoreData
{
    pageNum = pageNum +1;
    [self requestToGetTimeBankList];
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
