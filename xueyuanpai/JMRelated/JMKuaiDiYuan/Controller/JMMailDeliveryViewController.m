//
//  JMMailDeliveryViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMailDeliveryViewController.h"

#import "JMMailDeliveryOneTypeTableViewCell.h"
#import "JMMailDeliveryTwoTypeTableViewCell.h"
#import "JMKuaiDiYuanModel.h"
@interface JMMailDeliveryViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *dataArray;
    int currentPage;
    int nextPage;
    int pageSize;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMMailDeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"收取快递";
    nextPage=currentPage=0;
    dataArray =[NSMutableArray array];
    [self createTableView];
    ///
    [self requestData];
    
}
-(void)requestData
{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [[HttpClient sharedInstance]getTrainProjectWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        [self.tableView.footer endRefreshing];
        currentPage=nextPage;
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMKuaiDiYuanModel *model = [JMKuaiDiYuanModel yy_modelWithDictionary:tempDic];
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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,50, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[JMMailDeliveryOneTypeTableViewCell class] forCellReuseIdentifier:@"JMMailDeliveryOneTypeTableViewCell"];
    
    [_tableView registerClass:[JMMailDeliveryTwoTypeTableViewCell class] forCellReuseIdentifier:@"JMMailDeliveryTwoTypeTableViewCell"];
     [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        JMMailDeliveryOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMMailDeliveryOneTypeTableViewCell"];
        
        
        return cell;
        
    }else{
        
        
        JMMailDeliveryTwoTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMMailDeliveryTwoTypeTableViewCell"];
        
        return cell;
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 66;
    }else{
        
        return 108;

    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
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
