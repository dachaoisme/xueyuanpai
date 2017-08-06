//
//  JMMIneSalonRootViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/8/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMIneSalonRootViewController.h"
#import "SGSegmentedControl.h"
#import "JMMineActivityListViewController.h"
#define tabHeight 44
@interface JMMIneSalonRootViewController ()<SGSegmentedControlDefaultDelegate,UIScrollViewDelegate>
{
    
}
@property(nonatomic,strong)SGSegmentedControlBottomView *bottomSView;
@property(nonatomic,strong)SGSegmentedControlDefault*topDefaultSView;
@property(nonatomic,assign)NSInteger chooseIndex;
@end

@implementation JMMIneSalonRootViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的沙龙活动";
    [self createLeftBackNavBtn];
    [self setupScrollView];
}
#pragma mark - 设置一级导航栏滚动标题以及滚动controller相关
- (void)setupScrollView
{
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"已报名", @"已收藏",nil];
    
    NSMutableArray *childVCArray = [NSMutableArray array];
    
    //已报名
    JMMineActivityListViewController   *processingVC = [[JMMineActivityListViewController alloc] init];
    processingVC.stateType = 0;
    [self addChildViewController:processingVC];
    
    
    //已收藏
    JMMineActivityListViewController  *endVC = [[JMMineActivityListViewController alloc] init];
    endVC.stateType = 1;
    [self addChildViewController:endVC];
    
    
    [childVCArray addObject:processingVC];
    [childVCArray addObject:endVC];
    
    
    [self initScrollViewTitleWithChildVCArray:childVCArray titleArray:titleArr];
}
- (void)initScrollViewTitleWithChildVCArray:(NSMutableArray *)childVCArray titleArray:(NSMutableArray *)titleArr
{
    
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT+NAVIGATIONBAR_HEIGHT ,self.view.frame.size.width, SCREEN_HEIGHT -NAV_TOP_HEIGHT-NAVIGATIONBAR_HEIGHT)];
    _bottomSView.childViewController = childVCArray;
    _bottomSView.backgroundColor = [UIColor whiteColor];
    _bottomSView.delegate = self;
    [self.view addSubview:_bottomSView];
    
    
    self.topDefaultSView = [SGSegmentedControlDefault segmentedControlWithFrame:CGRectMake(90,NAV_TOP_HEIGHT, self.view.frame.size.width-180, NAVIGATIONBAR_HEIGHT) delegate:self childVcTitle:titleArr isScaleText:NO];
    self.topDefaultSView.backgroundColor = [UIColor clearColor];
    self.topDefaultSView.titleColorStateNormal = [CommonUtils colorWithHex:@"3f4446"];
    self.topDefaultSView.titleColorStateSelected = [CommonUtils colorWithHex:@"00c05c"];
    self.topDefaultSView.indicatorColor = [CommonUtils colorWithHex:@"00c05c"];
    [self.view addSubview:self.topDefaultSView];
    
}
///SGSegmentedControlDefault类型
- (void)SGSegmentedControlDefault:(SGSegmentedControlDefault *)segmentedControlDefault didSelectTitleAtIndex:(NSInteger)index
{
    
    
    // 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    
    self.bottomSView.contentOffset = CGPointMake(offsetX, 0);
    
    [self.bottomSView showChildVCViewWithIndex:index outsideVC:self];
    
    self.chooseIndex = index;
    
    
}

#pragma mark - UIScrollViewDelegate  设置一级导航栏滚动标题以及滚动controller相关
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 1.添加子控制器view
    [self.bottomSView showChildVCViewWithIndex:index outsideVC:self];
    // 2.把对应的标题选中
    [self.topDefaultSView changeThePositionOfTheSelectedBtnWithScrollView:scrollView];
    self.chooseIndex = index;
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
