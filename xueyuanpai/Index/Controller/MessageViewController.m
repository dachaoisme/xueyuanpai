//
//  MessageViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MessageViewController.h"

#import "MessageTableViewCell.h"
#import "PPDragDropBadgeView.h"

#import "SystemMessageListViewController.h"
#import "CourierNoticeViewController.h"
#import "BusinessCenterMessageListViewController.h"
#import "OnSiteMessageListViewController.h"
#import "TimeBankMessageListViewController.h"


@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

///系统消息数量
@property (nonatomic,strong)NSString *systemMessageCount;

///快递消息数量
@property (nonatomic,strong)NSString *courierMessageCount;

///创业消息数量
@property (nonatomic,strong)NSString *businessMessageCount;

///站内未读消息数量
@property (nonatomic,strong)NSString *onSiteMessageCount;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息";
    
    [self createLeftBackNavBtn];
    
    
    [self createTableView];
    
    
    //请求系统消息未读数量
    [self requestUnReadSystemMessage];
    
    //请求快递消息未读数量
    [self requestUnReadCourierMessage];
    
    //请求创业消息未读消息数量
    [self requestUnReadBusinessMessage];
    
    //请求站内消息未读消息数量
    [self requestUnReadOnSiteMessage];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self theTabBarHidden:YES];
    
    [super viewWillAppear:animated];
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //注册cell
    [tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"cell"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        cell.leftImageView.image = [UIImage imageNamed:@"msg_icon_system"];
        cell.contentLabel.text = @"系统通知";
        
        if ([self.systemMessageCount intValue] > 0) {
            //设置消息数目的
            cell.badgeView.text = [NSString stringWithFormat:@"%@", self.systemMessageCount];
 
        }else{
            
            cell.badgeView.hidden = YES;
        }
        
    }else if (indexPath.row == 1) {
        
        cell.leftImageView.image = [UIImage imageNamed:@"msg_icon_deliver"];
        cell.contentLabel.text = @"快递消息";
        
        if ([self.courierMessageCount intValue] > 0) {
            //设置消息数目的
            cell.badgeView.text = [NSString stringWithFormat:@"%@", self.courierMessageCount];
            
        }else{
            
            cell.badgeView.hidden = YES;
        }

        
    }else if (indexPath.row == 2) {
        cell.leftImageView.image = [UIImage imageNamed:@"msg_icon_startup"];
        cell.contentLabel.text = @"创业消息";
        
        if ([self.businessMessageCount intValue] > 0) {
            //设置消息数目的
            cell.badgeView.text = [NSString stringWithFormat:@"%@", self.businessMessageCount];
            
        }else{
            
            cell.badgeView.hidden = YES;
        }


        
    }else if (indexPath.row == 3) {
        cell.leftImageView.image = [UIImage imageNamed:@"msg_icon_mail"];
        cell.contentLabel.text = @"站内消息";
        
        if ([self.onSiteMessageCount intValue] > 0) {
            //设置消息数目的
            cell.badgeView.text = [NSString stringWithFormat:@"%@", self.onSiteMessageCount];
            
        }else{
            
            cell.badgeView.hidden = YES;
        }
        


        
    }else if (indexPath.row == 4) {
        cell.leftImageView.image = [UIImage imageNamed:@"msg_icon_mail"];
        cell.contentLabel.text = @"时间银行消息";
        
        if ([self.onSiteMessageCount intValue] > 0) {
            //设置消息数目的
            cell.badgeView.text = [NSString stringWithFormat:@"%@", self.onSiteMessageCount];
            
        }else{
            
            cell.badgeView.hidden = YES;
        }
        
        
        
        
    }


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //跳转系统消息列表
        SystemMessageListViewController *systemMessageListVC = [[SystemMessageListViewController alloc] init];
        systemMessageListVC.callback = ^(){
            self.systemMessageCount = @"0";
            [tableView reloadData];
        };
        [self.navigationController pushViewController:systemMessageListVC animated:YES];
    }else if (indexPath.row == 1){
        
        //跳转快递消息
        CourierNoticeViewController *courierNoticeVC = [[CourierNoticeViewController alloc] init];
        courierNoticeVC.callback = ^(){
            self.courierMessageCount = @"0";
            [tableView reloadData];
            
            
        };

        [self.navigationController pushViewController:courierNoticeVC animated:YES];
        
        
    }else if (indexPath.row == 2){
        //跳转创业消息
        BusinessCenterMessageListViewController *businessCenterMessageVC = [[BusinessCenterMessageListViewController alloc] init];
        businessCenterMessageVC.callback = ^(){
            self.businessMessageCount = @"0";
            [tableView reloadData];

            
        };
        [self.navigationController pushViewController:businessCenterMessageVC animated:YES];
        
        
        
    }else if (indexPath.row == 3){
        //站内消息
        OnSiteMessageListViewController *onsiteMessageVC = [[OnSiteMessageListViewController alloc] init];
        onsiteMessageVC.callback = ^(){
            self.onSiteMessageCount = @"0";
            [tableView reloadData];
            
            
        };

        [self.navigationController pushViewController:onsiteMessageVC animated:YES];
        
        
    }else if (indexPath.row == 4){
        
        //跳转时间银行消息
        TimeBankMessageListViewController *timeBankMessageVC = [[TimeBankMessageListViewController alloc] init];
        timeBankMessageVC.callback = ^(){
            self.onSiteMessageCount = @"0";
            [tableView reloadData];
            
            
        };
        [self.navigationController pushViewController:timeBankMessageVC animated:YES];
        
    }
}

#pragma mark - 请求系统消息未读消息数目
- (void)requestUnReadSystemMessage{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance] getSystemUnReadMessageCountWithParams:paramsDic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (model.responseCode == ResponseCodeSuccess) {

            self.systemMessageCount = [model.responseCommonDic objectForKey:@"cnt"];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        
        [self.tableView reloadData];
        
    } withFaileBlock:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        
    }];
}


#pragma mark - 请求快递消息未读消息数目
///发送快递记录
-(void)requestUnReadCourierMessage
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    ///发快递序号
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:@"1" forKey:@"page"];
    [dic setValue:@"10" forKey:@"size"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance]receivedNotificationAndExpressListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            _courierMessageCount = [responseModel.responseCommonDic stringForKey:@"unreadcnt"];
            
            [self.tableView reloadData];

            
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}


#pragma mark - 请求创业消息未读消息数目
- (void)requestUnReadBusinessMessage{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [paramsDic setValue:@"1" forKey:@"page"];
    [paramsDic setValue:@"10" forKey:@"size"];
    
    
    [[HttpClient sharedInstance] getProgectMessageListWithParams:paramsDic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
        
        
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            _businessMessageCount = [responseModel.responseCommonDic stringForKey:@"unreadcnt"];
            
            [self.tableView reloadData];
 
            
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];

    
}

#pragma mark - 请求站内消息未读消息数目
- (void)requestUnReadOnSiteMessage{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [paramsDic setValue:@"1" forKey:@"page"];
    [paramsDic setValue:@"10" forKey:@"size"];
    
    
    [[HttpClient sharedInstance] getInboxInsideMessageListWithParams:paramsDic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
        
        
        if (responseModel.responseCode == ResponseCodeSuccess) {
            

            _onSiteMessageCount = [responseModel.responseCommonDic stringForKey:@"unreadcnt"];
            
            [self.tableView reloadData];

            
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
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
