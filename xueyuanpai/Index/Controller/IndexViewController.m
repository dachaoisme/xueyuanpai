//
//  IndexViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "IndexViewController.h"
#import "MineViewController.h"

#import "IndexCollectionReusableView.h"
#import "IndexIntegralMallCollectionReusableView.h"
#import "IndexColumnCollectionViewCell.h"
#import "IndexMallCollectionViewCell.h"

#import "IndexBannerModel.h"
#import "IndexColumnsModel.h"
#import "IndexMallModel.h"

#import "LoginViewController.h"

#import "UniversityAssnViewController.h"
#import "BigToSendViewController.h"
#import "GiftDetailViewController.h"
#import "SchoolRecruitmentViewController.h"

#import "JobMarketViewController.h"


#import "BannerLunBoView.h"
#import "TimeBankViewController.h"

#import "MessageViewController.h"

#import "ShufflingDetailViewController.h"
@interface IndexViewController ()<IndexIntegralMallCollectionReusableViewDelegate>
{
    UICollectionViewFlowLayout * theCollectionLayout;
    UICollectionView * theCollectionView;
    
    NSMutableArray * bannerItemArray;
    NSMutableArray * bannerImageArray;
    NSMutableArray * columnItemArray;
    NSMutableArray * mallItemArray;
    IndexCollectionReusableView *headReusableView;
    
}
@property(nonatomic,strong)BannerLunBoView *bannerView;
@end

