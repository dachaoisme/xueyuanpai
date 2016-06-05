//
//  BusinessGameViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessGameViewController.h"

#import "BusinessCenterTableViewCell.h"
#import "BusinessNewsDetailViewController.h"


@interface BusinessGameViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageNo ;
    NSInteger pageSize ;
    NSMutableArray *businessCenterCompetitionModelListArr;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation BusinessGameViewController

-(void)viewWillAppear:(BOOL)animated{
    [self theTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"创业大赛";
    businessCenterCompetitionModelListArr = [NSMutableArray array];
    [self createLeftBackNavBtn];
    
    
    [self createTableView];
    
    
    
}

#pragma mark - 创建展示视图
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessCenterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BusinessCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //创业大赛
    BusinessNewsDetailViewController *detailVC = [[BusinessNewsDetailViewController alloc] init];
    detailVC.title = @"大赛详情";
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)requestToGetBusinessCompetitionList
{
    pageNo = 1;
    pageSize = 10;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageNo] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterGetCompetitionListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                BusinessCenterCompetitionModel * model = [[BusinessCenterCompetitionModel alloc]initWithDic:smallDic];
                [businessCenterCompetitionModelListArr  addObject:model];
            }
            [self.tableView reloadData];
        }else{
            
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
