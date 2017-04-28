//
//  JMExpressSiteViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/17.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMExpressSiteViewController.h"

@interface JMExpressSiteViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
    int currentPage;
    int nextPage;
    int pageSize;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMExpressSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"站点";
    currentPage=nextPage=1;
    pageSize=10;
    dataArray = [NSMutableArray array];
    //创建左侧按钮
    [self createLeftBackNavBtn];
    [self createTableView];
    [self requestData];
}
-(void)requestData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [[HttpClient sharedInstance] expressSiteListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [self.tableView.footer endRefreshing];
        
        NSArray * listArray = [model.responseCommonDic objectForKey:@"lists"];
        
        if (listArray.count == 0) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMExpressSiteModel *model = [JMExpressSiteModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            [self.tableView reloadData];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
-(void)requestMoreData
{
    nextPage=currentPage+1;
    [self requestData];
}
#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    JMExpressSiteModel *model = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text =model.site_name;
    
    return cell;
    
}
//点击跳转详情视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.returnBlock([dataArray objectAtIndex:indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
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
