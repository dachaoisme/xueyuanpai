//
//  BusinessClassRoomViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessClassRoomViewController.h"

#import "BusinessCenterTableViewCell.h"
#import "BusinessClassDetailViewController.h"

#import "LoginViewController.h"

@interface BusinessClassRoomViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    NSInteger pageNo ;
    NSInteger pageSize ;
    NSMutableArray *businessCenterClassRoomModelListArr;
}
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation BusinessClassRoomViewController

-(void)viewWillAppear:(BOOL)animated{
    [self theTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"创业讲堂";
    businessCenterClassRoomModelListArr = [NSMutableArray array];

    [self createLeftBackNavBtn];


    [self createTableView];

    
    [self requestToGetBusinessCompetitionList];


}

#pragma mark - 创建展示视图
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessCenterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return businessCenterClassRoomModelListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BusinessCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    BusinessCenterSchoolRoomModel * model = [businessCenterClassRoomModelListArr objectAtIndex:indexPath.row];
    
    [cell.showImageView sd_setImageWithURL:[NSURL URLWithString:model.businessCenterSchoolRoomImage] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    
    cell.titleLabel.text = model.businessCenterSchoolRoomTitle;
    
    cell.contentLabel.text = model.businessCenterSchoolRoomBrief;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if ([UserAccountManager sharedInstance].isLogin==YES) {
        //创业讲堂
        BusinessClassDetailViewController *detailVC = [[BusinessClassDetailViewController alloc] init];
        
        BusinessCenterSchoolRoomModel * model = [businessCenterClassRoomModelListArr objectAtIndex:indexPath.row];
        
        detailVC.model = model;
        
        [self.navigationController pushViewController:detailVC animated:YES];

    }else{
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }

    
    
    
}

-(void)requestToGetBusinessCompetitionList
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageNo] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterGetSchoolRoomListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                BusinessCenterSchoolRoomModel * model = [[BusinessCenterSchoolRoomModel alloc]initWithDic:smallDic];
                [businessCenterClassRoomModelListArr  addObject:model];
            }
            if (pageNo>=[pageModel.responsePageTotalCount integerValue]) {
                //说明是最后一张
                self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
                
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.tableView.footer endRefreshing];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
-(void)requestMoreData
{
    pageNo = pageNo +1;
    [self requestToGetBusinessCompetitionList];
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
