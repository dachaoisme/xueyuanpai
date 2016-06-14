//
//  BusinessNewsViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/2.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessNewsViewController.h"

#import "BusinessCenterTableViewCell.h"
#import "BusinessNewsDetailViewController.h"
#import "BusinessClassDetailViewController.h"
#import "BusinessProjectViewController.h"

#import "LoginViewController.h"

@interface BusinessNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageNo ;
    NSInteger pageSize ;
    NSMutableArray * businessCenterModelListArr;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation BusinessNewsViewController

-(void)viewWillAppear:(BOOL)animated{
    [self theTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    businessCenterModelListArr  = [NSMutableArray array];
    
    self.title = @"创业新闻";
    pageNo = 1;
    pageSize = 10;
    
    [self createLeftBackNavBtn];
    
    
    [self createTableView];
    
    [self requestToGetBusinessNewsList];
    
}

#pragma mark - 创建展示视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //注册cell
    
    [_tableView registerNib:[UINib nibWithNibName:@"BusinessCenterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return businessCenterModelListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BusinessCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    BusinessCenterNewsModel * model = [businessCenterModelListArr objectAtIndex:indexPath.row];
    
    [cell.showImageView sd_setImageWithURL:[NSURL URLWithString:model.businessCenterNewsImage] placeholderImage:[UIImage imageNamed:@"placeHoder.png"]];
    
    cell.titleLabel.text = model.businessCenterNewsTitle;
    
    cell.contentLabel.text = model.businessCenterNewsBrief;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if ([UserAccountManager sharedInstance].isLogin==YES) {
        
        //创业新闻
        BusinessNewsDetailViewController *detailVC = [[BusinessNewsDetailViewController alloc] init];
        
        detailVC.title = @"新闻详情";
        BusinessCenterNewsModel * model = [businessCenterModelListArr objectAtIndex:indexPath.row];
        
        detailVC.newsModel = model;
        
        
        [self.navigationController pushViewController:detailVC animated:YES];

    }else{
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }

    

    
}

-(void)requestToGetBusinessNewsList
{

    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageNo] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterGetListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                BusinessCenterNewsModel * model = [[BusinessCenterNewsModel alloc]initWithDic:smallDic];
                [businessCenterModelListArr  addObject:model];
            }
            ///处理上拉加载更多逻辑
            if (pageNo>=[pageModel.responsePageTotalCount integerValue]) {
                //说明是最后一张
                self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
            }
            [self.tableView reloadData];
        }else{
            
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
    }];
    
}

-(void)requestMoreData
{
    pageNo = pageNo+1;
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
