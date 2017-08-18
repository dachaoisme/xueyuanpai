//
//  CourierNoticeViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "CourierNoticeViewController.h"

#import "CourierNoticeTableViewCell.h"
#import "ExpressCenterModel.h"
#import "JMMessageModel.h"
@interface CourierNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ExpressCenterReceiveMessageModel *expressInforModel;
    NSMutableArray * modelArray;
    NSString *totalMessageCount ;///总的消息数
    NSString *unReadyMessageCount;///未读消息数
    NSInteger pageSize;
    NSInteger pageNum;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation CourierNoticeViewController
- (void)viewWillAppear:(BOOL)animated{
    
    if (!_yesIsFromKuaiDiIndex) {
        [self theTabBarHidden:YES];
    }
    
    self.callback();

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"快递通知";
    pageSize = 10;
    pageNum = 1;
    modelArray = [NSMutableArray array];
    [self createLeftBackNavBtn];
    
    [self createTableView];
    [self requestExpressMessageList];
}

- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    if (_yesIsFromKuaiDiIndex) {
        tableView.frame=CGRectMake(CGRectGetMinX(tableView.frame), CGRectGetMinY(tableView.frame), CGRectGetWidth(tableView.frame), CGRectGetHeight(tableView.frame)-NAVIGATIONBAR_HEIGHT-NAV_TOP_HEIGHT);
        
    }
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"CourierNoticeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}


#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourierNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    JMMessageModel * model = [modelArray objectAtIndex:indexPath.row];
    cell.contentLable.text = model.message;
    cell.timeLabel.text = model.time;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 125;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.row < modelArray.count) {
            
            ExpressCenterReceiveMessageModel * model = [modelArray objectAtIndex:indexPath.row];
            
            [self requestDeleteMessage:model.ExpressCenterReceiveMessageId];
            
            [modelArray removeObjectAtIndex:indexPath.row];
            
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}


#pragma mark - 删除消息接口
- (void)requestDeleteMessage:(NSString *)message_id{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setObject:message_id forKey:@"msg_id"];
    [[HttpClient sharedInstance] deleteMessageWithParams:paramsDic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
        if (model.responseCode == ResponseCodeSuccess) {
            
            [CommonUtils showToastWithStr:@"删除成功"];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        
        
    } withFaileBlock:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
    }];
    
    
}



///发送快递记录
-(void)requestExpressMessageList
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    ///发快递序号
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",pageSize] forKey:@"size"];
    [dic setValue:@"2" forKey:@"type"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance]receivedNotificationAndExpressListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                JMMessageModel * messageModel = [JMMessageModel yy_modelWithJSON:smallDic];
                
                [modelArray addObject:messageModel ];
            }
            
            totalMessageCount = [responseModel.responseCommonDic stringForKey:@"cnt"];
            unReadyMessageCount = [responseModel.responseCommonDic stringForKey:@"unreadcnt"];
            ///处理上拉加载更多逻辑
            if (pageNum>=[pageModel.responsePageTotalCount integerValue]||arr.count<pageSize) {
                //说明是最后一张
                self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
            }
            [self.tableView reloadData];
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    
}
-(void)requestMoreData
{
    pageNum = pageNum+1;
    [self requestExpressMessageList];
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
