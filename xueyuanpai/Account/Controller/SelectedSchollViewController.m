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
    NSInteger page;
    NSInteger pageCount;
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
    pageCount = 10;
    page = 1;
    
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
    rc.size.height = SCREEN_HEIGHT-NAV_TOP_HEIGHT;
    
    UITableView * tableView    = [[UITableView alloc]initWithFrame:rc style:UITableViewStylePlain];
    tableView.separatorColor  = [CommonUtils colorWithHex:@"eeeeee"];
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource       = self;
    tableView.delegate         = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //设置头视图
    self.tableView.tableHeaderView = searchBar;
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

-(void)requestDataWithText:(NSString *)searchText
{
    [dataArr removeAllObjects];
    searchContent = searchText;
    page = 1;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:searchText forKey:@"name"];
//    [dic setObject:[NSString stringWithFormat:@"%d",pageCount] forKey:@"size"];
//    [dic setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [[HttpClient sharedInstance]searchCollegeWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        NSArray * dicArr = [ListDic objectForKey:@"lists"];
        for (NSDictionary * dic in dicArr) {
            CollegeModel *collegeModel = [[CollegeModel alloc] initWithDic:dic];
            [dataArr addObject:collegeModel];
        }
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
