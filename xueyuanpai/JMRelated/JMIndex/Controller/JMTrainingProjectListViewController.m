//
//  JMTrainingProjectListViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/12.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMTrainingProjectListViewController.h"

#import "JMHomePageThreeTypeTableViewCell.h"
#import "JMHomePageModel.h"
#import "JMHomePageViewTrainingProjectDetailController.h"
#import "JMHomePageEndProjectDetailViewController.h"
@interface JMTrainingProjectListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
    int currentPage;
    int nextPage;
    int pageSize;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMTrainingProjectListViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.stateType==1) {
        self.title = @"正在招募";
    }else if (self.stateType==2){
        self.title = @"已结束";
    }else{
        self.title = @"实训项目列表";
    }
        
    
    currentPage=nextPage=1;
    pageSize=10;
    dataArray = [NSMutableArray array];
    [self createLeftBackNavBtn];
    [self createTableView];
    [self requestData];
}
-(void)requestData
{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    if (self.stateType==1) {
        [dic setObject:@"1" forKey:@"status"];
    }else if (self.stateType==2){
        [dic setObject:@"0" forKey:@"status"];
    }else{
    }
    [[HttpClient sharedInstance]getTrainProjectWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        [self.tableView.footer endRefreshing];
        currentPage=nextPage;
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMTrainProjectModel *model = [JMTrainProjectModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            
        }
        
        if (currentPage==[pageModel.responsePageTotalCount intValue]) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
}
-(void)requestMoreData
{
    nextPage=currentPage+1;
    [self requestData];
}
#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, CGRectGetHeight(self.view.frame)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[JMHomePageThreeTypeTableViewCell class] forCellReuseIdentifier:@"JMHomePageThreeTypeTableViewCell"];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   
    return dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMHomePageThreeTypeTableViewCell *threeCell = [tableView dequeueReusableCellWithIdentifier:@"JMHomePageThreeTypeTableViewCell"];
    
    JMTrainProjectModel * model = [dataArray objectAtIndex:indexPath.row];
    [threeCell.showImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbUrl] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    threeCell.titleLabel.text = model.title;
    threeCell.subtitleLabel.text = model.trainProjectDescription;
    [threeCell.locationBtn setTitle:model.colllege_name forState:UIControlStateNormal];
    if ([model.status integerValue]==1) {
        ///正在招募
        threeCell.peopleNumberLabel.text = [NSString stringWithFormat:@"已招募%@",model.recruitment_number];
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
//点击跳转详情视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    JMTrainProjectModel * model = [dataArray objectAtIndex:indexPath.row];
    //未结束的项目的详情
    if ([model.status intValue]==1) {
        ///正在招募
        //未结束的项目的详情
        JMHomePageViewTrainingProjectDetailController *detailVC = [[JMHomePageViewTrainingProjectDetailController alloc] init];
        detailVC.title = model.title;
        detailVC.trainProjectId = model.trainProjectId;
        detailVC.count_like = model.count_like;
        detailVC.recruitment_number = model.recruitment_number;
        detailVC.count_comment = model.count_comment;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        //已结束的项目的详情
        JMHomePageEndProjectDetailViewController *endProject = [[JMHomePageEndProjectDetailViewController alloc] init];
        endProject.trainProjectId = model.trainProjectId;
        [self.navigationController pushViewController:endProject animated:YES];
    }
    
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
