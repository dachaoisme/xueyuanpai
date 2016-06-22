//
//  ExchangeGiftsViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ExchangeGiftsViewController.h"

#import "ExchangeGiftsTableViewCell.h"
#import "MineModel.h"
@interface ExchangeGiftsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger pageNum;
    NSInteger pageSize;
    NSMutableArray * dataArr;
}

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ExchangeGiftsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"已兑换礼品";
    pageNum = 1;
    pageSize = 10;
    dataArr = [NSMutableArray array];
    [self createLeftBackNavBtn];
    
    [self createTableView];
    [self requestData];
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //注册cell

    
    [tableView registerNib:[UINib nibWithNibName:@"ExchangeGiftsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    ExchangeGiftsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    MinePointModel * model = [dataArr objectAtIndex:indexPath.row];
    cell.timeLabel.text = model.minePointMsg;
    cell.integralLabel.text = model.minePointNumber;
    cell.timeLabel.text = model.minePointCreateTime;
    [cell.receiveStatus setTitle:model.minePointType forState:UIControlStateNormal];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 68;
}
-(void)requestMoreData
{
    pageNum = pageNum+1;
    [self requestData];
}
-(void)requestData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",pageSize] forKey:@"size"];
    [[HttpClient sharedInstance]mineToGetPointsListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        if (responseModel.responseCode ==ResponseCodeSuccess) {
            ///兑换积分
            NSString  *exchangePoint = [responseModel.responseCommonDic stringForKey:@"exchange"];
            ///剩余积分
            NSString  *integralLeftPoint = [responseModel.responseCommonDic stringForKey:@"exchange"];
            for (NSDictionary *dic in [responseModel.responseCommonDic objectForKey:@"lists"]) {
                MinePointModel * model = [[MinePointModel alloc]initWithDic:dic];
                if ([model.minePointType integerValue]==2) {
                    ///是兑换的类型
                    [dataArr addObject:model];
                }
                
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
