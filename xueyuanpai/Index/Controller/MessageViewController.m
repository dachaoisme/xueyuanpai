//
//  MessageViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MessageViewController.h"

#import "MessageTableViewCell.h"

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息";
    
    [self createLeftBackNavBtn];
    
    
    [self createTableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self theTabBarHidden:YES];
    
    [super viewWillAppear:animated];
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    //注册cell
    [tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"cell"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        cell.leftImageView.image = [UIImage imageNamed:@"msg_icon_system"];
        cell.contentLabel.text = @"系统通知";
        
    }else if (indexPath.row == 1) {
        
        cell.leftImageView.image = [UIImage imageNamed:@"msg_icon_deliver"];
        cell.contentLabel.text = @"快递消息";
        
    }else if (indexPath.row == 2) {
        cell.leftImageView.image = [UIImage imageNamed:@"msg_icon_startup"];
        cell.contentLabel.text = @"创业消息";
        
    }else if (indexPath.row == 3) {
        cell.leftImageView.image = [UIImage imageNamed:@"msg_icon_mail"];
        cell.contentLabel.text = @"站内消息";
        
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
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
