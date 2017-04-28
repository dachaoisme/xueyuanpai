//
//  JMExpressCompanyViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/17.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMExpressCompanyViewController.h"

@interface JMExpressCompanyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * dataArr;
    NSMutableArray * expressIdArr;

}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMExpressCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"站点";

    dataArr = [NSMutableArray array];
    expressIdArr = [NSMutableArray array];
    //创建左侧按钮
    [self createLeftBackNavBtn];
    [self createTableView];
    [self requestData];
}
-(void)requestData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [[HttpClient sharedInstance] expressCompanyListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSDictionary * tempDic = (NSDictionary *)model.responseCommonDic;
        NSArray * keyArray = [tempDic.allKeys sortedArrayUsingSelector:@selector(compare:)];;
        for (NSString * key in keyArray) {
            [dataArr addObject:[tempDic objectForKey:key]];
            [expressIdArr addObject:key];
        }
        
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return dataArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text =[dataArr objectAtIndex:indexPath.row];
    
    return cell;
    
}
//点击跳转详情视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.returnBlock([dataArr objectAtIndex:indexPath.row],[expressIdArr objectAtIndex:indexPath.row]);
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
