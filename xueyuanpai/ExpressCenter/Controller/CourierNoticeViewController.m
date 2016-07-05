//
//  CourierNoticeViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "CourierNoticeViewController.h"

#import "CourierNoticeTableViewCell.h"
#import "ExpressCenterModel.h"
@interface CourierNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ExpressCenterReceiveMessageModel *expressInforModel;
    NSMutableArray * modelArray;
    NSString *totalMessageCount ;///总的消息数
    NSString *unReadyMessageCount;///未读消息数
    NSInteger pageSize;
    NSInteger pageNum;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation CourierNoticeViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [self theTabBarHidden:YES];
    self.callback();

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"快递通知";
    pageSize = 10;
    pageNum = 1;
    modelArray = [NSMutableArray array];
    [self createLeftBackNavBtn];
    
    [self createTableView];
    [self requestExpressMessageList];
}

- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"CourierNoticeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}


#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourierNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ExpressCenterReceiveMessageModel * model = [modelArray objectAtIndex:indexPath.row];
    cell.contentLable.text = model.ExpressCenterReceiveMessageMsg;
    cell.timeLabel.text = model.ExpressCenterReceiveMessageTime;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 125;
}


///发送快递记录
-(void)requestExpressMessageList
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    ///发快递序号
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",pageSize] forKey:@"size"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance]receivedNotificationAndExpressListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                expressInforModel = [[ExpressCenterReceiveMessageModel alloc]initWithDic:smallDic];
                
                [modelArray addObject:expressInforModel];
            }
            
            totalMessageCount = [responseModel.responseCommonDic stringForKey:@"cnt"];
            unReadyMessageCount = [responseModel.responseCommonDic stringForKey:@"unreadcnt"];
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
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    
}
-(void)requestMoreData
{
    pageNum = pageNum+1;
    [self requestExpressMessageList];
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
