//
//  MineProjectViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MineProjectViewController.h"

#import "BusinessCenterTableViewCell.h"
#import "BusinessProjectDetailViewController.h"

@interface MineProjectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * projectModelListArr;
    int pageSize;
    int pageNum;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation MineProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的项目";
    pageNum = 1;
    pageSize = 10;
    projectModelListArr = [NSMutableArray array];
    [self createLeftBackNavBtn];
    
    [self createTableView];
    [self requestToGetProgectList];
}

#pragma mark - 创建展示视图
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessCenterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}


#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return projectModelListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BusinessCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BusinessCenterProgectModel * model = [projectModelListArr objectAtIndex:indexPath.row];
    [cell.showImageView sd_setImageWithURL:[NSURL URLWithString:model.businessCenterProgectImage] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    cell.titleLabel.text = model.businessCenterProgectTitle;
    cell.contentLabel.text = model.businessCenterProgectBrief;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //跳转项目详情
    BusinessProjectDetailViewController *projectVC = [[BusinessProjectDetailViewController alloc] init];
    BusinessCenterProgectModel * businessCenterProgectModel = [projectModelListArr objectAtIndex:indexPath.row];
    projectVC.projectId = businessCenterProgectModel.businessCenterProgectId;
    [self.navigationController pushViewController:projectVC animated:YES];
}

-(void)requestToGetProgectList
{

    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterGetProgectListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                BusinessCenterProgectModel * model = [[BusinessCenterProgectModel alloc]initWithDic:smallDic];
                [projectModelListArr  addObject:model];
            }
            
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
    }];
    
}
-(void)requestMoreData
{
    pageNum = pageNum+1;
    [self requestToGetProgectList];
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
