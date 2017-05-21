//
//  SelectedSchollViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SelectedSchollViewController.h"
#import "CollegeModel.h"
@interface SelectedSchollViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataArr;
    NSInteger pageNum;
    NSInteger pageSize;
    NSString * searchContent;
}
@property(nonatomic,strong)UITableView    *tableView;

@end

@implementation SelectedSchollViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"选择学校"];
    [self createLeftBackNavBtn];
    [self initContentView];
    dataArr = [NSMutableArray array];
    pageNum = 1;
    pageSize = 10;

    
    [self requestDataWithText:@""];

}

-(void)initContentView
{
    float space = 16;
    //初始化searchBar
    UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(space,space, SCREEN_WIDTH-2*space, 40)];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索学校";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.view addSubview:searchBar];
    
    //初始化tableView
    CGRect rc = self.view.bounds;
    rc.origin.y = 0;
    rc.size.height = SCREEN_HEIGHT;
    
    UITableView * tableView    = [[UITableView alloc]initWithFrame:rc style:UITableViewStylePlain];
    tableView.separatorColor  = [CommonUtils colorWithHex:@"eeeeee"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.dataSource       = self;
    tableView.delegate         = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //设置头视图
    self.tableView.tableHeaderView = searchBar;
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldBeginEditing");
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidBeginEditing");
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldEndEditing");
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing");
   
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange");
     //发送网络请求
    [self requestDataWithText:searchText];
}

-(void)requestMoreData
{
    pageNum = pageNum+1;
    [self requestDataWithText:@""];
}

-(void)requestDataWithText:(NSString *)searchText
{
    [dataArr removeAllObjects];
    searchContent = searchText;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:searchText forKey:@"name"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:@"page"];
    [[HttpClient sharedInstance]searchCollegeWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        NSArray * dicArr = [ListDic objectForKey:@"lists"];
        for (NSDictionary * dic in dicArr) {
            CollegeModel *collegeModel = [[CollegeModel alloc] initWithDic:dic];
            [dataArr addObject:collegeModel];
        }
        if (pageNum>=[pageModel.responsePageTotalCount integerValue]) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }

        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //目的地
    NSString * cellResuable = @"cell";//[NSString stringWithFormat:@"cell%d",indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellResuable];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellResuable];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CollegeModel  *model = [dataArr objectAtIndex:indexPath.row];
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.textLabel.text = model.collegeName;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.callBackBlock([dataArr objectAtIndex:indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
    
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
