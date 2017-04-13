//
//  JMKuaiDiYuanViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/9.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMKuaiDiYuanViewController.h"

#import "SGSegmentedControl.h"

#import "JMCollectCourierListViewController.h"
#import "JMMailDeliveryViewController.h"

#import "JMSendExpressViewController.h"

@interface JMKuaiDiYuanViewController ()<SGSegmentedControlDefaultDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)SGSegmentedControlBottomView *bottomSView;
@property(nonatomic,strong)SGSegmentedControlDefault*topDefaultSView;
@property(nonatomic,assign)NSInteger chooseIndex;


@property (nonatomic,strong)UIButton *sendExpressButton;

@end

@implementation JMKuaiDiYuanViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:NO];
    
    
    _sendExpressButton.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
    _sendExpressButton.hidden = YES;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的快递";
    
    
    //创建顶部
    [self setupScrollView];
    
    
    [self initSendExpressButton];

}

#pragma mark - 设置一级导航栏滚动标题以及滚动controller相关
- (void)setupScrollView
{
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"收取快递", @"寄出快递",nil];
    
    NSMutableArray *childVCArray = [NSMutableArray array];
    
    //收取快递
    JMCollectCourierListViewController  *collectCourierVC = [[JMCollectCourierListViewController alloc] init];
    [self addChildViewController:collectCourierVC];
    
    
    JMMailDeliveryViewController  *mailDeliveryVC = [[JMMailDeliveryViewController alloc] init];
    [self addChildViewController:mailDeliveryVC];
    
    
    [childVCArray addObject:collectCourierVC];
    [childVCArray addObject:mailDeliveryVC];
    
    
    [self initScrollViewTitleWithChildVCArray:childVCArray titleArray:titleArr];
}
- (void)initScrollViewTitleWithChildVCArray:(NSMutableArray *)childVCArray titleArray:(NSMutableArray *)titleArr
{
    
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, 50 ,self.view.frame.size.width, SCREEN_HEIGHT - TABBAR_HEIGHT - NAV_TOP_HEIGHT)];
    _bottomSView.childViewController = childVCArray;
    _bottomSView.backgroundColor = [UIColor clearColor];
    _bottomSView.delegate = self;
    [self.view addSubview:_bottomSView];
    
    
    UIView *whiteBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, self.view.frame.size.width, 45)];
    whiteBackGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteBackGroundView];
    
    self.topDefaultSView = [SGSegmentedControlDefault segmentedControlWithFrame:CGRectMake(90, NAV_TOP_HEIGHT, self.view.frame.size.width-180, 45) delegate:self childVcTitle:titleArr isScaleText:NO];
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


#pragma mark - 初始化我要发快递按钮
- (void)initSendExpressButton{
    
    UIButton *sendExpressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendExpressButton.frame = CGRectMake(SCREEN_WIDTH - 15 - 60, SCREEN_HEIGHT - NAV_TOP_HEIGHT - TABBAR_HEIGHT - 50, 60, 60);
    sendExpressButton.layer.cornerRadius = 30;
    sendExpressButton.layer.masksToBounds = YES;
    sendExpressButton.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    [sendExpressButton setTitle:@"我要发快递" forState:UIControlStateNormal];
    sendExpressButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    sendExpressButton.titleLabel.numberOfLines = 2;
    sendExpressButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [sendExpressButton addTarget:self action:@selector(sendExpressAction) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:sendExpressButton];
    
    self.sendExpressButton = sendExpressButton;
    
}

- (void)sendExpressAction{
    
//    [CommonUtils showToastWithStr:@"发快递"];
    
    
    //跳转寄快递页面
    JMSendExpressViewController *sendExpressVC = [[JMSendExpressViewController alloc] init];
    [self.navigationController pushViewController:sendExpressVC animated:YES];
    
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
