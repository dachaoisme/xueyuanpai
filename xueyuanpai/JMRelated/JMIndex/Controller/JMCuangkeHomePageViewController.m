//
//  JMCuangkeHomePageViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/15.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCuangkeHomePageViewController.h"
#import "SGSegmentedControl.h"
#import "BulkGoodsLunBoView.h"
#import "JMHomePageThreeTypeTableViewCell.h"
#import "JMTrainingProjectListViewController.h"
#import "JMHomePageModel.h"
#import "JMHomePageViewTrainingProjectDetailController.h"
#import "WKWebViewController.h"
#define bannerHeight SCREEN_WIDTH*VMScaleOfWidthAndHeight
#define tabHeight 44
@interface JMCuangkeHomePageViewController ()<SGSegmentedControlDefaultDelegate,UIScrollViewDelegate>
{
    BulkGoodsLunBoView *bulkGoodsLunBoView;
    NSMutableArray *bannerTitleArray;
    NSMutableArray *bannerImageArray;
    NSMutableArray *bannerItemArray;
    NSMutableArray *dataArray;
}
@property(nonatomic,strong)SGSegmentedControlBottomView *bottomSView;
@property(nonatomic,strong)SGSegmentedControlDefault*topDefaultSView;
@property(nonatomic,assign)NSInteger chooseIndex;
@end


@implementation JMCuangkeHomePageViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"集梦创客";
    bannerTitleArray = [NSMutableArray array];
    bannerImageArray = [NSMutableArray array];
    bannerItemArray = [NSMutableArray array];
    [self createLeftBackNavBtn];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*VMScaleOfWidthAndHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    [self setupScrollView];
    [self requestBanner];
}
-(void)requestBanner
{
    [[HttpClient sharedInstance]getBannerOfChuangYeKeChengWithParams:[NSDictionary dictionary] withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        NSArray *listArr =(NSArray *)listDic;
        for (int i=0; i<listArr.count; i++) {
            JMHomePageModel *model = [JMHomePageModel yy_modelWithDictionary:[listArr objectAtIndex:i]];
            [bannerTitleArray addObject:model.title];
            [bannerImageArray addObject:model.picUrl];
            [bannerItemArray addObject:model];
            [self setupBanner];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
#pragma mark - 配置顶部的轮播视图
-(void)setupBanner
{
    //获取轮播图片数组
    bulkGoodsLunBoView = [[BulkGoodsLunBoView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_WIDTH*VMScaleOfWidthAndHeight) animationDuration:0];
    NSArray *imageUrlArray = bannerImageArray;
    bulkGoodsLunBoView.fetchContentViewAtIndex = ^NSURL *(NSInteger pageIndex){
        return imageUrlArray[pageIndex];
    };
    bulkGoodsLunBoView.totalPagesCount = ^NSInteger(void){
        return imageUrlArray.count;
    };
    bulkGoodsLunBoView.TapActionBlock = ^(NSInteger pageIndex) {
        ///点击轮播图
        JMHomePageModel *model = [bannerItemArray objectAtIndex:pageIndex];
        if ([model.entity_type isEqualToString:@"link"]) {
            ///说明是一个url
            WKWebViewController *web = [[WKWebViewController alloc] init];
            [web loadWebURLSring:model.entity_id];
            self.parentViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
            self.parentViewController.hidesBottomBarWhenPushed = NO;
        }else if ([model.entity_type isEqualToString:@"project"]){
            ///说明是一个项目
            //未结束的项目的详情
            JMHomePageViewTrainingProjectDetailController *detailVC = [[JMHomePageViewTrainingProjectDetailController alloc] init];
            detailVC.title = model.title;
            detailVC.trainProjectId = model.entity_id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }else{
            
        }
        
    };
    [self.view addSubview:bulkGoodsLunBoView];
}

#pragma mark - 设置一级导航栏滚动标题以及滚动controller相关
- (void)setupScrollView
{
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"正在招募", @"已结束",nil];
    
    NSMutableArray *childVCArray = [NSMutableArray array];
    
    //正在招募
    JMTrainingProjectListViewController  *processingVC = [[JMTrainingProjectListViewController alloc] init];
    processingVC.stateType = 1;
    [self addChildViewController:processingVC];
    
    
    //正在招募
    JMTrainingProjectListViewController  *endVC = [[JMTrainingProjectListViewController alloc] init];
    endVC.stateType = 2;
    [self addChildViewController:endVC];
    
    
    [childVCArray addObject:processingVC];
    [childVCArray addObject:endVC];
    
    
    [self initScrollViewTitleWithChildVCArray:childVCArray titleArray:titleArr];
}
- (void)initScrollViewTitleWithChildVCArray:(NSMutableArray *)childVCArray titleArray:(NSMutableArray *)titleArr
{
    
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT+bannerHeight+NAVIGATIONBAR_HEIGHT ,self.view.frame.size.width, SCREEN_HEIGHT - TABBAR_HEIGHT-bannerHeight-NAV_TOP_HEIGHT)];
    _bottomSView.childViewController = childVCArray;
    _bottomSView.backgroundColor = [UIColor whiteColor];
    _bottomSView.delegate = self;
    [self.view addSubview:_bottomSView];
    
    
    self.topDefaultSView = [SGSegmentedControlDefault segmentedControlWithFrame:CGRectMake(90,NAV_TOP_HEIGHT+ SCREEN_WIDTH*VMScaleOfWidthAndHeight, self.view.frame.size.width-180, NAVIGATIONBAR_HEIGHT) delegate:self childVcTitle:titleArr isScaleText:NO];
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
