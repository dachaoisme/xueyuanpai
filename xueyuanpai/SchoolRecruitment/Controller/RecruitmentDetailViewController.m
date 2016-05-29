//
//  RecruitmentDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RecruitmentDetailViewController.h"

#import "UniversityAssnHeaderView.h"

#import "SchoolRecruitmentModel.h"

#import "PositionInforViewController.h"
#import "ComponeyInforViewController.h"
@interface RecruitmentDetailViewController ()<UniversityAssnHeaderViewDelegate>
{
    ///请求数据的model类
    SchoolRecruitmentDetailModel * schoolRecruitmentDetailModel;
    
    ///职位信息
    PositionInforViewController *positionVC;
    ///公司信息
    ComponeyInforViewController *componyVC;
    
    
    
}
@property (nonatomic,strong)UITableView *tableView;


@end

@implementation RecruitmentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"职位详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self requeestData];
    //创建返回按钮
    [self createLeftBackNavBtn];
    
    //创建头的显示样式
    [self createHeadView];
    
    
    [self p_setupShareButtonItem];
    
}

#pragma mark - 设置分享按钮
- (void)p_setupShareButtonItem{
    
    //分享按钮
    UIBarButtonItem *shareButtonItem =[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickSharButtonItemAction:)];
    //收藏按钮
    UIBarButtonItem * favoriteButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickFavoriteButtonItemAction:)];
    self.navigationItem.rightBarButtonItems = @[favoriteButtonItem,shareButtonItem];
    
    
}
#pragma mark - 分享按钮
- (void)didClickSharButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [CommonUtils showToastWithStr:@"分享"];
}

#pragma mark - 收藏按钮
- (void)didClickFavoriteButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [CommonUtils showToastWithStr:@"收藏"];
    
}
-(void)requeestData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.jobId forKey:@"id"];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[HttpClient sharedInstance] getSchoolRecruitmentDetailWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        schoolRecruitmentDetailModel = [[SchoolRecruitmentDetailModel alloc]initWithDic:listDic];
        
        //创建各个显示的子视图
        [self createSubView:schoolRecruitmentDetailModel];

        
        
        
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
#pragma mark - 创建头部视图样式
- (void)createHeadView{
    NSArray *arrar = [NSArray arrayWithObjects:@"职位信息",@"公司信息", nil];
    UniversityAssnHeaderView *headerView = [[UniversityAssnHeaderView alloc]initWithFrame:CGRectMake(self.view.center.x - 70, 64, 140, 50)];
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
-(void)createSubView:(SchoolRecruitmentDetailModel *)model
{
    //创建显示职位信息和公司信息的controller
    positionVC = [[PositionInforViewController alloc] init];
    
    positionVC.view.hidden = NO;
    positionVC.view.frame = CGRectMake(0, 64+50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114);
    
    positionVC.model = model;
    [self.view addSubview:positionVC.view];
    
    
    componyVC = [[ComponeyInforViewController alloc] init];
    componyVC.view.hidden = YES;
    componyVC.view.frame = CGRectMake(0, 64+50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114);
    
    componyVC.model = model;
    [self.view addSubview:componyVC.view];
}
#pragma mark - UniversityAssnHeaderViewDelegate代理方法
#pragma mark - 点击每个选项卡响应的方法
- (void)headerViewSelctAction:(UniversityAssnHeaderView *)headerView index:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            //职位信息
            positionVC.view.hidden = NO;
            componyVC.view.hidden = YES;
        }
            break;
        case 1:
        {
            //公司信息
            positionVC.view.hidden = YES;
            componyVC.view.hidden = NO;

            
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
