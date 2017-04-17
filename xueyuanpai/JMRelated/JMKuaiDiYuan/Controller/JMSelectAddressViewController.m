//
//  JMSelectAddressViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSelectAddressViewController.h"

#import "JMSelectAddressTableViewCell.h"

#import "JMAddOrEditViewController.h"

@interface JMSelectAddressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMSelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择地址";
    
    
    [self createLeftBackNavBtn];
    
    
    //创建收获地址静态界面
    [self createTableView];
    
    

}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerClass:[JMSelectAddressTableViewCell class] forCellReuseIdentifier:@"JMSelectAddressTableViewCell"];
    
    
    //在最底部添加增加收获地址
    UIButton *addAdressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addAdressBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    addAdressBtn.backgroundColor = [UIColor whiteColor];
    [addAdressBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    [addAdressBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addAdressBtn setTitleColor:[CommonUtils colorWithHex:@"00c05c"] forState:UIControlStateNormal];
    addAdressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addAdressBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAdressBtn];

}

- (void)addAddress{
    
    JMAddOrEditViewController *addVC = [[JMAddOrEditViewController alloc] init];
    addVC.title = @"新增地址";
    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMSelectAddressTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSelectAddressTableViewCell"];
    [cell.editBtn addTarget:self action:@selector(editAdress:) forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag = indexPath.row;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMAddOrEditViewController *editVC = [[JMAddOrEditViewController alloc] init];
    editVC.title = @"编辑地址";
    [self.navigationController pushViewController:editVC animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 72;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

-(void)editAdress:(UIButton *)sender
{
    
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
