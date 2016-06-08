//
//  MineCollectionSubViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MineCollectionSubViewController.h"
#import "BusinessProjectDetailViewController.h"
#import "TimeBankDetailViewController.h"
#import "JobMarketDetailViewController.h"
#import "GiftDetailViewController.h"
#import "BusinessTeacherDetailViewController.h"
@interface MineCollectionSubViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * collectionModelListArr;
    int pageNum;
    int pageSize;
    
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation MineCollectionSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    collectionModelListArr = [NSMutableArray array];
    pageNum = 1;
    pageSize = 10;
    [self createTableView];
    
    //[self requestToGetProgectList];
    
}
#pragma mark - 创建展示视图
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    
    [tableView registerNib:[UINib nibWithNibName:@"MineTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}


#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return collectionModelListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    MineStoreModel * model = [collectionModelListArr objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.mineStoreImage] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    //cell.titleLabel.text = model.mineStoreTitle;
    cell.contentLabel.text = model.mineStoreBrief;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineStoreModel * mineStoreModel = [collectionModelListArr objectAtIndex:indexPath.row];
    
    //跳转项目详情
    if (self.mineType == MineTypeOfProject) {
        BusinessProjectDetailViewController *projectVC = [[BusinessProjectDetailViewController alloc] init];
        
        projectVC.projectId = mineStoreModel.mineStoreId;
        [self.superViewController.navigationController pushViewController:projectVC animated:YES];
    }else if (self.mineType == MineTypeOfTimeBank){
        //点击进入时间银行详情
        TimeBankDetailViewController *detailVC = [[TimeBankDetailViewController alloc] init];
        detailVC.timeBankId = mineStoreModel.mineStoreId;
        [self.superViewController.navigationController pushViewController:detailVC animated:YES];
    }else if (self.mineType == MineTypeOfJobMarket){
        ///点击进入跳蚤市场
        JobMarketDetailViewController *detailVC = [[JobMarketDetailViewController alloc] init];
        detailVC.jobMarketId = mineStoreModel.mineStoreId;
        [self.superViewController.navigationController pushViewController:detailVC animated:YES];
    }else if (self.mineType == MineTypeOfGiftExchange){
        ///点击进入跳蚤市场
#warning 这个地方需要验证一下
        GiftDetailViewController *detailVC = [[GiftDetailViewController alloc] init];
        detailVC.giftDetailId = mineStoreModel.mineStoreId;
        [self.superViewController.navigationController pushViewController:detailVC animated:YES];
    }else{
        ///导师
        BusinessTeacherDetailViewController *detailVC = [[BusinessTeacherDetailViewController alloc] init];
        detailVC.teacherId = mineStoreModel.mineStoreId;
        [self.superViewController.navigationController pushViewController:detailVC animated:YES];
    }
    
}
-(void)setMineType:(MineType)mineType
{
    _mineType = mineType;
    [self requestToGetProgectList];
}
-(void)requestToGetProgectList
{
   
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.mineType] forKey:@"type"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]mineToGetCollectionListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                MineStoreModel * model = [[MineStoreModel alloc]initWithDic:smallDic];
                [collectionModelListArr  addObject:model];
            }
            
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
-(void)requestMoreData
{
    pageNum = pageNum+1;
    [self requestToGetProgectList];
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
