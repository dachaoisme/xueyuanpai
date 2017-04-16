//
//  JMKongJianHomePageViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/15.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMKongJianHomePageViewController.h"

#import "BulkGoodsLunBoView.h"
#import "JMHomePageThreeTypeTableViewCell.h"

#import "JMCourseDetailsViewController.h"
#import "JMXianXiaCourseDetailsViewController.h"
@interface JMKongJianHomePageViewController ()<UITableViewDataSource,UITableViewDelegate>

///列表
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMKongJianHomePageViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"集梦空间";
    [self createLeftBackNavBtn];
    //创建当前列表视图
    [self createTableView];
    
    
}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[JMHomePageThreeTypeTableViewCell class] forCellReuseIdentifier:@"JMHomePageThreeTypeTableViewCell"];
    
}

#pragma mark - 配置顶部的轮播视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //获取轮播图片数组
    BulkGoodsLunBoView *bulkGoodsLunBoView = [[BulkGoodsLunBoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) animationDuration:0];
    NSURL *imageUrl = [NSURL URLWithString:@"http://114.215.111.210:999/backend/web/uploads/20170413/14920592674319.png"];
    NSArray *imageUrlArray = @[imageUrl,imageUrl];
    bulkGoodsLunBoView.fetchContentViewAtIndex = ^NSURL *(NSInteger pageIndex){
        return imageUrlArray[pageIndex];
    };
    bulkGoodsLunBoView.totalPagesCount = ^NSInteger(void){
        return imageUrlArray.count;
    };
    
    return bulkGoodsLunBoView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMHomePageThreeTypeTableViewCell *threeCell = [tableView dequeueReusableCellWithIdentifier:@"JMHomePageThreeTypeTableViewCell"];
    threeCell.locationBtn.hidden = YES;
    threeCell.peopleNumberLabel.hidden = YES;
    
    return threeCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 160;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //创业课程线上详情
        JMCourseDetailsViewController *courseDetailVC = [[JMCourseDetailsViewController alloc] init];
        
        [self.navigationController pushViewController:courseDetailVC animated:YES];
        
    }else{
        //创业课程线下详情
        JMXianXiaCourseDetailsViewController *xianxiaDetailVC = [[JMXianXiaCourseDetailsViewController alloc] init];
        
        [self.navigationController pushViewController:xianxiaDetailVC animated:YES];
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
