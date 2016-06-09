//
//  UniversityAssnViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/21.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "UniversityAssnViewController.h"
#import "UniversityAssnHeaderView.h"
#import "UinversityHotActivityViewController.h"
#import "UinversityStarSocietyViewController.h"
#import "UinversitySocietyRecruitmentViewController.h"

@interface UniversityAssnViewController ()<UniversityAssnHeaderViewDelegate>
{
    UinversityHotActivityViewController * hotActivityVC;
    UinversityStarSocietyViewController * starSocietyVC;
    UinversitySocietyRecruitmentViewController *societyRecruitmentVC;
}
///设置头部选项卡视图
@property (nonatomic,strong)UniversityAssnHeaderView *headerView;
///用于记录点击的是哪个选项卡
@property (nonatomic,assign)NSInteger index;

@end

@implementation UniversityAssnViewController

-(void)viewWillAppear:(BOOL)animated{
    [self theTabBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"大学"];
    [self createLeftBackNavBtn];
    
    //创建headerView的三个选项框
    [self createHeaderView];
}
#pragma mark - 创建headerView
- (void)createHeaderView{
    
    NSArray *arrar = [NSArray arrayWithObjects:@"热门活动",@"明星社团",@"社团纳新", nil];
    UniversityAssnHeaderView *headerView = [[UniversityAssnHeaderView alloc]initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, [UIScreen mainScreen].bounds.size.width, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.type = PiecewiseInterfaceTypeMobileLin;
    headerView.delegate = self;
    headerView.textFont = [UIFont systemFontOfSize:14];
    headerView.textNormalColor = [CommonUtils colorWithHex:@"666666"];
    headerView.textSeletedColor = [CommonUtils colorWithHex:@"00BEAF"];
    headerView.linColor = [CommonUtils colorWithHex:@"00BEAF"];
    [headerView loadTitleArray:arrar];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    hotActivityVC = [[UinversityHotActivityViewController alloc]init];
    hotActivityVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
    hotActivityVC.view.backgroundColor = [UIColor redColor];
    hotActivityVC.view.hidden = NO;
    hotActivityVC.superViewController = self;
    [self.view addSubview:hotActivityVC.view];
}

#pragma mark - UniversityAssnHeaderViewDelegate代理方法
#pragma mark - 点击每个选项卡响应的方法
- (void)headerViewSelctAction:(UniversityAssnHeaderView *)headerView index:(NSInteger)index{
    
    self.index = index;
    
    switch (index) {
        case 0:
        {
            //热门活动
            if (!hotActivityVC) {
                hotActivityVC = [[UinversityHotActivityViewController alloc]init];
                hotActivityVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                hotActivityVC.view.hidden = YES;
                hotActivityVC.superViewController = self;
                [self.view addSubview:hotActivityVC.view];
            }
            //项目
            hotActivityVC.view.hidden = NO;
            starSocietyVC.view.hidden = YES;
            societyRecruitmentVC.view.hidden = YES;
        }
            break;
        case 1:
        {
            //明星社团
            if (!starSocietyVC) {
                starSocietyVC = [[UinversityStarSocietyViewController alloc]init];
                starSocietyVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                starSocietyVC.view.hidden = YES;
                starSocietyVC.superViewController = self;
                [self.view addSubview:starSocietyVC.view];
            }
            hotActivityVC.view.hidden = YES;
            starSocietyVC.view.hidden = NO;
            societyRecruitmentVC.view.hidden = YES;
        }
            break;
        case 2:
        {
            //社团纳新
            if (!societyRecruitmentVC) {
                societyRecruitmentVC = [[UinversitySocietyRecruitmentViewController alloc]init];
                societyRecruitmentVC.view.frame = CGRectMake(0, 50+NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-50-NAV_TOP_HEIGHT);
                societyRecruitmentVC.view.hidden = YES;
                societyRecruitmentVC.superViewController = self;
                [self.view addSubview:societyRecruitmentVC.view];
            }
            hotActivityVC.view.hidden = YES;
            starSocietyVC.view.hidden = YES;
            societyRecruitmentVC.view.hidden = NO;
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


@end
