//
//  SendCourierReecordViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SendCourierReecordViewController.h"

#import "SendCourierRecordTableViewCell.h"

@interface SendCourierReecordViewController ()<UITableViewDataSource,UITableViewDelegate,SendCourierRecordTableViewCellDelegate>
{
    ExpressCenterPeopleModel * expressCenterPeopleModel;
    
    ExpressCenterExpressInfoModel * expressInforModel;

}

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *modelArray;

@end

@implementation SendCourierReecordViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [self theTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _modelArray = [[NSMutableArray alloc] init];
    
    
    self.title = @"发快递记录";
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
    [self requestExpressHistory];
    
}

- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"SendCourierRecordTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

///发送快递记录
-(void)requestExpressHistory
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    ///发快递序号
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:@"1" forKey:@"page"];
    [dic setValue:@"10" forKey:@"size"];
    [[HttpClient sharedInstance]expressCenterExpressListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                expressInforModel = [[ExpressCenterExpressInfoModel alloc]initWithDic:smallDic];
                
                [_modelArray addObject:expressInforModel];
            }
            
            [self.tableView reloadData];
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
    
}



#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SendCourierRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    
    ExpressCenterExpressInfoModel * model = [_modelArray objectAtIndex:indexPath.section];
    
    [cell bindModel:model];
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 210;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}


#pragma mark - 打电话

- (void)call{
    
    [CommonUtils callServiceWithTelephoneNum:expressInforModel.expressCenterExpressInfoFetchTelephone];

}

#pragma mark - 取消取件
- (void)cancleTakeThing{
    
    [self requestCancelSendExpress];
}

///取消发送快递
-(void)requestCancelSendExpress
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    ///发快递序号
    [dic setValue:expressCenterPeopleModel.ExpressCenterPeopleId forKey:@"id"];
    [[HttpClient sharedInstance]expressCenterCancelExpressWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///发件成功
            [CommonUtils showToastWithStr:@"取消发件成功"];
        }else
        {
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [CommonUtils showToastWithStr:@"取消发件成功"];
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
