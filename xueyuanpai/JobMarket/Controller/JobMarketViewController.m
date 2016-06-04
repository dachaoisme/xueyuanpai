//
//  JobMarketViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/30.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "JobMarketViewController.h"

#import "LDCPullDownMenuView.h"
#import "JobMarketCollectionViewCell.h"

#import "JobMarketDetailViewController.h"
#import "PublishInformationViewController.h"

@interface JobMarketViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate>
{
    NSMutableArray * jobMarketConditionModelArr;
    NSMutableArray * jobMarketConditionCategoryTitleArr;
    NSMutableArray * jobMarketConditionSortTitleArr;
    
    ///请求参数
    NSString *jobMarketCategoryParam;
    NSString *jobMarketSortParam;
    
    NSMutableArray *jobMarketModelListArr;
    
    NSInteger pageNo;
    NSInteger pageSize;
    
    NSString * searchKeyWord;
}
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation JobMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.title = @"跳槽市场";
    
    [self theTabBarHidden:YES];
    
    [self createLeftBackNavBtn];
    
    [self creatRightNavWithTitle:@"发布信息"];
    
    jobMarketConditionCategoryTitleArr = [NSMutableArray array];
    jobMarketConditionModelArr         = [NSMutableArray array];
    jobMarketConditionSortTitleArr     = [NSMutableArray array];
    jobMarketModelListArr              = [NSMutableArray array];
    //创建搜索按钮
    [self createSearchButton];
    
    
    
    //创建flowLayout和collectionView
    [self createFlowLayout];

    [self requestToGetConditionsCategory];
}

#pragma mark - 导航栏右侧按钮响应方法
-(void)rightItemActionWithBtn:(UIButton *)sender
{
   
    PublishInformationViewController *publishVC = [[PublishInformationViewController alloc] init];
    
    [self.navigationController pushViewController:publishVC animated:YES];
}



#pragma mark - 创建搜索按钮
- (void)createSearchButton{
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH, 36)];
    searchBar.delegate = self;
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.placeholder = @"搜索学校";
    
    searchBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:searchBar];

}

#pragma mark - 创建flowLayout
- (void)createFlowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置item的行间距(如果不设置，默认是10)
    flowLayout.minimumLineSpacing = 10;
    //设置item的列间距
    flowLayout.minimumInteritemSpacing = 10;
    //设置item的大小
    flowLayout.itemSize = CGSizeMake(165, 220);
    
    //设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
    //设置UICollectionView距离屏幕上，下，左，右的一个距离
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    
#pragma mark - 创建真正要使用的UICollectionView
    float height = 36;
    //初始化一个UICollectionView对象
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT + height+height, SCREEN_WIDTH, SCREEN_HEIGHT - (NAV_TOP_HEIGHT + height+height) )collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //设置collectionView的两个代理
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [self.view addSubview:_collectionView];
    
    
    //先注册collectionViewCell
    [_collectionView registerClass:[JobMarketCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    

}

#pragma mark - 实现UICollectionView的代理方法
//1.返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return jobMarketModelListArr.count;
}

//2.设置cell视图对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JobMarketCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor greenColor];
    JobMarketModel  *model = [jobMarketModelListArr objectAtIndex:indexPath.row];
    [cell setContentWithModel:model];
    return cell;
}

//3.返回多少个区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


#pragma mark - 选中的是当前的第几个item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //跳转跳槽市场详情
    JobMarketDetailViewController *jobMarketVC = [[JobMarketDetailViewController alloc] init];
    [self.navigationController pushViewController:jobMarketVC animated:YES];
    
    
    NSLog(@"section:%ld,row:%ld",indexPath.section,indexPath.row);
    
    
    
}
///获取筛选分类列表
-(void)requestToGetConditionsCategory
{
    NSDictionary * dic = [NSDictionary dictionary];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance]getJobMarketConditionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSDictionary * conditionsDic = model.responseCommonDic ;
            ///"id":"8","name":"\u5403\u996d","ord":"1"
            ///类别：看电影、吃饭
            NSMutableDictionary * allCategoryDic = [NSMutableDictionary dictionary];
            [allCategoryDic setObject:@"0" forKey:@"id"];
            [allCategoryDic setObject:@"全部" forKey:@"name"];
            [allCategoryDic setObject:@"0" forKey:@"ord"];
            JobMarketConditionCategoryModel * allCategorymodel = [[JobMarketConditionCategoryModel alloc] initWithDic: allCategoryDic];
            [jobMarketConditionCategoryTitleArr addObject:allCategorymodel.jobMarketConditionCategoryName];///服务器没有返回全部标签
            [jobMarketConditionModelArr addObject:allCategorymodel];
            for (NSString *key in [conditionsDic allKeys]) {
                
                JobMarketConditionCategoryModel * model = [[JobMarketConditionCategoryModel alloc] initWithDic: [conditionsDic objectForKey:key]];
                [jobMarketConditionModelArr addObject:model];
                [jobMarketConditionCategoryTitleArr addObject:model.jobMarketConditionCategoryName];
            }
            ///获取排列顺序的接口
            [self requestToGetConditionsSort];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
