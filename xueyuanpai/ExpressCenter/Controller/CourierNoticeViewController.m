//
//  CourierNoticeViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "CourierNoticeViewController.h"

#import "CourierNoticeTableViewCell.h"

@interface CourierNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation CourierNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"快递通知";
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
}

- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"CourierNoticeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}


#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourierNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 125;
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
