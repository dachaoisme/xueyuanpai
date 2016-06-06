//
//  MineBankViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MineBankViewController.h"

#import "UniversityAssnHeaderView.h"

#import "TimeBankTableViewCell.h"
#import "TimeBankDetailViewController.h"


@interface MineBankViewController ()<UniversityAssnHeaderViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MineBankViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"我的时间银行";
    
    [self createLeftBackNavBtn];
    
    //创建头的显示样式
    [self createHeadView];
    
    [self createTableView];

}

#pragma mark - 创建头部视图样式
- (void)createHeadView{
    NSArray *arrar = [NSArray arrayWithObjects:@"正在进行",@"已经完成",@"已过期",@"我申领的", nil];
    UniversityAssnHeaderView *headerView = [[UniversityAssnHeaderView alloc]initWithFrame:CGRectMake(20, 64, SCREEN_WIDTH - 40, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.type = PiecewiseInterfaceTypeMobileLin;
    headerView.delegate = self;
    headerView.textFont = [UIFont systemFontOfSize:14];
    headerView.textNormalColor = [UIColor blackColor];
    headerView.textSeletedColor = [CommonUtils colorWithHex:@"00BEAF"];
    headerView.linColor = [CommonUtils colorWithHex:@"00BEAF"];
    [headerView loadTitleArray:arrar];
    [self.view addSubview:headerView];
    
    
    
}

#pragma mark - UniversityAssnHeaderViewDelegate代理方法
#pragma mark - 点击每个选项卡响应的方法
- (void)headerViewSelctAction:(UniversityAssnHeaderView *)headerView index:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            
            //正在进行
        }
            break;
        case 1:
        {
            //已经完成
            
        }
            break;
        case 2:
        {
            //已经过期
            
        }
            break;

        case 3:
        {
            //我申领的
            
        }
            break;
        default:
            break;
    }
    
}


#pragma mark - tableview UITableViewDataSource,UITableViewDelegate
-(void)createTableView
{
    
    float height = 50;
    //初始化tableView
    CGRect rc = self.view.bounds;
    rc.origin.y = NAV_TOP_HEIGHT+height;
    rc.size.height = SCREEN_HEIGHT-NAV_TOP_HEIGHT-height;
    UITableView * tableView    = [[UITableView alloc]initWithFrame:rc style:UITableViewStylePlain];
    tableView.backgroundColor  = [CommonUtils colorWithHex:@"f3f3f3"];
    tableView.separatorInset   = UIEdgeInsetsZero;
    tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    tableView.dataSource       = self;
    tableView.delegate         = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"TimeBankTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //游玩日期
    return 120;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //游玩日期
    NSString * cellResuable = [NSString stringWithFormat:@"cell"];
    TimeBankTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellResuable forIndexPath:indexPath];
    
//    TimeBankModel * timeBankModel = [timeBankModelListArr objectAtIndex:indexPath.row];
//    [cell setContentViewWithModel:timeBankModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    TimeBankModel * model = [timeBankModelListArr objectAtIndex:indexPath.row];
    //点击进入时间银行详情
    TimeBankDetailViewController *detailVC = [[TimeBankDetailViewController alloc] init];
//    detailVC.timeBankId = model.timeBankId;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    
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
