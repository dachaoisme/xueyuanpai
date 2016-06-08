//
//  MineJobMarketViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MineJobMarketViewController.h"

#import "JobMarketCollectionViewCell.h"
#import "JobMarketDetailViewController.h"

@interface MineJobMarketViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *jobMarketModelListArr;
    int pageNum;
    int pageSize;
    
}
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation MineJobMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的跳槽市场";
    pageSize = 10;
    pageNum = 1;
    jobMarketModelListArr = [NSMutableArray array];
    [self createLeftBackNavBtn];
    
    //创建flowLayout和collectionView
    [self createFlowLayout];

    [self requestToGetJobMarketList];
    
}

#pragma mark - 创建flowLayout
- (void)createFlowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置item的行间距(如果不设置，默认是10)
    //flowLayout.minimumLineSpacing = 10;
    //设置item的列间距
    //flowLayout.minimumInteritemSpacing = 10;
    //设置item的大小
    //flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 10 - 20)/2, 220);
    
    //设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //设置UICollectionView距离屏幕上，下，左，右的一个距离
    //flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    
#pragma mark - 创建真正要使用的UICollectionView
    //初始化一个UICollectionView对象
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //设置collectionView的两个代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    //先注册collectionViewCell
    [collectionView registerClass:[JobMarketCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

#pragma mark - 实现UICollectionView的代理方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = (SCREEN_WIDTH-2*10-20)/2;
    return CGSizeMake(width,220);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
    
}
//1.返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return jobMarketModelListArr.count;
}

//2.设置cell视图对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JobMarketCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    JobMarketModel * model = [jobMarketModelListArr objectAtIndex:indexPath.row];
    [cell setContentWithModel:model];
    return cell;
}

//3.返回多少个区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //跳转跳槽市场详情
    JobMarketModel * model = [jobMarketModelListArr objectAtIndex:indexPath.row];
    JobMarketDetailViewController *jobMarketVC = [[JobMarketDetailViewController alloc] init];
    jobMarketVC.jobMarketId =model.jobMarketId;
    [self.navigationController pushViewController:jobMarketVC animated:YES];
    
    
    NSLog(@"section:%ld,row:%ld",(long)indexPath.section,(long)indexPath.row);
    
    
    
}

-(void)requestToGetJobMarketList
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]mineToGetjobMarketListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.collectionView.footer endRefreshing];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                JobMarketModel * model = [[JobMarketModel alloc]initWithDic:smallDic];
                [jobMarketModelListArr addObject:model];
            }
            if (pageNum>=[pageModel.responsePageTotalCount integerValue]) {
                //说明是最后一张
                self.collectionView.footer.state= MJRefreshFooterStateNoMoreData;
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        [self.collectionView reloadData];
    } withFaileBlock:^(NSError *error) {
        [self.collectionView.footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
-(void)requestMoreData
{
    pageNum = pageNum+1;
    [self requestToGetJobMarketList];
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
