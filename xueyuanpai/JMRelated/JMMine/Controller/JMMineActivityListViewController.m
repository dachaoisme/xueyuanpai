//
//  JMMineActivityListViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/14.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMineActivityListViewController.h"

#import "JMMineActivityTableViewCell.h"
#import "JMMineTrainCommonModel.h"
@interface JMMineActivityListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int currentPage;
    int nextPage;
    int pageSize;
    NSMutableArray *dataArray;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMMineActivityListViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    currentPage=nextPage=1;
    pageSize=10;
    dataArray = [NSMutableArray array];
    self.title = @"我的沙龙活动";
    [self createLeftBackNavBtn];
    [self createTableView];
    [self requestData];
    
}
-(void)requestMoreData
{
    nextPage=currentPage+1;
    [self requestData];
}
-(void)requestData
{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance]getMineTrainSalonListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        [self.tableView.footer endRefreshing];
        
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        
        if (listArray.count == 0) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMMineTrainCommonModel *model = [JMMineTrainCommonModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            
        }
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
}
#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[JMMineActivityTableViewCell class] forCellReuseIdentifier:@"JMMineActivityTableViewCell"];
 
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMMineActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMMineActivityTableViewCell"];
    
    JMMineTrainCommonModel * model = [dataArray objectAtIndex:indexPath.section];
    cell.titleLabel.text = model.name;
    cell.subtitleLabel.text = model.job;
    cell.dateLabel.text = model.create_time;
    [cell.locationBtn setTitle:model.colllege_name forState:UIControlStateNormal];
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 220;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0.01;
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