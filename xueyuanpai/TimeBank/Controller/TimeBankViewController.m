//
//  TimeBankViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/24.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TimeBankViewController.h"
#import "LDCPullDownMenuView.h"
#import "TimeBankModel.h"
#import "RequirementsViewController.h"

#import "TimeBankDetailViewController.h"

@interface TimeBankViewController ()<LDCPullDownMenuViewDelegate>
{
    NSMutableArray *timeBankConditionCategoryModelArr;
    NSMutableArray *timeBankConditionCategoryTitleArr;
    NSMutableArray *timeBankConditionSexTitleArr;
    NSMutableArray *timeBankConditionSortTitleArr;
    
    NSDictionary *timeBankConditionSexDic;
    NSDictionary *timeBankConditionSortDic;
    
    NSString *timeBankCategoryParam;
    NSString *timeBankSexParam;
    NSString *timeBankSortParam;
    
    NSInteger pageNo;
    NSInteger pageSize;
    
    ///存放时间银行model的数据源
    NSMutableArray * timeBankModelListArr;
}
@end

@implementation TimeBankViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self theTabBarHidden:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"时间银行"];
    [self createLeftBackNavBtn];
    
    [self creatRightNavWithTitle:@"发布需求"];
    
    timeBankConditionCategoryModelArr = [NSMutableArray array];
    timeBankConditionCategoryTitleArr = [NSMutableArray array];
    timeBankConditionSexTitleArr      = [NSMutableArray array];
    timeBankConditionSortTitleArr     = [NSMutableArray array];
    timeBankModelListArr = [NSMutableArray array];
    timeBankCategoryParam = @"0";
    timeBankSexParam      = @"0" ;
    timeBankSortParam     = @"0";
    
    [self requestToGetConditions];
    [self createTableView];
}

#pragma mark - 导航栏右侧按钮响应的方法
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    

    RequirementsViewController *requirementVC = [[RequirementsViewController alloc] init];
    [self.navigationController pushViewController:requirementVC animated:YES];
    
}


-(void)requestToGetConditions
{
    NSDictionary * dic = [NSDictionary dictionary];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankGetConditionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSArray * conditionsArr = [model.responseCommonDic objectForKey:@"categorys"];
            
            ///类别：看电影、吃饭
            [timeBankConditionCategoryTitleArr addObject:@"全部"];///服务器没有返回全部标签
            for (NSDictionary *smallDic in conditionsArr) {
                TimeBankConditionCategoryModel * model = [[TimeBankConditionCategoryModel alloc] initWithDic: smallDic];
                [timeBankConditionCategoryModelArr addObject:model];
                [timeBankConditionCategoryTitleArr addObject:model.timeBankConditionCategoryName];
            }
            ///性别数组
            timeBankConditionSexDic  = [model.responseCommonDic objectForKey:@"sex"];
            [timeBankConditionSexTitleArr addObjectsFromArray:[timeBankConditionSexDic allValues]];
            ///排列顺序
            timeBankConditionSortDic = [model.responseCommonDic objectForKey:@"sort"];
            [timeBankConditionSortTitleArr addObjectsFromArray:[timeBankConditionSortDic allValues]];
            
            ///设置请求默认列表的类别、性别和排序的三个参数
            if (timeBankConditionCategoryTitleArr.count>0) {
                [self setTimeBankCategoryParamWithTitle:[timeBankConditionCategoryTitleArr firstObject]];
            }
            if (timeBankConditionSexTitleArr.count>0) {
                [self setTimeBankSexParamWithTitle:[timeBankConditionSexTitleArr firstObject]];
            }
            if (timeBankConditionSortTitleArr.count>0) {
                [self setTimeBankSortParamWithTitle:[timeBankConditionSortTitleArr firstObject]];
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
-(void)setPullDownMenuView
{
    NSArray *testArray;
    testArray = @[ timeBankConditionCategoryTitleArr,timeBankConditionSexTitleArr, timeBankConditionSortTitleArr ];
    
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
        NSString * title = [timeBankConditionCategoryTitleArr objectAtIndex:row];
        [self setTimeBankCategoryParamWithTitle:title];
        
    }else if (column==1){
        ///性别那一栏
        NSString * title = [timeBankConditionSexTitleArr objectAtIndex:row];
        [self setTimeBankSexParamWithTitle:title];
        
    }else if (column==2){
        ///排序那一列
        NSString * title = [timeBankConditionSortTitleArr objectAtIndex:row];
        [self setTimeBankSortParamWithTitle:title];
        
    }else{
        
    }
    ///清楚之前旧数据
    [timeBankModelListArr removeAllObjects];
    [self requestToGetTimeBankList];
}
-(void)setTimeBankCategoryParamWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"全部"]) {
        timeBankCategoryParam = @"0";
    }else{
        for (TimeBankConditionCategoryModel * model in timeBankConditionCategoryModelArr) {
            NSString * modelName = model.timeBankConditionCategoryName;
            if ([modelName isEqualToString:title]) {
                timeBankCategoryParam = model.timeBankConditionCategoryId;
            }
        }
    }
}
-(void)setTimeBankSexParamWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"男"]) {
        timeBankSexParam = @"1";
    }else if ([title isEqualToString:@"女"]){
        timeBankSexParam = @"2";
    }else if ([title isEqualToString:@"不限"]){
        timeBankSexParam = @"0";
    }else{
        
    }
}
-(void)setTimeBankSortParamWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"默认排序"]) {
        timeBankSortParam = @"0";
    }else if ([title isEqualToString:@"最新发布"]){
        timeBankSortParam = @"1";
    }else if ([title isEqualToString:@"约会时间最近"]){
        timeBankSortParam = @"2";
    }else if ([title isEqualToString:@"点击量最多"]){
        timeBankSortParam = @"3";
    }else{
        
    }
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
    [dic setObject:timeBankCategoryParam forKey:@"cat_id"];
    [dic setObject:timeBankSexParam forKey:@"sex"];
    [dic setObject:timeBankSortParam forKey:@"sort"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankGetListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                TimeBankModel * model = [[TimeBankModel alloc]initWithDic:smallDic];
                [timeBankModelListArr addObject:model];
            }
            [self.tableView reloadData];
        }else{
            
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

#pragma mark - tableview UITableViewDataSource,UITableViewDelegate
-(void)createTableView
{
    
    float height = 36;
    //初始化tableView
    CGRect rc = self.view.bounds;
    rc.origin.y = NAV_TOP_HEIGHT+height;
    rc.size.height = SCREEN_HEIGHT-NAV_TOP_HEIGHT-height;
    UITableView * tableView    = [[UITableView alloc]initWithFrame:rc style:UITableViewStylePlain];
    tableView.backgroundColor  = [CommonUtils colorWithHex:@"f3f3f3"];
    tableView.separatorInset   = UIEdgeInsetsZero;
    tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    tableView.dataSource       = self;
    tableView.delegate         = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"TimeBankTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //游玩日期
    return 120;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return timeBankModelListArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //游玩日期
    NSString * cellResuable = [NSString stringWithFormat:@"cell"];
    TimeBankTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellResuable forIndexPath:indexPath];
   
    TimeBankModel * timeBankModel = [timeBankModelListArr objectAtIndex:indexPath.row];
    [cell setContentViewWithModel:timeBankModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    //点击进入时间银行详情
    TimeBankDetailViewController *detailVC = [[TimeBankDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    
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
