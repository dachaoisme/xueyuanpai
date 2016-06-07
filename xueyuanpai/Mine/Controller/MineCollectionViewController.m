//
//  MineCollectionViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MineCollectionViewController.h"

#import "UniversityAssnHeaderView.h"
#import "MineCollectionSubViewController.h"
@interface MineCollectionViewController ()<UniversityAssnHeaderViewDelegate>
{
    MineCollectionSubViewController * projectVC;
    MineCollectionSubViewController * timeBankVC;
    MineCollectionSubViewController * jobMarketVC;
    MineCollectionSubViewController * giftExchangeVC;
    MineCollectionSubViewController * tutorVC;
}
@end

@implementation MineCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的收藏";
    
    [self createLeftBackNavBtn];
    
    
    [self createHeadView];
}

#pragma mark - 创建头部视图样式
- (void)createHeadView{
    NSArray *arrar = [NSArray arrayWithObjects:@"项目",@"时间银行",@"二手物品",@"兑换礼品",@"导师", nil];
    UniversityAssnHeaderView *headerView = [[UniversityAssnHeaderView alloc]initWithFrame:CGRectMake(20, NAV_TOP_HEIGHT, SCREEN_WIDTH - 40, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.type = PiecewiseInterfaceTypeMobileLin;
    headerView.delegate = self;
    headerView.textFont = [UIFont systemFontOfSize:14];
    headerView.textNormalColor = [UIColor blackColor];
    headerView.textSeletedColor = [CommonUtils colorWithHex:@"00BEAF"];
    headerView.linColor = [CommonUtils colorWithHex:@"00BEAF"];
    [headerView loadTitleArray:arrar];
    [self.view addSubview:headerView];
    
    projectVC = [[MineCollectionSubViewController alloc]init];
    projectVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
    projectVC.superViewController = self;
    projectVC.mineType = 1;
    [self.view addSubview:projectVC.view];
    
}

#pragma mark - UniversityAssnHeaderViewDelegate代理方法
#pragma mark - 点击每个选项卡响应的方法
- (void)headerViewSelctAction:(UniversityAssnHeaderView *)headerView index:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            if (!projectVC) {
                projectVC = [[MineCollectionSubViewController alloc]init];
                projectVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                projectVC.superViewController = self;
                projectVC.mineType = MineTypeOfProject;
                [self.view addSubview:projectVC.view];
            }
            //项目
            projectVC.view.hidden = NO;
            timeBankVC.view.hidden = YES;
            jobMarketVC.view.hidden = YES;
            giftExchangeVC.view.hidden = YES;
            tutorVC.view.hidden = YES;
            
        }
            break;
        case 1:
        {
            if (!timeBankVC) {
                timeBankVC = [[MineCollectionSubViewController alloc]init];
                timeBankVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                timeBankVC.superViewController = self;
                timeBankVC.mineType = MineTypeOfTimeBank;
                [self.view addSubview:timeBankVC.view];
            }
            
            //时间银行
            projectVC.view.hidden = YES;
            timeBankVC.view.hidden = NO;
            jobMarketVC.view.hidden = YES;
            giftExchangeVC.view.hidden = YES;
            tutorVC.view.hidden = YES;
        }
            break;
        case 2:
        {
            if (!jobMarketVC) {
                jobMarketVC = [[MineCollectionSubViewController alloc]init];
                jobMarketVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                jobMarketVC.superViewController = self;
                jobMarketVC.mineType = MineTypeOfJobMarket;
                [self.view addSubview:jobMarketVC.view];
            }
            
            //二手物品
            projectVC.view.hidden = YES;
            timeBankVC.view.hidden = YES;
            jobMarketVC.view.hidden = NO;
            giftExchangeVC.view.hidden = YES;
            tutorVC.view.hidden = YES;
        }
            break;
            
        case 3:
        {
            if (!giftExchangeVC) {
                giftExchangeVC = [[MineCollectionSubViewController alloc]init];
                giftExchangeVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                giftExchangeVC.superViewController = self;
                giftExchangeVC.mineType = MineTypeOfGiftExchange;
                [self.view addSubview:giftExchangeVC.view];
            }
            //兑换礼品
            projectVC.view.hidden = YES;
            timeBankVC.view.hidden = YES;
            jobMarketVC.view.hidden = YES;
            giftExchangeVC.view.hidden = NO;
            tutorVC.view.hidden = YES;
        }
            break;
        case 4:
        {
            if (!tutorVC) {
                tutorVC = [[MineCollectionSubViewController alloc]init];
                tutorVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                tutorVC.superViewController = self;
                tutorVC.mineType = MineTypeOfTutor;
                [self.view addSubview:tutorVC.view];
            }
            //导师
            projectVC.view.hidden = YES;
            timeBankVC.view.hidden = YES;
            jobMarketVC.view.hidden = YES;
            giftExchangeVC.view.hidden = YES;
            tutorVC.view.hidden = NO;
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