///获取筛选分类排序列表
-(void)requestToGetConditionsSort
{
    NSDictionary * dic = [NSDictionary dictionary];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankGetConditionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
        
            ///排列顺序
            
            NSDictionary * jobMarketConditionSortDic = [model.responseCommonDic objectForKey:@"sort"];
            [jobMarketConditionSortTitleArr addObjectsFromArray:[jobMarketConditionSortDic allValues]];
            
            ///设置请求默认列表的类别、排序的三个参数
            if (jobMarketConditionCategoryTitleArr.count>0) {
                [self setJobMarketCategoryParamWithTitle:[jobMarketConditionCategoryTitleArr firstObject]];
            }
            if (jobMarketConditionSortTitleArr.count>0) {
                [self setJobMarketSortParamWithTitle:[jobMarketConditionSortTitleArr firstObject]];
            }
            
            [self setPullDownMenuView];
            ///获取到筛选条件以后，获取时间银行的列表
            [self requestToGetTimeBankList];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
-(void)requestToGetTimeBankList
{
    /*
     page           int     非必需    第几页        默认1
     size           int     非必需    每页多少条     默认10
     cat_id         int     非必需    分类序号       默认0
     sex            int     非必需    性别          默认0  0不限 1男 2女
     sort           int     非必需    排序          默认0  1最新发布 2 约会时间最近 3 点击量最多
     
     */
    pageNo = 1;
    pageSize = 10;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageNo] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [dic setObject:jobMarketCategoryParam forKey:@"cat_id"];
    [dic setObject:jobMarketSortParam forKey:@"sort"];
    if (searchKeyWord.length>0) {
        [dic setObject:searchKeyWord forKey:@"keyword"];
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]jobMarketGetListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                JobMarketModel * model = [[JobMarketModel alloc]initWithDic:smallDic];
                [jobMarketModelListArr addObject:model];
            }
            [_collectionView reloadData];
        }else{
            
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
-(void)setPullDownMenuView
{
    NSArray *testArray;
    testArray = @[ jobMarketConditionCategoryTitleArr,jobMarketConditionSortTitleArr ];
    
    LDCPullDownMenuView *pullDownMenuView = [[LDCPullDownMenuView alloc] initWithArray:testArray selectedColor:[CommonUtils colorWithHex:@"00beaf"] withFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH, 36)];
    pullDownMenuView.delegate = self;
    [self.view addSubview:pullDownMenuView];
}

#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(LDCPullDownMenuView *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    NSLog(@"column:%ld -- row:%ld", (long)column, (long)row);
    
    ///直接处理成请求列表需要的参数
    if (column==0) {
        ///类别那一栏
        NSString * title = [jobMarketConditionCategoryTitleArr objectAtIndex:row];
        [self setJobMarketCategoryParamWithTitle:title];
        
    }else if (column==1){
        ///性别那一栏
        NSString * title = [jobMarketConditionSortTitleArr objectAtIndex:row];
        [self setJobMarketSortParamWithTitle:title];
        
    }else{
        
    }
    ///清楚之前旧数据
    [jobMarketModelListArr removeAllObjects];
    [self requestToGetTimeBankList];
}

#pragma mark - 通过标题来设置参数id
-(void)setJobMarketCategoryParamWithTitle:(NSString *)title
{
    for (JobMarketConditionCategoryModel * model in jobMarketConditionModelArr) {
        NSString * modelName = model.jobMarketConditionCategoryName;
        if ([modelName isEqualToString:title]) {
            jobMarketCategoryParam = model.jobMarketConditionCategoryId;
        }
    }
    
}

-(void)setJobMarketSortParamWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"默认排序"]) {
        jobMarketSortParam = @"0";
    }else if ([title isEqualToString:@"最新发布"]){
        jobMarketSortParam = @"1";
    }else if ([title isEqualToString:@"约会时间最近"]){
        jobMarketSortParam = @"2";
    }else if ([title isEqualToString:@"点击量最多"]){
        jobMarketSortParam = @"3";
    }else{
        
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
