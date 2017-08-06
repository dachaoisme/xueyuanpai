//
//  JMMineActivityListViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/14.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMineActivityListViewController.h"

#import "JMMineActivityTableViewCell.h"
#import "JMSalonModel.h"
#import "JMSalonDetailViewController.h"
@interface JMMineActivityListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int currentPage;
    int nextPage;
    int pageSize;
    NSMutableArray *dataArray;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMMineActivityListViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    currentPage=nextPage=1;
    pageSize=10;
    dataArray = [NSMutableArray array];
    //self.title = @"我的沙龙活动";
    [self createLeftBackNavBtn];
    [self createTableView];
    if (self.stateType==0) {
        ///报名
        [self requestData];
    }else{
        //收藏
        [self requestCollectionList];
    }
    
}
-(void)requestMoreData
{
    currentPage=currentPage+1;
    if (self.stateType==0) {
        ///报名
        [self requestData];
    }else{
        //收藏
        [self requestCollectionList];
    }
}
-(void)requestData
{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance]getMineTrainSalonListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        [self.tableView.footer endRefreshing];
        
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        
        if (listArray.count == 0) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMSalonModel *model = [JMSalonModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            
        }
        [self.tableView reloadData];
        ///如果没有数据，则加载空数据页面
        if (dataArray.count==0) {
            self.tableView.hidden = YES;
            [CommonView emptyViewWithView:self.view];
        }
    } withFaileBlock:^(NSError *error) {
        ///如果没有数据，则加载空数据页面
        if (dataArray.count==0) {
            self.tableView.hidden = YES;
            [CommonView emptyViewWithView:self.view];
        }
        [self.tableView.footer endRefreshing];
    }];
}

-(void)requestCollectionList
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setObject:ENTITY_TYPE_SALON forKey:@"entity_type"];
    [[HttpClient sharedInstance]getMineCollectionProjectListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        [self.tableView.footer endRefreshing];
        
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        
        if (listArray.count == 0) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMSalonModel *model = [JMSalonModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            
        }
        [self.tableView reloadData];
        ///如果没有数据，则加载空数据页面
        if (dataArray.count==0) {
            self.tableView.hidden = YES;
            [CommonView emptyViewWithView:self.view];
        }
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
        ///如果没有数据，则加载空数据页面
        if (dataArray.count==0) {
            self.tableView.hidden = YES;
            [CommonView emptyViewWithView:self.view];
        }
    }];
}


#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[JMMineActivityTableViewCell class] forCellReuseIdentifier:@"JMMineActivityTableViewCell"];
 
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMMineActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMMineActivityTableViewCell"];
    
    JMSalonModel * model = [dataArray objectAtIndex:indexPath.section];
    [cell.backGroundView sd_setImageWithURL:[NSURL URLWithString:model.bannerUrl]];
    cell.titleLabel.text = model.title;
    cell.subtitleLabel.text = model.salonDescription;
    cell.dateLabel.text = model.create_time;
    [cell.locationBtn setTitle:model.colllege_name forState:UIControlStateNormal];
    [cell.locationBtn setImage:[UIImage imageNamed:@"list_icon_weizhi_white"] forState:UIControlStateNormal];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMSalonModel *model = [dataArray objectAtIndex:indexPath.section];
    JMSalonDetailViewController *vc = [[JMSalonDetailViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 220;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0.01;
}
#pragma mark - 编辑模式相关
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.stateType==0) {
        ///报名
        return NO;
    }else{
        //收藏
        return YES;
    }
    
}
/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//IOS9前自定义左滑多个按钮需实现此方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMSalonModel *model = [dataArray objectAtIndex:indexPath.row];
    [self cancelCollectionWithModel:model];
    // 删除模型
    [dataArray removeObjectAtIndex:indexPath.row];
    
    // 刷新
    if (![dataArray count]) { //删除此行后数据源为空
        [self.tableView deleteSections: [NSIndexSet indexSetWithIndex: indexPath.section] withRowAnimation:UITableViewRowAnimationBottom];
    } else {
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}
-(void)cancelCollectionWithModel:(JMSalonModel *)model
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [dic setObject:ENTITY_TYPE_SALON forKey:@"entity_type"];
    [dic setObject:model.salonItemId forKey:@"entity_id"];
    
    [[HttpClient sharedInstance]deleteCollectWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSDictionary *dic = model.responseCommonDic;
        
    } withFaileBlock:^(NSError *error) {
        
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
