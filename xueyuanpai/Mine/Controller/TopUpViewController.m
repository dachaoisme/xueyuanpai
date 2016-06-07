//
//  TopUpViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TopUpViewController.h"

#import "TopUpTableViewCell.h"
#import "TopUpTwoTableViewCell.h"

@interface TopUpViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;


@end

@implementation TopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"充值";
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
    
    
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    
    //确定按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [button setTitle:@"充值" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(topUpAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [backGroundView addSubview:button];

    self.tableView.tableFooterView = backGroundView;
    
    
    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"TopUpTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"TopUpTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
   
}

#pragma mark - 充值
- (void)topUpAction{
    [CommonUtils showToastWithStr:@"充值"];
}

#pragma mark - tableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        TopUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        
        
        return cell;
        
    }else{
        
        if (indexPath.row == 0) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.text = @"提现到";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            cell.textLabel.textColor = [UIColor lightGrayColor];
            
            
            return cell;
            
        }else if(indexPath.row == 1){
            TopUpTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            
            cell.payImageView.image = [UIImage imageNamed:@"acount_icon_wechat"];
            cell.payWay.text = @"微信支付";
            [cell.payStatusButton setBackgroundImage:[UIImage imageNamed:@"pay_checkbox"] forState:UIControlStateNormal];
            
            return cell;
        }else {
            TopUpTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            
            cell.payImageView.image = [UIImage imageNamed:@"acount_icon_alipay"];
            cell.payWay.text = @"支付宝支付";
            [cell.payStatusButton setBackgroundImage:[UIImage imageNamed:@"pay_checkbox_empty"] forState:UIControlStateNormal];
            

            
            return cell;
        }

        
    }
    
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 42;
    }else{
        
        return 48;
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
