//
//  BusinessClassDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/2.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessClassDetailViewController.h"

#import "BusinessNewsDetailOneStleTableViewCell.h"
#import "BusinessClassDetailTableViewCell.h"

#import "BaoMingViewController.h"

@interface BusinessClassDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BusinessClassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"创业讲堂详情";
    
    [self createLeftBackNavBtn];
    
    
    [self createTableView];
    
    [self createBottomView];


}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"BusinessNewsDetailOneStleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    

    [tableView registerNib:[UINib nibWithNibName:@"BusinessClassDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
}

#pragma mark - 创建底部视图
- (void)createBottomView{
    //创建footView
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
    
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH/3, 40)];
    showLabel.text = @"已报名  168人";
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.font = [UIFont systemFontOfSize:14];
    [footView addSubview:showLabel];
    
    UIButton *baoMingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    baoMingButton.frame = CGRectMake(CGRectGetMaxX(showLabel.frame), 0, SCREEN_WIDTH*2/3, 40);
    baoMingButton.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [baoMingButton setTitle:@"立即报名" forState:UIControlStateNormal];
    [baoMingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [baoMingButton addTarget:self action:@selector(baoMingAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:baoMingButton];
    
    [self.view addSubview:footView];

}

#pragma mark - 立即报名按钮的响方法
- (void)baoMingAction{
    
//    [CommonUtils showToastWithStr:@"立即报名"];
    
    BaoMingViewController *baoMingVC = [[BaoMingViewController alloc] init];
    
    [self.navigationController pushViewController:baoMingVC animated:YES];
}

#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        BusinessNewsDetailOneStleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;

    }else{
        
        BusinessClassDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;

    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }else{
        
        return 200;
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