@implementation IndexViewController

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
    [self setTitle:@"首页"];
    [self creatLeftNavWithImageName:@"nav_icon_profile"];
    [self creatRightNavWithImageName:@"nav_icon_msg"];
    bannerItemArray  = [NSMutableArray array];
    bannerImageArray = [NSMutableArray array];
    columnItemArray  = [NSMutableArray array];
    mallItemArray    = [NSMutableArray array];
    [self createCollectionView];
    
    [self requestBannerData];
    [self requestColumnsData];
    [self requestMallData];
}
-(void)createCollectionView
{
    //创建一个layout布局类
    theCollectionLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    theCollectionLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //theCollectionLayout.minimumInteritemSpacing = 38;
    //[theCollectionLayout setHeaderReferenceSize:CGSizeMake(320, 150)];
    //设置每个item的大小为100*100
    //layout.itemSize = CGSizeMake(100, 100);
    //创建collectionView 通过一个布局策略layout来创建
    theCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:theCollectionLayout];
    theCollectionView.backgroundColor = [UIColor whiteColor];
    //代理设置
    theCollectionView.delegate=self;
    theCollectionView.dataSource=self;
    //注册item类型 这里使用系统的类型
    [theCollectionView registerClass:[IndexColumnCollectionViewCell class] forCellWithReuseIdentifier:@"cellColumnId"];
    [theCollectionView registerClass:[IndexMallCollectionViewCell class] forCellWithReuseIdentifier:@"cellMallId"];
    [self.view addSubview:theCollectionView];

    [theCollectionView registerClass:[IndexCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [theCollectionView registerClass:[IndexIntegralMallCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView2"];
}
//首页轮播图
-(void)requestBannerData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:@"10" forKey:@"size"];
    [dic setObject:@"1" forKey:@"type"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    /*
    [[HttpClient sharedInstance]getBannerOfIndexWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *listDic) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            for (NSDictionary * dic in [listDic objectForKey:@"lists"] ) {
                
                IndexBannerModel * model = [[IndexBannerModel alloc]initWithDic:dic];
                [bannerItemArray addObject:model];
                [bannerImageArray addObject:model.IndexBannerPicUrl];
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        [theCollectionView reloadData];
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    */
}
//首页栏目分类
-(void)requestColumnsData
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]getColumnsOfIndexWithParams:nil withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *listDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            for (NSDictionary * dic in [listDic objectForKey:@"lists"] ) {
                
                IndexColumnsModel * model = [[IndexColumnsModel alloc]initWithDic:dic];
                [columnItemArray addObject:model];
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        [theCollectionView reloadData];
        
    } withFaileBlock:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
//首页积分商品
-(void)requestMallData
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]getMallOfIndexWithParams:nil withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *listDic) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            for (NSDictionary * dic in [listDic objectForKey:@"lists"]) {
                
                IndexMallModel * model = [[IndexMallModel alloc]initWithDic:dic];
                [mallItemArray addObject:model];
            }
        }else{
            
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        
        [theCollectionView reloadData];
        
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 174);
    }else{
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
    }
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //此处是headerView
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            if (!headReusableView) {
                headReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
                self.bannerView = [[BannerLunBoView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 174) animationDuration:0.5];
                self.bannerView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
                [headReusableView addSubview:self.bannerView];
            }
            self.bannerView.fetchContentViewAtIndex = ^NSURL *(NSInteger pageIndex){
                return bannerImageArray[pageIndex];
            };
            
            //得到pagecontro的数目
            self.bannerView.totalPagesCount = ^NSInteger(void){
                return bannerImageArray.count;
            };
            //点击事件的block
            
            __weak typeof(self)weakSelf = self;
            self.bannerView.TapActionBlock = ^void(NSInteger pageIndex){
                ShufflingDetailViewController *detailVC = [[ShufflingDetailViewController alloc] init];
                [weakSelf.navigationController pushViewController:detailVC animated:YES];

            };
            return headReusableView;
        }else{
            IndexIntegralMallCollectionReusableView *headReusableView2 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView2" forIndexPath:indexPath];
            headReusableView2.delegate = self;
            return headReusableView2;
        }
        
    }else{
        return nil;
    }
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        float width = 45;//(SCREEN_WIDTH-2*15-30*3)/4;
        float height = 93;
        return CGSizeMake(width,height);
        
    }else{
        float width = (SCREEN_WIDTH-2*15-15)/2;
        return CGSizeMake(width, width+40);
        
    }
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        float widthSpace = (SCREEN_WIDTH-45*4)/5;
        return UIEdgeInsetsMake(0, widthSpace , 0, widthSpace);
        
    }else{
        
        return UIEdgeInsetsMake(5, 15, 5, 15);
        
    }
}

 //设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    if (section == 0) {
        float width = (SCREEN_WIDTH-45*4)/5;
            return width;
    }else{
        return 15;
    }
}
//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return columnItemArray.count;
    }else{
        return mallItemArray.count;
    }
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        IndexColumnsModel * model = [columnItemArray objectAtIndex:indexPath.row];
        IndexColumnCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellColumnId" forIndexPath:indexPath];
        [cell setContentViewWithModel:model];
        return cell;
    }else{
        IndexMallModel * model  =[mallItemArray objectAtIndex:indexPath.row];
        IndexMallCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellMallId" forIndexPath:indexPath];
        [cell setContentViewWithModel:model];
        return cell;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        IndexColumnsModel * model = [columnItemArray objectAtIndex:indexPath.row];
        if (indexPath.row==0) {
            //大学社团
            UniversityAssnViewController  *universityAssnVC = [[UniversityAssnViewController alloc]init];
            [self.navigationController pushViewController:universityAssnVC animated:YES];
        }else if (indexPath.row==1){
            //时间银行
            TimeBankViewController  *timeBankViewControllerVC = [[TimeBankViewController alloc]init];
            [self.navigationController pushViewController:timeBankViewControllerVC animated:YES];
        }else if (indexPath.row==2){
            //跳蚤市场
            
            JobMarketViewController *jobMarketVC = [[JobMarketViewController alloc] init];
            [self.navigationController pushViewController:jobMarketVC animated:YES];
            
        }else{
            //校园招聘
            SchoolRecruitmentViewController *schoolVC = [[SchoolRecruitmentViewController alloc] init];
            [self.navigationController pushViewController:schoolVC animated:YES];
        }
    }else{
        IndexMallModel * model  =[mallItemArray objectAtIndex:indexPath.row];
        GiftDetailViewController *giftDetailVC = [[GiftDetailViewController alloc] init];
        giftDetailVC.mallModel = model;
        
        [self.navigationController pushViewController:giftDetailVC animated:YES];
    }
}

#pragma mark - 查看更多积分
-(void)getMoreIntegralMall
{
    BigToSendViewController *bigToSendVC = [[BigToSendViewController alloc] init];
    [self.navigationController pushViewController:bigToSendVC animated:YES];
}
#pragma mark - 我的
-(void)leftItemActionWithBtn:(UIButton *)sender
{
    BOOL yesLogin = [UserAccountManager sharedInstance].isLogin;
    //需要先判断是否已经登陆
    if (yesLogin) {
        //收件箱界面
        //弹出我的界面
        MineViewController * mineVC = [[MineViewController alloc]init];
        [self.navigationController pushViewController:mineVC animated:YES];
    }else{
        //进入登陆注册页面
        
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
}
#pragma mark - 收件箱
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    
    BOOL yesLogin = [UserAccountManager sharedInstance].isLogin;
    //需要先判断是否已经登陆
    if (yesLogin) {
        //收件箱界面
//        [CommonUtils showToastWithStr:@"收件箱"];
        
        
        MessageViewController *messageVC = [[MessageViewController alloc] init];
        [self.navigationController pushViewController:messageVC animated:YES];
        
        
    }else{
        //进入登陆注册页面
        
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
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
