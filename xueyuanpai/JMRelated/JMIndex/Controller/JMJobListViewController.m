//
//  JMJobListViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMJobListViewController.h"

@interface JMJobListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMJobListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    //创建左侧按钮
    [self createLeftBackNavBtn];
    [self createTableView];
    [self requestJobList];
}
-(void)requestJobList
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.trainProjectId  forKey:@"project_id"];
    [[HttpClient sharedInstance] jobListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        dataArray = [model.responseCommonDic objectForKey:@"jobs"];
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    return cell;
    
}
//点击跳转详情视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.returnBlock([dataArray objectAtIndex:indexPath.row]);
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
