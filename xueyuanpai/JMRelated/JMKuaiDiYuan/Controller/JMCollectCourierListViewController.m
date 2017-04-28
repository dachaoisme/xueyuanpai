//
//  JMCollectCourierListViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCollectCourierListViewController.h"

#import "JMCollectCourierListTableViewCell.h"
#import "JMKuaiDiYuanModel.h"
@interface JMCollectCourierListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
    int currentPage;
    int nextPage;
    int pageSize;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMCollectCourierListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"收取快递";
    nextPage=currentPage=0;
    dataArray =[NSMutableArray array];
    //创建当前列表视图
    [self createTableView];
    
    ///
    [self requestData];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)requestData
{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance]getExpressReceiveListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        [self.tableView.footer endRefreshing];
        currentPage=nextPage;
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMKuaiDiYuanReceiveModel *model = [JMKuaiDiYuanReceiveModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            
        }
        /*
        JMKuaiDiYuanReceiveLogModel *logModel =[[JMKuaiDiYuanReceiveLogModel alloc] init];
        logModel.msg = @"已经到了入库的地方";
        logModel.order_sn = @"123432123";
        logModel.create_time = @"2017-4-21";
        NSArray *array = [NSArray arrayWithObject:logModel];
        JMKuaiDiYuanReceiveModel *model = [[JMKuaiDiYuanReceiveModel alloc]init];
        model.order_sn = @"123432123";
        model.express_compay = @"圆通快递";
        model.status = @"等待收件";
        model.logs = array;
        [dataArray addObject:model];
         */
        if (currentPage==[pageModel.responsePageTotalCount intValue]) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        
        [self.tableView reloadData];
        ///如果没有数据，则加载空数据页面
        if (dataArray.count==0) {
            self.tableView.hidden = YES;
            [CommonView emptyViewWithView:self.view];
        }
    } withFaileBlock:^(NSError *error) {
        if (dataArray.count==0) {
            self.tableView.hidden = YES;
            [CommonView emptyViewWithView:self.view];
        }
    }];
}
-(void)requestMoreData
{
    nextPage=currentPage+1;
    [self requestData];
}
#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:_tableView];
    
   
    [_tableView registerClass:[JMCollectCourierListTableViewCell class] forCellReuseIdentifier:@"JMCollectCourierListTableViewCell"];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JMCollectCourierListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMCollectCourierListTableViewCell"];
    JMKuaiDiYuanReceiveModel *model = [dataArray objectAtIndex:indexPath.row];
    JMKuaiDiYuanReceiveLogModel *logModel;
    if (model.logs &&model.logs.count>0) {
        logModel= [model.logs firstObject];
    }
    
    cell.showCourierNumberLabel.text = model.order_sn;
    cell.showStatuesLabel.text = model.status;
    cell.showExpressArkLabel.text = model.express_compay;
    if (logModel) {
        cell.showSiteLabel.text =logModel.msg;
    }
    
    if ([model.status isEqualToString:@"等待取件"]) {
        //等待取件状态的设置
        cell.showHaveTakeLabel.hidden = YES;
        cell.showExpressArkLabel.hidden = NO;

    }else{
        
        ///已取件状态的设置
        cell.showHaveTakeLabel.hidden = NO;
        cell.showExpressArkLabel.hidden = YES;
        
    }
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
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
