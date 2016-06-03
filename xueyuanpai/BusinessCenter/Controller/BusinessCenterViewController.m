//
//  BusinessCenterViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessCenterViewController.h"

#import "SchoolColumnView.h"

#import "BusinessCenterOneStyleTableViewCell.h"
#import "BusinessCenterTwoStyleTableViewCell.h"
#import "BusinessCenterTableViewCell.h"

#import "BusinessNewsViewController.h"
#import "BusinessProjectViewController.h"

#import "BusinessTeacherDetailViewController.h"



@interface BusinessCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation BusinessCenterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self theTabBarHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"创业中心"];
    
    //创建导航栏右侧按钮
    [self creatRightNavWithTitle:@"发布项目"];
    
    
    //创建tableView
    [self createTableView];

}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //注册cell
    
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessCenterOneStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessCenterTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessCenterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
    //创建tableView的headerView
    [self createHeaderView];
    
}

#pragma mark - 创建tabview的headerView
- (void)createHeaderView{
    UIView *showColumView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 90)];
    showColumView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = showColumView;
    
    //初始化三个按钮
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 70*4)/5;
    SchoolColumnView *columnView1 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width, 10, 80, 100)];
    columnView1.columnImageView.image = [UIImage imageNamed:@"startup_icon_news"];
    columnView1.columnTitileLable.text = @"创业新闻";
    [showColumView addSubview:columnView1];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action:)];
    [columnView1 addGestureRecognizer:tap1];
    
    
    
    SchoolColumnView *columnView2 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*2 + 80, 10, 80, 100)];
    columnView2.columnImageView.image = [UIImage imageNamed:@"startup_icon_contest"];
    columnView2.columnTitileLable.text = @"创业大赛";
    columnView2.tag = 101;
    [showColumView addSubview:columnView2];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action:)];
    [columnView2 addGestureRecognizer:tap2];
    
    
    
    SchoolColumnView *columnView3 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*3 + 80*2, 10, 80, 100)];
    columnView3.columnImageView.image = [UIImage imageNamed:@"startup_icon_lecture"];
    columnView3.columnTitileLable.text = @"创业讲堂";
    columnView3.tag = 102;
    [showColumView addSubview:columnView3];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3Action:)];
    [columnView3 addGestureRecognizer:tap3];
    
    
    SchoolColumnView *columnView4 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*4 + 80*3, 10, 80, 100)];
    columnView4.columnImageView.image = [UIImage imageNamed:@"startup_icon_project"];
    columnView4.columnTitileLable.text = @"创业项目";
    columnView4.tag = 102;
    [showColumView addSubview:columnView4];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap4Action:)];
    [columnView4 addGestureRecognizer:tap4];

}

#pragma mark - 轮播图下方三个小按钮点击响应的方法
-(void) tap1Action:(UITapGestureRecognizer*) tap {
    
    //    [CommonUtils showToastWithStr:@"创业新闻"];
    
    BusinessNewsViewController *newsVC = [[BusinessNewsViewController alloc] init];
    
    newsVC.title = @"创业新闻";
    newsVC.index = 100;
    [self.navigationController pushViewController:newsVC animated:YES];
    
}
-(void) tap2Action:(UITapGestureRecognizer*) tap {
    
    //    [CommonUtils showToastWithStr:@"创业大赛"];
    
    BusinessNewsViewController *newsVC = [[BusinessNewsViewController alloc] init];
    
    newsVC.title = @"创业大赛";
    newsVC.index = 101;
    
    [self.navigationController pushViewController:newsVC animated:YES];
    
}
-(void) tap3Action:(UITapGestureRecognizer*) tap {
    
    //    [CommonUtils showToastWithStr:@"创业讲堂"];
    
    
    BusinessNewsViewController *newsVC = [[BusinessNewsViewController alloc] init];
    
    newsVC.title = @"创业讲堂";
    newsVC.index = 102;
    
    [self.navigationController pushViewController:newsVC animated:YES];
    
}

-(void) tap4Action:(UITapGestureRecognizer*) tap {
    
    //    [CommonUtils showToastWithStr:@"创业项目"];
    
    BusinessProjectViewController *projectVC = [[BusinessProjectViewController alloc] init];
    
    [self.navigationController pushViewController:projectVC animated:YES];
    
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            BusinessCenterOneStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;

        }else{
            
            BusinessCenterTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            return cell;
        }

    }else {
        
        if (indexPath.row == 0) {
            BusinessCenterOneStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleLabel.text = @"创业项目";

            
            return cell;
            
        }else{
            
            BusinessCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            return cell;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 45;
    }else{
        
        return 200;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        //跳转导师详情
        
        BusinessTeacherDetailViewController *teacherVC = [[BusinessTeacherDetailViewController alloc] init];
        
        [self.navigationController pushViewController:teacherVC animated:YES];
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
