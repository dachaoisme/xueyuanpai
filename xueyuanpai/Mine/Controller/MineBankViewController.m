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

#import "MineBankSubViewController.h"
@interface MineBankViewController ()<UniversityAssnHeaderViewDelegate>
{
    MineBankSubViewController * timeBankNoneApplyVC;
    MineBankSubViewController * timeBankAlreadyApplyVC;
    MineBankSubViewController * timeBankPassVC;
    MineBankSubViewController * timeBankOverdueVC;
    MineBankSubViewController * timeBankCompleteVC;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MineBankViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //将传过来的userID存储起来
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    [accountDefaults setObject:self.user_id forKey:@"timeBank_user_id"];
    

    
    
    self.title = @"我的时间银行";
    
    [self createLeftBackNavBtn];
    
    //创建头的显示样式
    [self createHeadView];
    
}

#pragma mark - 创建头部视图样式
- (void)createHeadView{
    NSArray *arrar = [NSArray arrayWithObjects:@"正在进行",@"已经完成",@"已过期",@"我申领的", nil];
    UniversityAssnHeaderView *headerView = [[UniversityAssnHeaderView alloc]initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.type = PiecewiseInterfaceTypeMobileLin;
    headerView.delegate = self;
    headerView.textFont = [UIFont systemFontOfSize:14];
    headerView.textNormalColor = [CommonUtils colorWithHex:@"999999"];
    headerView.textSeletedColor = [CommonUtils colorWithHex:@"00BEAF"];
    headerView.linColor = [CommonUtils colorWithHex:@"00BEAF"];
    [headerView loadTitleArray:arrar];
    [self.view addSubview:headerView];
    
    
    timeBankAlreadyApplyVC = [[MineBankSubViewController alloc]init];
    timeBankAlreadyApplyVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
    timeBankAlreadyApplyVC.view.hidden = YES;
    timeBankAlreadyApplyVC.superViewController = self;
    timeBankAlreadyApplyVC.mineTimeBankStatus = MineTimeBankAlreadyApplyStatus;
    [self.view addSubview:timeBankAlreadyApplyVC.view];
}

#pragma mark - UniversityAssnHeaderViewDelegate代理方法
#pragma mark - 点击每个选项卡响应的方法
- (void)headerViewSelctAction:(UniversityAssnHeaderView *)headerView index:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            
            //正在进行
            if (!timeBankAlreadyApplyVC) {
                timeBankAlreadyApplyVC = [[MineBankSubViewController alloc]init];
                timeBankAlreadyApplyVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                timeBankAlreadyApplyVC.view.hidden = YES;
                timeBankAlreadyApplyVC.superViewController = self;
                timeBankAlreadyApplyVC.mineTimeBankStatus = MineTimeBankAlreadyApplyStatus;
                [self.view addSubview:timeBankAlreadyApplyVC.view];
            }
            //项目
            timeBankAlreadyApplyVC.view.hidden = NO;
            timeBankCompleteVC.view.hidden = YES;
            timeBankOverdueVC.view.hidden = YES;
            timeBankPassVC.view.hidden = YES;
        }
            break;
        case 1:
        {
            //已经完成
            if (!timeBankCompleteVC) {
                timeBankCompleteVC = [[MineBankSubViewController alloc]init];
                timeBankCompleteVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                timeBankCompleteVC.view.hidden = YES;
                timeBankCompleteVC.superViewController = self;
                timeBankCompleteVC.mineTimeBankStatus = MineTimeBankCompleteStatus;

                [self.view addSubview:timeBankCompleteVC.view];
            }
            timeBankAlreadyApplyVC.view.hidden = YES;
            timeBankCompleteVC.view.hidden = NO;
            timeBankOverdueVC.view.hidden = YES;
            timeBankPassVC.view.hidden = YES;
        }
            break;
        case 2:
        {
            //已经过期
            if (!timeBankOverdueVC) {
                timeBankOverdueVC = [[MineBankSubViewController alloc]init];
                timeBankOverdueVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                timeBankOverdueVC.view.hidden = YES;
                timeBankOverdueVC.superViewController = self;
                timeBankOverdueVC.mineTimeBankStatus = MineTimeBankOverdueStatus;
                [self.view addSubview:timeBankOverdueVC.view];
            }
            timeBankAlreadyApplyVC.view.hidden = YES;
            timeBankCompleteVC.view.hidden = YES;
            timeBankOverdueVC.view.hidden = NO;
            timeBankPassVC.view.hidden = YES;
        }
            break;

        case 3:
        {
            //我申领的
            if (!timeBankPassVC) {
                timeBankPassVC = [[MineBankSubViewController alloc]init];
                timeBankPassVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                timeBankPassVC.view.hidden = YES;
                timeBankPassVC.superViewController = self;
                timeBankPassVC.mineTimeBankStatus = MineTimeBankPassStatus;
                [self.view addSubview:timeBankPassVC.view];
            }
            timeBankAlreadyApplyVC.view.hidden = YES;
            timeBankCompleteVC.view.hidden = YES;
            timeBankOverdueVC.view.hidden = YES;
            timeBankPassVC.view.hidden = NO;
        }
            break;
        default:
            break;
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
