//
//  JMSignUpProcessingViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/8/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSignUpProcessingViewController.h"
#import "YYModel.h"
#import "JMSignUpProcessingLogModel.h"
#import "JMBaoMingStatusTableViewCell.h"
#import "JMHomePageThreeTypeTableViewCell.h"
@interface JMSignUpProcessingViewController ()
<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *dataArray;
    int currentPage;
    int nextPage;
    int pageSize;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation JMSignUpProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"报名日志";
    
    [self createLeftBackNavBtn];
    
    pageSize =10;
    currentPage = 1;
    dataArray = [NSMutableArray array];
    //创建当前列表视图
    [self createTableView];
    [self requestData];
}
#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[JMBaoMingStatusTableViewCell class] forCellReuseIdentifier:@"JMBaoMingStatusTableViewCell"];
    
    
    [_tableView registerClass:[JMHomePageThreeTypeTableViewCell class] forCellReuseIdentifier:@"JMHomePageThreeTypeTableViewCell"];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
        
    }else{
        return dataArray.count;
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        JMHomePageThreeTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMHomePageThreeTypeTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
        
        
    }else{
        JMSignUpProcessingLogModel *model = [dataArray objectAtIndex:indexPath.row];
        JMBaoMingStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMBaoMingStatusTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ///日期
        cell.dateLabel.text = model.time;
        cell.statusLabel.text = model.msg;
        return cell;
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 100;
        
        
    }else{
        
        return 70;
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
-(void)requestData
{
    /*
     entity_id   string 序号      必需
     entity_type string 类型     必需   可选项: project 创业项目  salon创业沙龙 course 创业课程
     user_id      int   用户序号
     content     string 评论内容
     
     */
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.entity_id forKey:@"entity_id"];
    [dic setObject:self.entity_type forKey:@"entity_type"];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"limit"];
    [[HttpClient sharedInstance]signUpProcessingWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [self.tableView.footer endRefreshing];
        
        NSArray * listArray = [model.responseCommonDic objectForKey:@"lists"];
        
        if (listArray.count == 0) {
            //说明是最后一张
            //self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMSignUpProcessingLogModel *model = [JMSignUpProcessingLogModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            [self.tableView reloadData];
        }
        
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
    
}
-(void)requestMoreData
{
    currentPage =currentPage+1;
    [self requestData];
}
-(void)refreshData
{
    [dataArray removeAllObjects];
    [self.tableView reloadData];
    nextPage=currentPage=1;
    [self requestData];
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
