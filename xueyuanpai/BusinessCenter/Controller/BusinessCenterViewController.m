//
//  BusinessCenterViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessCenterViewController.h"
#import "IndexColumnCollectionViewCell.h"
#import "IndexIntegralMallCollectionReusableView.h"

#import "SchoolColumnView.h"
#import "BusinessCenterOneStyleCollectionViewCell.h"
#import "BusinessCenterTwoStyleCollectionViewCell.h"


#import "BusinessNewsViewController.h"

@interface BusinessCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@end

@implementation BusinessCenterViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"创业中心"];
    
    //创建导航栏右侧按钮
    [self creatRightNavWithTitle:@"发布项目"];
    
    
    //创建collectionView
    [self createCollectionView];
    
}

#pragma mark - 创建集合视图
- (void)createCollectionView{
#pragma mark - 使用系统提供的UICollectionViewFlowLayout布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置每个Item的行间距(默认是10)
    flowLayout.minimumLineSpacing = 10;
    // 设置每个Item的间距(默认是10)
    flowLayout.minimumInteritemSpacing = 10;
    // 设置每个Item的大小
    flowLayout.itemSize = CGSizeMake(150, 100);
    // 设置UICollectionView的滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 头部视图的高度
    flowLayout.headerReferenceSize = CGSizeMake(100, 100);
    // 设置UICollectionView距离屏幕的上、下、左、右四个方向的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.flowLayout = flowLayout;
    
    
    
#pragma mark - 初始化一个UICollectionView并设置代理
    
    // 初始化一个UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // 添加到View上
    [self.view addSubview:collectionView];
    
    // 注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCELL"];
    
    
    [collectionView registerNib:[UINib nibWithNibName:@"BusinessCenterOneStyleCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"oneCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"BusinessCenterTwoStyleCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"twoCell"];
    // 注册头部视图
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [collectionView registerClass:[IndexIntegralMallCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView2"];

    

}

#pragma mark - UICollectionView的代理方法

// 返回cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;

            
        default:
            return 0;
            break;
    }
}

// 创建cell视图对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCELL"forIndexPath:indexPath];
    return cell;
    
//    switch (indexPath.section) {
//        case 1:{
//            
//            BusinessCenterTwoStyleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"twoCell"forIndexPath:indexPath];
//            return cell;
//
//            
//        }
//            
//            break;
//        case 2:{
//            
//            BusinessCenterOneStyleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"oneCell"forIndexPath:indexPath];
//            return cell;
//
//            
//        }
//            
//            break;
//
//            
//        default:{
//
//            
//            return nil;
//            
//        }
//            break;
//    }
}



// 返回有多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

// 返回头部和尾部视图的样式
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // 需要判断是返回头部视图还是尾部视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        
        if (indexPath.section == 0) {
            
            // 初始化头部视图
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            
            UIView *showColumView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 90)];
            showColumView.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:showColumView];
            
            //初始化三个按钮
            CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 70*4)/5;
            SchoolColumnView *columnView1 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width, 10, 80, 100)];
            columnView1.columnImageView.image = [UIImage imageNamed:@"startup_icon_news"];
            columnView1.columnTitileLable.text = @"创业新闻";
            [showColumView addSubview:columnView1];
            
            UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action:)];
            [columnView1 addGestureRecognizer:tap1];
            
        
            
            SchoolColumnView *columnView2 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*2 + 80, 10, 80, 100)];
            columnView2.columnImageView.image = [UIImage imageNamed:@"startup_icon_contest"];
            columnView2.columnTitileLable.text = @"创业大赛";
            columnView2.tag = 101;
            [showColumView addSubview:columnView2];
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action:)];
            [columnView2 addGestureRecognizer:tap2];
            
            
            
            SchoolColumnView *columnView3 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*3 + 80*2, 10, 80, 100)];
            columnView3.columnImageView.image = [UIImage imageNamed:@"startup_icon_lecture"];
            columnView3.columnTitileLable.text = @"创业讲堂";
            columnView3.tag = 102;
            [showColumView addSubview:columnView3];
            UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3Action:)];
            [columnView3 addGestureRecognizer:tap3];
            
            
            SchoolColumnView *columnView4 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*4 + 80*3, 10, 80, 100)];
            columnView4.columnImageView.image = [UIImage imageNamed:@"startup_icon_project"];
            columnView4.columnTitileLable.text = @"创业项目";
            columnView4.tag = 102;
            [showColumView addSubview:columnView4];
            UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap4Action:)];
            [columnView4 addGestureRecognizer:tap4];
            
            
            // 返回头部视图
            return headerView;

            
        }else if(indexPath.section == 1){
            
            
            IndexIntegralMallCollectionReusableView *headReusableView2 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView2" forIndexPath:indexPath];
            headReusableView2.titileLable.text = @"明星导师";
            
            [headReusableView2.button setTitle:@"查看全部 >"forState:UIControlStateNormal];
            return headReusableView2;

            
        }else{
            

            IndexIntegralMallCollectionReusableView *headReusableView2 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView2" forIndexPath:indexPath];
            headReusableView2.titileLable.text = @"创业项目";
            
            [headReusableView2.button setTitle:@"查看全部 >"forState:UIControlStateNormal];
            return headReusableView2;

        }
    } else {
        
        
        return nil;
        
    }
}

#pragma mark - 轮播图下方三个小按钮点击响应的方法
-(void) tap1Action:(UITapGestureRecognizer*) tap {
    
//    [CommonUtils showToastWithStr:@"创业新闻"];
    
    BusinessNewsViewController *newsVC = [[BusinessNewsViewController alloc] init];
    
    newsVC.title = @"创业新闻";
    newsVC.index = 100;
    [self.navigationController pushViewController:newsVC animated:YES];
    
}
-(void) tap2Action:(UITapGestureRecognizer*) tap {
    
//    [CommonUtils showToastWithStr:@"创业大赛"];
    
    BusinessNewsViewController *newsVC = [[BusinessNewsViewController alloc] init];
    
    newsVC.title = @"创业大赛";
    newsVC.index = 101;

    [self.navigationController pushViewController:newsVC animated:YES];

}
-(void) tap3Action:(UITapGestureRecognizer*) tap {
    
//    [CommonUtils showToastWithStr:@"创业讲堂"];
    
    
    BusinessNewsViewController *newsVC = [[BusinessNewsViewController alloc] init];
    
    newsVC.title = @"创业讲堂";
    newsVC.index = 102;

    [self.navigationController pushViewController:newsVC animated:YES];

}

-(void) tap4Action:(UITapGestureRecognizer*) tap {
    
//    [CommonUtils showToastWithStr:@"创业项目"];
    
    BusinessNewsViewController *newsVC = [[BusinessNewsViewController alloc] init];
    
    newsVC.title = @"创业项目";
    newsVC.index = 103;

    [self.navigationController pushViewController:newsVC animated:YES];

}



// cell的点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld,,,,,row:%ld",indexPath.section,indexPath.row);
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
