//
//  BusinessProjectViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessProjectViewController.h"

#import "BusinessCenterTableViewCell.h"
#import "LDCPullDownMenuView.h"

#import "BussinessProjectTeacherDetailViewController.h"

#import "LoginViewController.h"

#import "BusinessPublishProjectViewController.h"

@interface BusinessProjectViewController ()<UITableViewDataSource,UITableViewDelegate,LDCPullDownMenuViewDelegate,UISearchBarDelegate>
{
    NSString * keyword;
    NSString * categoryParam;
    NSString * sortParam;
    ///创业中心分类列表
    NSMutableArray * businessCenterProgectCategoryTitleArr;
    NSMutableArray * businessCenterProgectCategoryModelArr;
    NSMutableArray * businessCenterProgectSortTitleArr;
    NSMutableArray * businessCenterProgectSortModelArr;
    NSInteger pageNo ;
    NSInteger pageSize ;
    
    ///创业中心列表的model
    NSMutableArray *businessCenterProgectModelListArr;
    
    
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation BusinessProjectViewController

-(void)viewWillAppear:(BOOL)animated{
    [self theTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    self.title = @"创业项目";
    [self creatRightNavWithTitle:@"发布项目"];
    pageNo = 1;
    pageSize = 10;
    businessCenterProgectModelListArr      = [NSMutableArray array];
    businessCenterProgectCategoryModelArr  = [NSMutableArray array];
    businessCenterProgectCategoryTitleArr  = [NSMutableArray array];
    businessCenterProgectSortTitleArr      = [NSMutableArray array];
    businessCenterProgectSortModelArr      = [NSMutableArray array];
    [self createLeftBackNavBtn];
    
    
    [self createSearchBar];
    
    
    [self createTableView];
    
    [self requestToGetConditionsCategory];
    
}

#pragma mark - 导航栏右侧按钮的响应方法
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    
    BusinessPublishProjectViewController *publishProjectVC = [[BusinessPublishProjectViewController alloc] init];
    
    [self.navigationController pushViewController:publishProjectVC animated:YES];
}


#pragma mark - 创建搜索按钮
- (void)createSearchBar{
    
    float height = 36;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH, height)];
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    searchBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:searchBar.bounds.size];
    searchBar.tintColor = [CommonUtils colorWithHex:@"00beaf"];
    [self.view addSubview:searchBar];
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

#pragma mark - 创建展示视图
- (void)createTableView{
    float height = 36;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT + height*2+5, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_TOP_HEIGHT-height*2-5) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessCenterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}


