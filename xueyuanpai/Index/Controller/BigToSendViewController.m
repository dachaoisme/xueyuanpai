//
//  BigToSendViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/23.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BigToSendViewController.h"

#import "IndexMallCollectionViewCell.h"
#import "IndexCollectionReusableView.h"
#import "GiftDetailViewController.h"
#import "IndexBannerModel.h"
#import "BannerLunBoView.h"
#import "ShufflingDetailViewController.h"

@interface BigToSendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionViewFlowLayout * theCollectionLayout;
    UICollectionView * theCollectionView;
    NSMutableArray * bannerItemArray;
    NSMutableArray * bannerImageArray;
    NSMutableArray * mallItemArray;
    UIButton *rightItemButton;
}
@property(nonatomic,strong)BannerLunBoView * bannerView;
@end

@implementation BigToSendViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
    if (rightItemButton ) {
        [rightItemButton setTitle:[UserAccountManager sharedInstance].userUsablePoints forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"大派送";
    
    
    rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItemButton setTitle:[UserAccountManager sharedInstance].userUsablePoints forState:UIControlStateNormal];
    [rightItemButton setImage:[UIImage imageNamed:@"bigpi_icon_coin"] forState:UIControlStateNormal];
    rightItemButton.frame     = CGRectMake(0, 0, 60, 40);

    [rightItemButton setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemButton];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    
//    [self creatRightNavWithImageName:@"bigpi_icon_coin"];
    
    //设置文字
//    [self creatRightNavWithTitle:[UserAccountManager sharedInstance].usablePoints];
    
    [self createLeftBackNavBtn];
    bannerItemArray  = [NSMutableArray array];
    bannerImageArray = [NSMutableArray array];
    mallItemArray    = [NSMutableArray array];
    [self createCollectionView];

    [self requestBannerData];
    
}
//首页轮播图
-(void)requestBannerData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:@"10" forKey:@"size"];
    [dic setObject:@"2" forKey:@"type"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
//    [[HttpClient sharedInstance]getBannerOfIndexWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *listDic) {
//        
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        if (responseModel.responseCode == ResponseCodeSuccess) {
//            
//            for (NSDictionary * dic in [listDic objectForKey:@"lists"] ) {
//                
//                IndexBannerModel * model = [[IndexBannerModel alloc]initWithDic:dic];
//                [bannerItemArray addObject:model];
//                [bannerImageArray addObject:model.IndexBannerPicUrl];
//            }
//        }else{
//            [CommonUtils showToastWithStr:responseModel.responseMsg];
//        }
//        
//        //[theCollectionView reloadData];
//        [self requestMallData];
//        
//    } withFaileBlock:^(NSError *error) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    }];
    
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

#pragma mark - 创建collectionView
-(void)createCollectionView
{
    //创建一个layout布局类
    theCollectionLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    theCollectionLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //[theCollectionLayout setHeaderReferenceSize:CGSizeMake(320, 150)];
    //设置每个item的大小为100*100
    //layout.itemSize = CGSizeMake(100, 100);
    //创建collectionView 通过一个布局策略layout来创建
    theCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:theCollectionLayout];
    theCollectionView.backgroundColor = [UIColor whiteColor];
    //代理设置
    theCollectionView.delegate=self;
    theCollectionView.dataSource=self;
    [self.view addSubview:theCollectionView];

    //注册item类型 这里使用系统的类型
    [theCollectionView registerClass:[IndexMallCollectionViewCell class] forCellWithReuseIdentifier:@"cellMallId"];

    [theCollectionView registerClass:[IndexCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{

     return CGSizeMake(320, 174);
    
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    //此处是headerView
    if (kind == UICollectionElementKindSectionHeader) {
            IndexCollectionReusableView *headReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        self.bannerView = [[BannerLunBoView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 174) animationDuration:2.5];
        self.bannerView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
        [headReusableView addSubview:self.bannerView];
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
        return nil;
    }

}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    float width = (SCREEN_WIDTH-2*15-15)/2;
    return CGSizeMake(width, width+40);

}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 15, 5, 15);

}
//设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 15;
    
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return mallItemArray.count;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    IndexMallModel * model = [mallItemArray objectAtIndex:indexPath.row];
    IndexMallCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellMallId" forIndexPath:indexPath];
    [cell setContentViewWithModel:model];
    
    return cell;
    
}

#pragma mark - 选中每个item进行跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //进入礼品详情界面
    IndexMallModel * model = [mallItemArray objectAtIndex:indexPath.row];
    GiftDetailViewController *giftDetailVC = [[GiftDetailViewController alloc] init];
    giftDetailVC.mallModel = model;
    [self.navigationController pushViewController:giftDetailVC animated:YES];
}


//-(void)selectedImageIndex:(NSInteger)index
//{
////    [CommonUtils showToastWithStr:@"点击轮播图"];
//    
//    ShufflingDetailViewController *detailVC = [[ShufflingDetailViewController alloc] init];
//    [self.navigationController pushViewController:detailVC animated:YES];
//    
//    
//}

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
