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

#import "LoginViewController.h"

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
    
    UISearchBar *theSearchBar;
}
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation JobMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.title = @"跳蚤市场";
    
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
    
    
    //添加请求数据列表
    [self requestToGetJobMarketList];

    
}

#pragma mark - 导航栏右侧按钮响应方法
-(void)rightItemActionWithBtn:(UIButton *)sender
{
   
    PublishInformationViewController *publishVC = [[PublishInformationViewController alloc] init];
    
    [self.navigationController pushViewController:publishVC animated:YES];
}



#pragma mark - 创建搜索按钮以及UISearchBarDelegate
- (void)createSearchButton{
    
    theSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH, 36)];
    theSearchBar.delegate = self;
    theSearchBar.searchBarStyle = UIBarStyleDefault;
    theSearchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:theSearchBar.bounds.size];
    theSearchBar.placeholder = @"搜索商品";
    theSearchBar.tintColor = [CommonUtils colorWithHex:@"00beaf"];
    [self.view addSubview:theSearchBar];

}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
    for (UIView *view in [[searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [cancelBtn setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateHighlighted];
        }
    }
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    theSearchBar.showsCancelButton = NO;
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchKeyWord = searchBar.text;
    searchBar.text = @"";
    [searchBar resignFirstResponder];
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
    [_collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
}

-(void)refreshMoreData
{
    pageNo = pageNo+1;
    pageSize = 10;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageNo] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    if (jobMarketCategoryParam.length > 0) {
        [dic setObject:jobMarketCategoryParam forKey:@"cat_id"];

    }
    if (jobMarketSortParam.length > 0) {
        [dic setObject:jobMarketSortParam forKey:@"sort"];
    }
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
            if (pageNo>=[pageModel.responsePageTotalCount integerValue]) {
                //说明是最后一张
                self.collectionView.footer.state= MJRefreshFooterStateNoMoreData;
            }
            [_collectionView reloadData];
        }else{
            
        }
        [_collectionView.footer endRefreshing];
    } withFaileBlock:^(NSError *error) {
        
        [_collectionView.footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
#pragma mark - 实现UICollectionView的代理方法
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

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {

    
    return 15;

    
    
}
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //跳转跳槽市场详情
    JobMarketModel * model = [jobMarketModelListArr objectAtIndex:indexPath.row];
    JobMarketDetailViewController *jobMarketVC = [[JobMarketDetailViewController alloc] init];
    jobMarketVC.jobMarketId =model.jobMarketId;
    [self.navigationController pushViewController:jobMarketVC animated:YES];
    
    NSLog(@"section:%ld,row:%ld",(long)indexPath.section,(long)indexPath.row);
    
    
    
}
#pragma mark - 筛选条件，选中的是当前的第几个item

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
            [self requestToGetJobMarketList];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
-(void)requestToGetJobMarketList
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
    
    if (jobMarketSortParam.length>0) {
       [dic setObject:jobMarketSortParam forKey:@"sort"];
    }
    
    if (jobMarketCategoryParam.length > 0) {
        [dic setObject:jobMarketCategoryParam forKey:@"cat_id"];

    }
    
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
    float height = 36;
    NSArray *testArray;
    testArray = @[ jobMarketConditionCategoryTitleArr,jobMarketConditionSortTitleArr ];
    
    LDCPullDownMenuView *pullDownMenuView = [[LDCPullDownMenuView alloc] initWithArray:testArray selectedColor:[CommonUtils colorWithHex:@"00beaf"] withFrame:CGRectMake(0, NAV_TOP_HEIGHT+height, SCREEN_WIDTH, 36)];
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
    [self requestToGetJobMarketList];
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
