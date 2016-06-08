//
//  UniversityAssnViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/21.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "UniversityAssnViewController.h"

#import "UniversityAssnHeaderView.h"
#import "HotActivityTableViewCell.h"
#import "StarCommunityTableViewCell.h"

#import "HotActivityModel.h"

#import "ActivityDetailViewController.h"

#define kNavigationBarHeight 64

@interface UniversityAssnViewController ()<UniversityAssnHeaderViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    int pageSize;
    int pageNum;
    
    int hotActivityPageSize;
    int hotActivityPageNum;
    
    int startCommunityPageSize;
    int startCommunityPageNum;
    
    int communityNewPageSize;
    int communityNewPageNum;
}
///设置头部选项卡视图
@property (nonatomic,strong)UniversityAssnHeaderView *headerView;
///用于记录点击的是哪个选项卡
@property (nonatomic,assign)NSInteger index;
///用于显示的列表
@property (nonatomic,strong)UITableView *tableView;
///用于存储热门活动数据的数组
@property (nonatomic,strong)NSMutableArray *saveHotActivityDataArray;
///用于存储明星社团数据的数组
@property (nonatomic,strong)NSMutableArray *saveStartCommunityArray;
///用于存储社团纳新数据的数组
@property (nonatomic,strong)NSMutableArray *saveCommunityNewArray;

@end

@implementation UniversityAssnViewController

-(void)viewWillAppear:(BOOL)animated{
    [self theTabBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    hotActivityPageSize =10;
    hotActivityPageNum=1;
    
    startCommunityPageSize=10;
    startCommunityPageNum=1;
    
    communityNewPageSize=10;
    communityNewPageNum =1;
    self.saveHotActivityDataArray = [NSMutableArray array];
    self.saveStartCommunityArray = [NSMutableArray array];
    self.saveCommunityNewArray = [NSMutableArray array];
    pageNum = 1;
    pageSize = 10;
    [self setTitle:@"大学"];
    [self createLeftBackNavBtn];
    
    //创建headerView的三个选项框
    [self createHeaderView];
    
    //创建tableView
    [self createTableView];
    
    
    //获取热门活动页面数据
    [self getHotActivityData];
}
-(void)requestMoreData
{
    if (self.index == 0) {
        ///热门活动
        hotActivityPageNum = hotActivityPageNum+1;
        [self getHotActivityData];
    }else if (self.index ==1){
        //明星社团
        startCommunityPageNum = startCommunityPageNum+1;
        [self getStartCommunityData];
    }else if (self.index ==2){
        ///社团纳新
        communityNewPageNum = communityNewPageNum+1;
        [self getCommunityNewData];
    }else{
        
    }
}
#pragma mark - 获取热门活动页面数据
- (void)getHotActivityData{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%d",hotActivityPageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%d",hotActivityPageSize] forKey:@"size"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance] getHotActivityDataWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@",listDic);
        [self.tableView.footer endRefreshing];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            for (NSDictionary * dic in [listDic objectForKey:@"lists"] ) {
                HotActivityModel * model = [[HotActivityModel alloc]initWithDic:dic];
                [_saveHotActivityDataArray addObject:model];
            }
            [self.tableView reloadData];
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
#pragma mark - 获取明星社团页面的数据
- (void)getStartCommunityData{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%d",startCommunityPageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%d",startCommunityPageSize] forKey:@"size"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance] getStartCommunityDataWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            for (NSDictionary * dic in [listDic objectForKey:@"lists"] ) {
                HotActivityModel * model = [[HotActivityModel alloc]initWithDic:dic];
                [_saveStartCommunityArray addObject:model];
            }
            [self.tableView reloadData];
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

#pragma mark - 获取社团纳新的数据
- (void)getCommunityNewData{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%d",communityNewPageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%d",communityNewPageSize] forKey:@"size"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance] getStartCommunityDataWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            for (NSDictionary * dic in [listDic objectForKey:@"lists"] ) {
                HotActivityModel * model = [[HotActivityModel alloc]initWithDic:dic];
                [_saveCommunityNewArray addObject:model];
            }
            [self.tableView reloadData];
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

