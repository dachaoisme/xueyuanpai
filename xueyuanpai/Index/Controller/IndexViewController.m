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
@interface IndexViewController ()<IndexCollectionReusableViewDelegate,IndexIntegralMallCollectionReusableViewDelegate>
{
    UICollectionViewFlowLayout * theCollectionLayout;
    UICollectionView * theCollectionView;
    
    NSMutableArray * bannerItemArray;
    NSMutableArray * bannerImageArray;
    NSMutableArray * columnItemArray;
    NSMutableArray * mallItemArray;
    
    NSMutableArray * bigDataArray;

}
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
    bigDataArray     = [NSMutableArray array];
    bannerItemArray  = [NSMutableArray array];
    bannerImageArray = [NSMutableArray array];
    columnItemArray  = [NSMutableArray array];
    mallItemArray    = [NSMutableArray array];
    [self createCollectionView];
    
    [self requestBannerData];
    //[self requestColumnsData];
}
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
    
    [[HttpClient sharedInstance]getBannerOfIndexWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *listDic) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            for (NSDictionary * dic in [listDic objectForKey:@"lists"] ) {
                
                IndexBannerModel * model = [[IndexBannerModel alloc]initWithDic:dic];
                [bannerItemArray addObject:model];
                [bannerImageArray addObject:[CommonUtils getEffectiveUrlWithUrl:model.IndexBannerPicUrl withType:2]];
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        
        //[theCollectionView reloadData];
        [self requestColumnsData];
        
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
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
            [bigDataArray addObject:columnItemArray];
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        [self requestMallData];
        //[theCollectionView reloadData];
        
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
            [bigDataArray addObject:mallItemArray];
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
        if (bannerItemArray.count==0) {
        
            return CGSizeMake(320, 0);
        }else{
            return CGSizeMake(320, 150);
        }
    }else{
        return CGSizeMake(320, 50);
    }
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
    //此处是headerView
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            IndexCollectionReusableView *headReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            
            headReusableView.delegate = self;
            headReusableView.imageArray = bannerImageArray;
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
        return CGSizeMake(60,60);
    }else{
        return CGSizeMake(140, 140);
    }
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        NSLog(@"%f",(SCREEN_WIDTH-44*4)/5);
        return UIEdgeInsetsMake(15, (SCREEN_WIDTH-60*4)/5, 15, (SCREEN_WIDTH-60*4)/5);
    }else{
        return UIEdgeInsetsMake(5, (SCREEN_WIDTH-140*2)/3, 5, (SCREEN_WIDTH-140*2)/3);
    }
}
//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return bigDataArray.count;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[bigDataArray objectAtIndex:section] count];
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    id obj = [[bigDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[IndexColumnsModel class]]) {
        IndexColumnCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellColumnId" forIndexPath:indexPath];
        [cell setContentViewWithModel:obj];
        return cell;
    }else{
        IndexMallCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellMallId" forIndexPath:indexPath];
        [cell setContentViewWithModel:obj];
        return cell;
    }
//    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [[bigDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[IndexColumnsModel class]]) {
        if (indexPath.row==0) {
            //大学社团
            UniversityAssnViewController  *universityAssnVC = [[UniversityAssnViewController alloc]init];
            [self.navigationController pushViewController:universityAssnVC animated:YES];
        }else if (indexPath.row==1){
            //时间银行
        }else if (indexPath.row==2){
            //跳蚤市场
        }else{
            //时间银行
        }
    }else{
        
    }
}
#pragma mark - 点击banner图
-(void)selectedImageIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld张图片",(long)index+1);
}
#pragma mark - 查看更多积分
-(void)getMoreIntegralMall
{
    
}
#pragma mark - 我的
-(void)leftItemActionWithBtn:(UIButton *)sender
{
    //弹出我的界面
    MineViewController * mineVC = [[MineViewController alloc]init];
    [self.navigationController pushViewController:mineVC animated:YES];
}
#pragma mark - 收件箱
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    
    BOOL yesLogin = NO;
    //需要先判断是否已经登陆
    if (yesLogin) {
        //收件箱界面
        [CommonUtils showToastWithStr:@"收件箱"];
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
