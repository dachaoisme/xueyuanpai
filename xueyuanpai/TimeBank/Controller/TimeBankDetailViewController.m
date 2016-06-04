//
//  TimeBankDetailViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TimeBankDetailViewController.h"

#import "TimeBankDetailOneStyleTableViewCell.h"

#import "TimeBankDetailTwoStyleTableViewCell.h"

@interface TimeBankDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    TimeBankDetailModel * detailModel;
    ///时间银行浏览次数
    NSString * timeBankDetailScanViewNum;
    ///申请项目的时候，捎句话
    NSString * applyProjectWord;
    NSMutableArray * timeBankCommentListArr;
}
@property (nonatomic,strong)UITableView * tableView;

@end

@implementation TimeBankDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setTitle:@"时间银行详情"];
    [self createLeftBackNavBtn];
    [self p_setupShareButtonItem];
    timeBankCommentListArr = [NSMutableArray array];
    
    //创建tableView
    [self createTableView];
    //请求数据
    [self requestToGetTimeBankDetail];
    [self requestToaddScanViewNum];
    
}



#pragma mark - tableview UITableViewDataSource,UITableViewDelegate
-(void)createTableView
{
    
    UITableView * tableView    = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tableView.backgroundColor  = [CommonUtils colorWithHex:@"f3f3f3"];
    tableView.separatorInset   = UIEdgeInsetsZero;
    tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    tableView.dataSource       = self;
    tableView.delegate         = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"TimeBankDetailOneStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"TimeBankDetailTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    
    
}

#pragma mark - 设置分享按钮
- (void)p_setupShareButtonItem{
    
    //分享按钮
    UIBarButtonItem *shareButtonItem =[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickSharButtonItemAction:)];
    //收藏按钮
    UIBarButtonItem * favoriteButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickFavoriteButtonItemAction:)];
    self.navigationItem.rightBarButtonItems = @[favoriteButtonItem,shareButtonItem];
    
    
}

#pragma mark - 分享按钮
- (void)didClickSharButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [CommonUtils showToastWithStr:@"分享"];
}

#pragma mark - 收藏按钮
- (void)didClickFavoriteButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [CommonUtils showToastWithStr:@"收藏"];
    
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        TimeBankDetailOneStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        
        return cell;

    } else {
        TimeBankDetailTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250;
}
#pragma mark - 请求时间银行详情数据
-(void)requestToGetTimeBankDetail
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.timeBankId?self.timeBankId:@"" forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankDetailWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSDictionary * dataDic = model.responseCommonDic ;
            detailModel = [[TimeBankDetailModel alloc]initWithDic:dataDic];
            [self requestToCommentList];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
#pragma mark - 申领项目
-(void)requestToApply
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setObject:self.timeBankId forKey:@"tb_id"];
    [dic setObject:applyProjectWord forKey:@"msg"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankProjectWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSDictionary * dataDic = [model.responseCommonDic objectForKey:@"data"];
            NSString * userId = [dataDic stringForKey:@"user_id"];
            NSString * timeBankId = [dataDic stringForKey:@"tb_id"];
            [CommonUtils showToastWithStr:@"申领状态成功"];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
#pragma mark - 增加浏览次数
-(void)requestToaddScanViewNum
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.timeBankId forKey:@"tb_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankAddScanNumWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSDictionary * dataDic = [model.responseCommonDic objectForKey:@"data"];
            timeBankDetailScanViewNum = [dataDic stringForKey:@"views"];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
#pragma mark - 增加评论
-(void)requestToAddCommentWithCommentContent:(NSString *)commentContent
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setObject:self.timeBankId forKey:@"tb_id"];
    [dic setObject:commentContent forKey:@"content"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankAddCommentWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"评论成功"];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

#pragma mark - 评论列表
-(void)requestToCommentList
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.timeBankId forKey:@"tb_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankCommentListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * dic in arr) {
                TimeBankCommentModel * commentModel = [[TimeBankCommentModel alloc]initWithDic:dic];
                [timeBankCommentListArr addObject:commentModel];
            }
            
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
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
