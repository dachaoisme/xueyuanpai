//
//  MyWalletViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MyWalletViewController.h"

#import "MineIntegralTableViewCell.h"

#import "ExchangeGiftsViewController.h"

#import "TopUpViewController.h"
#import "WithdrawalViewController.h"


@interface MyWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic) CGPoint inputPoint0;
@property (nonatomic) CGPoint inputPoint1;

@property (nonatomic) UIColor *inputColor0;
@property (nonatomic) UIColor *inputColor1;

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的钱包";
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
    //创建底部视图
    [self createFootView];
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //注册cell
    
    //注册cell
    
    [tableView registerClass:[MineIntegralTableViewCell class] forCellReuseIdentifier:@"oneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"MineIntegralTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    
    
    [self createTableViewHeaderView];
    
    
    
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
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    backGroundView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:backGroundView];
    
    
    //剩余金钱
    UILabel *myWalletLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 30, 33, 60, 14)];
    myWalletLabel.font = [UIFont systemFontOfSize:14];
    myWalletLabel.text = @"我的余额";
    myWalletLabel.textColor = [CommonUtils colorWithHex:@"f8f8f8"];
    [backGroundView addSubview:myWalletLabel];
    
    
    //剩余积分
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(myWalletLabel.frame), CGRectGetMaxY(myWalletLabel.frame)+10, CGRectGetWidth(myWalletLabel.frame), 42)];
    moneyLabel.font = [UIFont systemFontOfSize:30];
    moneyLabel.text = @"234";
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.textColor = [CommonUtils colorWithHex:@"f8f8f8"];
    [backGroundView addSubview:moneyLabel];
    
    
    
    
    
    
    
}

#pragma mark - 创建底部视图
- (void)createFootView{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 48, SCREEN_WIDTH, 48)];
    [self.view addSubview:footView];
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 48);
    [leftButton setTitle:@"充值" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    leftButton.font = [UIFont systemFontOfSize:14];
    [footView addSubview:leftButton];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 48);
    
    [rightButton setTitle:@"提现" forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor whiteColor];
    [rightButton setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    rightButton.font = [UIFont systemFontOfSize:14];
    [footView addSubview:rightButton];
    
    
    
}

#pragma mark - 充值的响应方法
- (void)leftButtonAction{
    
//    [CommonUtils showToastWithStr:@"充值"];
    
    TopUpViewController *topUpVC = [[TopUpViewController alloc] init];
    [self.navigationController pushViewController:topUpVC animated:YES];
    
    
}


#pragma mark - 提现的响应方法
- (void)rightButtonAction{
    
//    [CommonUtils showToastWithStr:@"提现"];
    
    WithdrawalViewController *withdrawalVC = [[WithdrawalViewController alloc] init];
    
    [self.navigationController pushViewController:withdrawalVC animated:YES];
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        cell.textLabel.text = @"交易记录";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.textColor = [UIColor lightGrayColor];
        
        
        return cell;
        
    }else{
        MineIntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        
        
        
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
