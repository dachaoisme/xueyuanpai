//
//  MineIntegralViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MineIntegralViewController.h"

#import "MineIntegralTableViewCell.h"

#import "ExchangeGiftsViewController.h"

@interface MineIntegralViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    int pageNum;
    int pageSize;
    NSMutableArray * pointModelListArr;
    
    NSString *totalPoint;
    NSString *remainderPoints;
    ///剩余积分
    UILabel *moneyLabel;
    ///已兑换积分
    UILabel *integralLabel;
    
}
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic) CGPoint inputPoint0;
@property (nonatomic) CGPoint inputPoint1;

@property (nonatomic) UIColor *inputColor0;
@property (nonatomic) UIColor *inputColor1;

@end

@implementation MineIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的积分";
    pageNum = 1;
    pageSize = 10;
    pointModelListArr = [NSMutableArray array];
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
    //创建底部视图
    [self createFootView];
    
    [self requestToGetIntegralList];
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //注册cell
    [tableView registerClass:[MineIntegralTableViewCell class] forCellReuseIdentifier:@"oneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"MineIntegralTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    [self createTableViewHeaderView];
    
    
    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];

}

- (void)createTableViewHeaderView{
    
    //设置顶部视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    _inputColor0 = [CommonUtils colorWithHex:@"2eeabd"];
    _inputColor1 = [CommonUtils colorWithHex:@"00beaf"];
    _inputPoint0 = CGPointMake(0, 0);
    _inputPoint1 = CGPointMake(SCREEN_WIDTH, 120);
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[(__bridge id)_inputColor0.CGColor, (__bridge id)_inputColor1.CGColor];
    layer.startPoint = _inputPoint0;
    layer.endPoint = _inputPoint1;
    layer.frame = headerView.bounds;
    [headerView.layer addSublayer:layer];
    self.tableView.tableHeaderView = headerView;

    //创建左侧背景视图
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2-1, 120)];
    leftView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:leftView];
    
    //创建中间的竖线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) + 1, (CGRectGetHeight(headerView.frame) - 60)/2, 1, 60)];
    lineView.backgroundColor = [CommonUtils colorWithHex:@"cccccc"];
    [headerView addSubview:lineView];
    
    //创建右侧视图
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame), 0, SCREEN_WIDTH/2, 120)];
    rightView.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:rightView];
    
    //
    UILabel *myWalletLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(leftView.frame) / 2 - 30, 33, 60, 14)];
    myWalletLabel.font = [UIFont systemFontOfSize:14];
    myWalletLabel.text = @"剩余积分";
    myWalletLabel.textColor = [CommonUtils colorWithHex:@"f8f8f8"];
    [leftView addSubview:myWalletLabel];
    
    //剩余积分
    moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(myWalletLabel.frame), CGRectGetMaxY(myWalletLabel.frame)+10, CGRectGetWidth(myWalletLabel.frame), 42)];
    moneyLabel.font = [UIFont systemFontOfSize:30];
    moneyLabel.text = @"234";
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.textColor = [CommonUtils colorWithHex:@"f8f8f8"];
    [leftView addSubview:moneyLabel];
    
    //创建右侧视图的两个label
    UILabel *jifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(rightView.frame) / 2 - 35, 33, 70, 14)];
    jifenLabel.font = [UIFont systemFontOfSize:14];
    jifenLabel.textColor = [CommonUtils colorWithHex:@"f8f8f8"];
    jifenLabel.text = @"已兑换积分";
    [rightView addSubview:jifenLabel];
    
    //兑换积分
    integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(jifenLabel.frame), CGRectGetMaxY(jifenLabel.frame)+10, CGRectGetWidth(jifenLabel.frame), 42)];
    integralLabel.font = [UIFont systemFontOfSize:30];
    integralLabel.text = @"0";
    integralLabel.textAlignment = NSTextAlignmentCenter;
    integralLabel.textColor = [CommonUtils colorWithHex:@"f8f8f8"];
    [rightView addSubview:integralLabel];
    
}
#pragma mark - 创建底部视图
- (void)createFootView{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 48, SCREEN_WIDTH, 48)];
    [self.view addSubview:footView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 48);
    [leftButton addTarget:self action:@selector(leftButtonExchangeByPoint:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"去积分商城兑换" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [footView addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 48);
    [rightButton setTitle:@"已兑换礼品" forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor whiteColor];
    [rightButton setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [footView addSubview:rightButton];
}
#pragma mark - 已兑换礼品按钮的响应方法
-(void)leftButtonExchangeByPoint:(UIButton *)sender
{
    BigToSendViewController * bigToSendVC = [[BigToSendViewController alloc]init];
    [self.navigationController pushViewController:bigToSendVC animated:YES];
}
- (void)rightButtonAction{
    //已兑换礼品界面
    ExchangeGiftsViewController *giftsListVC = [[ExchangeGiftsViewController alloc] init];
    [self.navigationController pushViewController:giftsListVC animated:YES];
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return pointModelListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        cell.textLabel.text = @"积分记录";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        return cell;
        
    }else{
        MineIntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        MinePointModel  *model = [pointModelListArr objectAtIndex:indexPath.row-1];
        cell.titleLabel.text = model.minePointMsg;
        cell.dateLabel.text = model.minePointCreateTime;
        if ([model.minePointNumber intValue] > 0) {
            cell.integralLabel.text = [NSString stringWithFormat:@"+%@",model.minePointNumber];

        }
        cell.integralLabel.textColor = [CommonUtils colorWithHex:@"00beaf"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 42;
    }else{
        
        return 80;
    }
}

-(void)requestToGetIntegralList
{

    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]mineToGetPointsListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                MinePointModel * model = [[MinePointModel alloc]initWithDic:smallDic];
                [pointModelListArr addObject:model];
            }
            ///总积分
            totalPoint = [responseModel.responseCommonDic stringForKey:@"exchange"];
            ///剩余积分
            remainderPoints = [responseModel.responseCommonDic stringForKey:@"integralLeft"];
            integralLabel.text = totalPoint;
            moneyLabel.text = remainderPoints;
            
            ///处理上拉加载更多逻辑
            if (pageNum>=[pageModel.responsePageTotalCount integerValue]) {
                //说明是最后一张
                self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
            }
            [self.tableView reloadData];
        }else{
            
        }
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
-(void)requestMoreData
{
    pageNum = pageNum+1;
    [self requestToGetIntegralList];
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
