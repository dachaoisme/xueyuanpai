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
    
    self.title = @"我的创业课程";
    currentPage=nextPage=1;
    pageSize=10;
    dataArray = [NSMutableArray array];
    [self createLeftBackNavBtn];
    [self createTableView];
    [self requestData];
    
}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[JMHomePageThreeTypeTableViewCell class] forCellReuseIdentifier:@"JMHomePageThreeTypeTableViewCell"];
    
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}
-(void)requestMoreData
{
    nextPage=currentPage+1;
    [self requestData];
}
-(void)requestData
{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance]getMineTrainCourseListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        [self.tableView.footer endRefreshing];
        
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        
        if (listArray.count == 0) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMMineTrainCommonModel *model = [JMMineTrainCommonModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            
        }
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMHomePageThreeTypeTableViewCell *threeCell = [tableView dequeueReusableCellWithIdentifier:@"JMHomePageThreeTypeTableViewCell"];
    
    threeCell.locationBtn.hidden = YES;
    
    threeCell.peopleNumberLabel.hidden = YES;
    JMMineTrainCommonModel * model = [dataArray objectAtIndex:indexPath.row];
    [threeCell.showImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    threeCell.titleLabel.text = model.name;
    threeCell.subtitleLabel.text = model.job;
    [threeCell.locationBtn setTitle:model.colllege_name forState:UIControlStateNormal];
    if ([model.status integerValue]==1) {
        ///正在招募
        threeCell.peopleNumberLabel.text = [NSString stringWithFormat:@"已招募%@",model.count_mark];
    }else{
        ///一结束
        threeCell.peopleNumberLabel.text = @"已结束";
    }
    
    return threeCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0.01;
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
