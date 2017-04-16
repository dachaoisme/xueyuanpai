//
//  JMMailDeliveryViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMailDeliveryViewController.h"

#import "JMMailDeliveryOneTypeTableViewCell.h"
#import "JMMailDeliveryTwoTypeTableViewCell.h"

@interface JMMailDeliveryViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMMailDeliveryViewController

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
    
    [_tableView registerClass:[JMMailDeliveryOneTypeTableViewCell class] forCellReuseIdentifier:@"JMMailDeliveryOneTypeTableViewCell"];
    
    [_tableView registerClass:[JMMailDeliveryTwoTypeTableViewCell class] forCellReuseIdentifier:@"JMMailDeliveryTwoTypeTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        JMMailDeliveryOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMMailDeliveryOneTypeTableViewCell"];
        
        
        return cell;
        
    }else{
        
        
        JMMailDeliveryTwoTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMMailDeliveryTwoTypeTableViewCell"];
        
        return cell;
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 66;
    }else{
        
        return 108;

    }
    
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
