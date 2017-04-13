//
//  JMCollectCourierListViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCollectCourierListViewController.h"

#import "JMCollectCourierListTableViewCell.h"

@interface JMCollectCourierListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMCollectCourierListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"收取快递";
    
    //创建当前列表视图
    [self createTableView];

}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,50, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
   
    [_tableView registerClass:[JMCollectCourierListTableViewCell class] forCellReuseIdentifier:@"JMCollectCourierListTableViewCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JMCollectCourierListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMCollectCourierListTableViewCell"];
    
    if (indexPath.row == 2) {
        
        ///已取件状态的设置
        cell.showHaveTakeLabel.hidden = NO;
        cell.showExpressArkLabel.hidden = YES;
        
    }else{
        
        //等待取件状态的设置
        cell.showHaveTakeLabel.hidden = YES;
        cell.showExpressArkLabel.hidden = NO;
        

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
