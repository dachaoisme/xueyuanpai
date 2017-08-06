//
//  JMStartupProjectViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/14.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMStartupProjectViewController.h"

#import "JMHomePageThreeTypeTableViewCell.h"
#import "JMMineTrainCommonModel.h"

#import "JMCourseDetailsViewController.h"
#import "JMXianXiaCourseDetailsViewController.h"
@interface JMStartupProjectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int currentPage;
    int nextPage;
    int pageSize;
    NSMutableArray *dataArray;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMStartupProjectViewController

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

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[JMHomePageThreeTypeTableViewCell class] forCellReuseIdentifier:@"JMHomePageThreeTypeTableViewCell"];
    
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
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
    [[HttpClient sharedInstance]getMineTrainCourseListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        [self.tableView.footer endRefreshing];
        
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        
        if (listArray.count == 0) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMCourseModel *model = [JMCourseModel yy_modelWithDictionary:tempDic];
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
-(void)requestCollectionList
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setObject:ENTITY_TYPE_COURSE forKey:@"entity_type"];
    [[HttpClient sharedInstance]getMineCollectionProjectListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        [self.tableView.footer endRefreshing];
        
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        
        if (listArray.count == 0) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMCourseModel *model = [JMCourseModel yy_modelWithDictionary:tempDic];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMHomePageThreeTypeTableViewCell *threeCell = [tableView dequeueReusableCellWithIdentifier:@"JMHomePageThreeTypeTableViewCell"];
    
    threeCell.locationBtn.hidden = YES;
    
    threeCell.peopleNumberLabel.hidden = YES;
    JMCourseModel * model = [dataArray objectAtIndex:indexPath.row];
    [threeCell.showImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbUrl] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    threeCell.titleLabel.text = model.title;
    threeCell.subtitleLabel.text = model.courseDescription;
    [threeCell.locationBtn setTitle:model.colllege_name forState:UIControlStateNormal];
    if ([model.online integerValue]==1) {
        ///正在招募
        threeCell.peopleNumberLabel.text = [NSString stringWithFormat:@"已招募%@",model.count_mark];
    }else{
        ///一结束
        threeCell.peopleNumberLabel.text = @"已结束";
    }
    
    return threeCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JMCourseModel * model = [dataArray objectAtIndex:indexPath.row];
    if ([model.online integerValue]==1) {
        ///线上
        //创业课程线上详情
        JMCourseDetailsViewController *courseDetailVC = [[JMCourseDetailsViewController alloc] init];
        courseDetailVC.model = model;
        [self.navigationController pushViewController:courseDetailVC animated:YES];
    }else{
        //创业课程线下详情
        JMXianXiaCourseDetailsViewController *xianxiaDetailVC = [[JMXianXiaCourseDetailsViewController alloc] init];
        xianxiaDetailVC.model = model;
        [self.navigationController pushViewController:xianxiaDetailVC animated:YES];
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
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
    JMCourseModel *model = [dataArray objectAtIndex:indexPath.row];
    [self cancelCollectionWithModel:model];
    // 删除模型
    [dataArray removeObjectAtIndex:indexPath.row];
    
    // 刷新
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}
-(void)cancelCollectionWithModel:(JMCourseModel *)model
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [dic setObject:ENTITY_TYPE_SALON forKey:@"entity_type"];
    [dic setObject:model.courseItemId forKey:@"entity_id"];
    
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