#pragma mark - 创建headerView
- (void)createHeaderView{
    
    NSArray *arrar = [NSArray arrayWithObjects:@"热门活动",@"明星社团",@"社团纳新", nil];
    UniversityAssnHeaderView *headerView = [[UniversityAssnHeaderView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, [UIScreen mainScreen].bounds.size.width, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.type = PiecewiseInterfaceTypeMobileLin;
    headerView.delegate = self;
    headerView.textFont = [UIFont systemFontOfSize:18];
    headerView.textNormalColor = [UIColor blackColor];
    headerView.textSeletedColor = [CommonUtils colorWithHex:@"00BEAF"];
    headerView.linColor = [CommonUtils colorWithHex:@"00BEAF"];
    [headerView loadTitleArray:arrar];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
}

#pragma mark - UniversityAssnHeaderViewDelegate代理方法
#pragma mark - 点击每个选项卡响应的方法
- (void)headerViewSelctAction:(UniversityAssnHeaderView *)headerView index:(NSInteger)index{
    
    self.index = index;
    
    switch (index) {
        case 0:
        {
            //先移除旧的再添加新的
            //[_saveHotActivityDataArray removeAllObjects];
            //获取热门活动页面数据
            if (_saveHotActivityDataArray.count==0) {
                [self getHotActivityData];
            }
            NSLog(@"点击热门活动");
        }
            break;
        case 1:
        {
            //[_saveStartCommunityArray removeAllObjects];
            if (self.saveStartCommunityArray.count==0) {
                [self getStartCommunityData];
            }
            NSLog(@"点击明星社团");
        }
            break;
        case 2:
        {
            //[_saveCommunityNewArray removeAllObjects];
            if (self.saveCommunityNewArray.count==0) {
                [self getCommunityNewData];
            }
            NSLog(@"点击社团招纳");
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 创建tableView
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetHeight(self.headerView.frame) - kNavigationBarHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    switch (self.index) {
        case 0:
        {
            return _saveHotActivityDataArray.count;
        }
            break;
        case 1:
        {
            return _saveStartCommunityArray.count;
        }
            break;
        case 2:
        {
            return _saveCommunityNewArray.count;
        }
            break;
            
        default:
            return 0;
            break;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (self.index) {
        case 0:{
            HotActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotActivityTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (!cell) {
                cell = [[HotActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HotActivityTableViewCell"];
                
                HotActivityModel *model = [_saveHotActivityDataArray objectAtIndex:indexPath.row];
                
                [cell bindModel:model];
            }
            return cell;
        }
            break;
        case 1:{
            
            StarCommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StarCommunityTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            if (!cell) {
                cell = [[StarCommunityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StarCommunityTableViewCell"];
                HotActivityModel *model = [_saveStartCommunityArray objectAtIndex:indexPath.row];
                [cell bindModel:model];
            }
            return cell;
        }
            break;
        case 2:{
            HotActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotActivityTableViewCell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            if (!cell) {
                cell = [[HotActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HotActivityTableViewCell1"];
                HotActivityModel *model = [_saveCommunityNewArray objectAtIndex:indexPath.row];
                [cell bindModel:model];
            }
            return cell;
        }
            break;
        default:{
            UITableViewCell *cell = nil;
            return cell;
        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (self.index) {
        case 0:{
            return 280;
        }
            break;
        case 1:{
            
            return 80;
        }
            break;
        case 2:{
            return 280;
        }
            break;
            
        default:{
            return 280;
        }
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityDetailViewController *detailVC = [[ActivityDetailViewController alloc] init];
    switch (self.index) {
        case 0:{
            
            detailVC.model = [_saveHotActivityDataArray objectAtIndex:indexPath.row];
        }
            break;
        case 1:{
            detailVC.model = [_saveStartCommunityArray objectAtIndex:indexPath.row];
        }
            break;
        case 2:{
            
            detailVC.model = [_saveCommunityNewArray objectAtIndex:indexPath.row];
        }
            break;
            
        default:{
        }
            break;
    }

    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
