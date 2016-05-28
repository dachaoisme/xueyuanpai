//
//  EmploymentRecruitmentViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "EmploymentRecruitmentViewController.h"

#import "EmploymentRecruitmentTableViewCell.h"

@interface EmploymentRecruitmentViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation EmploymentRecruitmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"就业招聘";
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    //注册cell

    [tableView registerNib:[UINib nibWithNibName:@"EmploymentRecruitmentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}


#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EmploymentRecruitmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
   
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
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
