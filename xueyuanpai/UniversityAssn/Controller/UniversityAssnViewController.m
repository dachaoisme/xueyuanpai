//
//  UniversityAssnViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/21.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "UniversityAssnViewController.h"

#import "UniversityAssnHeaderView.h"
#import "HotActivityTableViewCell.h"
#import "StarCommunityTableViewCell.h"

#define kNavigationBarHeight 64

@interface UniversityAssnViewController ()<UniversityAssnHeaderViewDelegate,UITableViewDataSource,UITableViewDelegate>

///设置头部选项卡视图
@property (nonatomic,strong)UniversityAssnHeaderView *headerView;


///用于记录点击的是哪个选项卡
@property (nonatomic,assign)NSInteger index;

///用于显示的列表
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation UniversityAssnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTitle:@"大学"];
    
    //创建headerView的三个选项框
    [self createHeaderView];
    
    //创建tableView
    [self createTableView];
}

#pragma mark - 创建headerView
- (void)createHeaderView{
    
    NSArray *arrar = [NSArray arrayWithObjects:@"热门活动",@"明星社团",@"社团纳新", nil];
    UniversityAssnHeaderView *headerView = [[UniversityAssnHeaderView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, [UIScreen mainScreen].bounds.size.width, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.type = PiecewiseInterfaceTypeMobileLin;
    headerView.delegate = self;
    headerView.textFont = [UIFont systemFontOfSize:18];
    headerView.textNormalColor = [UIColor blackColor];
    headerView.textSeletedColor = [CommonUtils colorWithHex:@"00BEAF"];
    headerView.linColor = [CommonUtils colorWithHex:@"00BEAF"];
    [headerView loadTitleArray:arrar];
    [self.view addSubview:headerView];
    self.headerView = headerView;

    
}

#pragma mark - UniversityAssnHeaderViewDelegate代理方法
#pragma mark - 点击每个选项卡响应的方法
- (void)headerViewSelctAction:(UniversityAssnHeaderView *)headerView index:(NSInteger)index{
    
    self.index = index;
    
    switch (index) {
        case 0:
        {
            NSLog(@"点击热门活动");
        }
            break;
        case 1:
        {
            NSLog(@"点击明星社团");
        }
            break;
        case 2:
        {
            NSLog(@"点击社团招纳");
        }
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];

    
}

#pragma mark - 创建tableView
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetHeight(self.headerView.frame) - kNavigationBarHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (self.index) {
        case 0:{
            HotActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotActivityTableViewCell"];
            if (!cell) {
                cell = [[HotActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HotActivityTableViewCell"];
            }
            
            return cell;

        }
            break;
        case 1:{
            
            StarCommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StarCommunityTableViewCell"];
            if (!cell) {
                cell = [[StarCommunityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StarCommunityTableViewCell"];
            }

            return cell;
        }
            break;
        case 2:{
            
            HotActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotActivityTableViewCell1"];
            if (!cell) {
                cell = [[HotActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HotActivityTableViewCell1"];
            }
            
            return cell;

        }
            break;
            
        default:{
            HotActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotActivityTableViewCell2"];
            if (!cell) {
                cell = [[HotActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HotActivityTableViewCell2"];
            }
            
            return cell;

        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (self.index) {
        case 0:{
            return 280;
        }
            break;
        case 1:{
            
            return 80;
        }
            break;
        case 2:{
            return 280;
        }
            break;
            
        default:{
            return 280;
        }
            break;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
