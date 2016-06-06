//
//  BusinessTeacherViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessTeacherViewController.h"

#import "BusinessTeacherTableViewCell.h"
#import "BusinessCenterModel.h"


@interface BusinessTeacherViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

{
    NSString * keyword;
    NSMutableArray * tutorStarModelListArr;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation BusinessTeacherViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self theTabBarHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"创业导师";
    tutorStarModelListArr = [NSMutableArray array];
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
    [self createSearchBar];
    [self requestToGetBusinessTeachersList];
}
#pragma mark - 创建搜索按钮
- (void)createSearchBar{
    
    float height = 36;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH, height)];
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    searchBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:searchBar];
    
}

#pragma mark - 创建tableView
- (void)createTableView{
    float height = 36;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, height ,SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"BusinessTeacherTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return tutorStarModelListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BusinessTeacherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];


    BusinessCenterTutorModel * model = [tutorStarModelListArr objectAtIndex:indexPath.row];


    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[CommonUtils getEffectiveUrlWithUrl:model.businessCenterTutorImage withType:1]] placeholderImage:[UIImage imageNamed:@"placeHoder"]];

    cell.nameLabel.text = model.businessCenterTutorUserName;

    cell.jobNameLabel.text = model.businessCenterTutorJob;

    cell.goodAtLabel.text = model.businessCenterTutorGoodAt;


    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessCenterTutorModel * model = [tutorStarModelListArr objectAtIndex:indexPath.row];
    BusinessTeacherDetailViewController * teacherDetailVC = [[BusinessTeacherDetailViewController alloc]init];
    teacherDetailVC.teacherId = model.businessCenterTutorId;
    [self.navigationController pushViewController:teacherDetailVC animated:YES];
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
    
    [self requestToGetBusinessTeachersList];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 请求数据 创业导师
-(void)requestToGetBusinessTeachersList
{
    int pageNo = 1;
    int pageSize = 10;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageNo] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [dic setValue:keyword forKey:@"keyword"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterGetTeachersListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                BusinessCenterTutorModel * model = [[BusinessCenterTutorModel alloc]initWithDic:smallDic];
                [tutorStarModelListArr  addObject:model];
            }
            [self.tableView reloadData];
        }else{
            
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
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
