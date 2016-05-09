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
@interface IndexViewController ()<IndexCollectionReusableViewDelegate,IndexIntegralMallCollectionReusableViewDelegate>
{
    UICollectionViewFlowLayout * theCollectionLayout;
    UICollectionView * theCollectionView;
    
}
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"首页"];
    [self creatLeftNavWithImageName:@"v_uc_act"];
    [self creatRightNavWithImageName:@"v_uc_act"];
    
    [self createCollectionView];
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
    [theCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:theCollectionView];

     [theCollectionView registerClass:[IndexCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [theCollectionView registerClass:[IndexIntegralMallCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView2"];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeMake(320, 150);
    }else{
        return CGSizeMake(320, 50);
    }
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
        NSArray *imageArray = @[
                                @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg",
                                @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2016158/avalanche.jpg",
                                @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg",
                                @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
                                ];
    

    //此处是headerView
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            IndexCollectionReusableView *headReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            
            headReusableView.delegate = self;
            headReusableView.imageArray = imageArray;
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
    return 2;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else{
        return 10;
    }
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];//[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
    return cell;
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
    //收件箱界面
    [CommonUtils showToastWithStr:@"收件箱"];
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