#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return businessCenterProgectModelListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BusinessCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    BusinessCenterProgectModel * model = [businessCenterProgectModelListArr objectAtIndex:indexPath.row];
    [cell.showImageView sd_setImageWithURL:[NSURL URLWithString:model.businessCenterProgectImage] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    
    cell.titleLabel.text = model.businessCenterProgectTitle;
    
    cell.contentLabel.text = model.businessCenterProgectBrief;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([UserAccountManager sharedInstance].isLogin==YES) {
        
        //根据不同的身份跳转不同的详情
        
        if ([UserAccountManager sharedInstance].userRole == UserInfoRoleStudent) {
            
            //跳转项目详情
            BusinessProjectDetailViewController *projectVC = [[BusinessProjectDetailViewController alloc] init];
            BusinessCenterProgectModel * businessCenterProgectModel = [businessCenterProgectModelListArr objectAtIndex:indexPath.row];
            projectVC.projectId = businessCenterProgectModel.businessCenterProgectId;
            [self.navigationController pushViewController:projectVC animated:YES];
            
            
        }else{
            
            //跳转导师项目详情
            BussinessProjectTeacherDetailViewController *projectVC = [[BussinessProjectTeacherDetailViewController alloc] init];
            BusinessCenterProgectModel * businessCenterProgectModel = [businessCenterProgectModelListArr objectAtIndex:indexPath.row];
            projectVC.projectId = businessCenterProgectModel.businessCenterProgectId;
            [self.navigationController pushViewController:projectVC animated:YES];
            
            
        }

    }else{
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }

    

    
}
#pragma mark - 请求数据
///获取筛选分类列表
-(void)requestToGetConditionsCategory
{
    NSDictionary * dic = [NSDictionary dictionary];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance]getbusinessCenterConditionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
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
            BusinessCenterProgectCategoryModel * allCategorymodel = [[BusinessCenterProgectCategoryModel alloc] initWithDic: allCategoryDic];
            [businessCenterProgectCategoryTitleArr addObject:allCategorymodel.BusinessCenterProgectName];///服务器没有返回全部标签
            [businessCenterProgectCategoryModelArr addObject:allCategorymodel];
            for (NSString *key in [conditionsDic allKeys]) {
                
                BusinessCenterProgectCategoryModel * model = [[BusinessCenterProgectCategoryModel alloc] initWithDic: [conditionsDic objectForKey:key]];
                [businessCenterProgectCategoryModelArr  addObject:model];
                [businessCenterProgectCategoryTitleArr addObject:model.BusinessCenterProgectName];
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
            [businessCenterProgectSortTitleArr addObjectsFromArray:[jobMarketConditionSortDic allValues]];

            ///设置请求默认列表的类别、排序的三个参数
            if (businessCenterProgectCategoryTitleArr.count>0) {
                [self setJobMarketCategoryParamWithTitle:[businessCenterProgectCategoryTitleArr firstObject]];
            }
            if (businessCenterProgectSortTitleArr.count>0) {
                [self setJobMarketSortParamWithTitle:[businessCenterProgectSortTitleArr firstObject]];
            }
            
            [self setPullDownMenuView];
            ///获取到筛选条件以后，获取时间银行的列表
            [self requestToGetBusinessProgectList];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
-(void)requestToGetBusinessProgectList
{
    /*
     page        int     非必需    第几页        默认1
     size        int     非必需    每页多少条     默认10
     keyword     string  非必需    关键字
     category_id  int    非必需    分类序号      默认全部
     sort         int    非必需    排序          默认1  1最新发布 2点击最多 3申领最多 （客户端组装排序文字）
     
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageNo] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [dic setValue:keyword forKey:@"keyword"];
    [dic setObject:categoryParam forKey:@"cat_id"];
    [dic setValue:sortParam  forKey:@"sort"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterGetProgectListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                BusinessCenterProgectModel * model = [[BusinessCenterProgectModel alloc]initWithDic:smallDic];
                [businessCenterProgectModelListArr  addObject:model];
            }
            if (pageNo>=[pageModel.responsePageTotalCount integerValue]) {
                //说明是最后一张
                self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
            }
        }else{
            
        }
         [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
    }];
    
}
-(void)requestMoreData
{
    pageNo = pageNo +1;
    [self requestToGetBusinessProgectList];
}



#pragma mark - 搜索
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
            [cancelBtn setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateHighlighted];
            cancelBtn.titleLabel.textColor = [UIColor redColor];
        }
    }
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    keyword = searchBar.text;
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    
    [self requestToGetBusinessProgectList];
}

#pragma mark - MXPullDownMenuDelegate
-(void)setPullDownMenuView
{
    float height = 36;
    NSArray *testArray;
    testArray = @[ businessCenterProgectCategoryTitleArr,businessCenterProgectSortTitleArr ];
    
    LDCPullDownMenuView *pullDownMenuView = [[LDCPullDownMenuView alloc] initWithArray:testArray selectedColor:[CommonUtils colorWithHex:@"00beaf"] withFrame:CGRectMake(0, NAV_TOP_HEIGHT+height, SCREEN_WIDTH, 36)];
    pullDownMenuView.delegate = self;
    [self.view addSubview:pullDownMenuView];
}


- (void)PullDownMenu:(LDCPullDownMenuView *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    NSLog(@"column:%ld -- row:%ld", (long)column, (long)row);
    

    ///直接处理成请求列表需要的参数
    if (column==0) {
        ///类别那一栏
        NSString * title = [businessCenterProgectCategoryTitleArr objectAtIndex:row];
        [self setJobMarketCategoryParamWithTitle:title];
        
    }else if (column==1){
        ///性别那一栏
        NSString * title = [businessCenterProgectSortTitleArr objectAtIndex:row];
        [self setJobMarketSortParamWithTitle:title];
        
    }else{
        
    }
    ///清楚之前旧数据
    pageNo = 1;
    [businessCenterProgectModelListArr removeAllObjects];
    [self requestToGetBusinessProgectList];
}

#pragma mark - 通过标题来设置参数id
-(void)setJobMarketCategoryParamWithTitle:(NSString *)title
{
    for (BusinessCenterProgectCategoryModel * model in businessCenterProgectCategoryModelArr) {
        NSString * modelName = model.BusinessCenterProgectName;
        if ([modelName isEqualToString:title]) {
            categoryParam = model.BusinessCenterProgectId;
        }
    }
    
}

-(void)setJobMarketSortParamWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"默认排序"]) {
        sortParam = @"0";
    }else if ([title isEqualToString:@"最新发布"]){
        sortParam = @"1";
    }else if ([title isEqualToString:@"约会时间最近"]){
        sortParam = @"2";
    }else if ([title isEqualToString:@"点击量最多"]){
        sortParam = @"3";
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
