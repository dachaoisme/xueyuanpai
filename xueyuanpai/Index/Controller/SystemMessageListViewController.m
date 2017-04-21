//
//  SystemMessageListViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SystemMessageListViewController.h"
#import "CourierNoticeTableViewCell.h"

#import "SystemMessageListModel.h"

#import "SystemMessageDetailViewController.h"
#import "JMMessageModel.h"

@interface SystemMessageListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int pageSize;
    int pageNum;

}
///消息列表数组
@property (nonatomic,strong)NSMutableArray *messageListArray;

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation SystemMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.messageListArray = [NSMutableArray array];
    pageNum = 1;
    pageSize = 10;

    
    self.title = @"系统通知";
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
    [self requestSystemMessageData];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    self.callback();
}

#pragma mark - 请求消息列表数据
- (void)requestSystemMessageData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [paramsDic setValue:[NSString stringWithFormat:@"%d",pageNum] forKey:@"page"];
    [paramsDic setValue:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [paramsDic setValue:@"1" forKey:@"type"];

    
    [[HttpClient sharedInstance] getSystemMessageListWithParams:paramsDic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];

        
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            for (NSDictionary * dic in [ListDic objectForKey:@"lists"] ) {
                
                JMMessageModel * model = [JMMessageModel yy_modelWithJSON:dic];
                [_messageListArray addObject:model];
            }
            
            ///处理上拉加载更多逻辑
            if (pageNum>=[pageModel.responsePageTotalCount integerValue]) {
                //说明是最后一张
                self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
            }
            [self.tableView reloadData];


        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        
        

    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];

        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
    
}

-(void)requestMoreData
{
    pageNum = pageNum+1;
    [self requestSystemMessageData];
}

#pragma mark - 将消息标记为已读
- (void)requestReadMessage:(NSString *)messageID{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [paramsDic setValue:messageID.length > 0?messageID:@"" forKey:@"msg_id"];
    [[HttpClient sharedInstance] setSystemMessageStatusWithParams:paramsDic withSuccessBlock:^(HttpResponseCodeModel *model) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (model.responseCode == ResponseCodeSuccess) {
            
            
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }

        
        
        
    } withFaileBlock:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
}

- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
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
    
    return _messageListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourierNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    JMMessageModel *model = [_messageListArray objectAtIndex:indexPath.row];
    
    cell.leftImageView.image = [UIImage imageNamed:@"msg_icon_xueyuanpai"];
    
    cell.contentLable.text = model.message;
    
    cell.timeLabel.text = model.time;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMMessageModel * model = [_messageListArray objectAtIndex:indexPath.row];
    //[self requestReadMessage:model.messageID];
    
    SystemMessageDetailViewController *detailVC = [[SystemMessageDetailViewController alloc] init];
    detailVC.messageID = model.messageId;
    detailVC.messageModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.row < _messageListArray.count) {
            
            SystemMessageListModel * model = [_messageListArray objectAtIndex:indexPath.row];

            [self requestDeleteMessage:model.messageID];
            
            [_messageListArray removeObjectAtIndex:indexPath.row];
            
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}


#pragma mark - 删除消息接口
- (void)requestDeleteMessage:(NSString *)message_id{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setValue:message_id forKey:@"msg_id"];
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
