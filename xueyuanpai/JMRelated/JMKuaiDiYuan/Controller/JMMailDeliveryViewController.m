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

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //接收通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCurrentPage:) name:@"kRefrshMyKuaidi" object:nil];
    
    self.title = @"寄出快递";
    [self createTableView];
    
    
    nextPage=currentPage=1;
    pageSize  =10;
    dataArray =[NSMutableArray array];
    
    ///
    [self requestData];
}


- (void)refreshCurrentPage:(NSNotification *)notification{
    
    NSDictionary  *dict=[notification userInfo];
    
    NSString *index = [dict valueForKey:@"index"];
    
    
    if ([index isEqualToString:@"0"]) {
        
        //刷新当前界面
        ///请求数据
        nextPage=currentPage=1;
        pageSize  =10;
        dataArray =[NSMutableArray array];
        
        [self.tableView reloadData];

        
        ///
        [self requestData];
        
    }
    
    
    
    
}



-(void)requestData
{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance]haveSentExpressListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        [self.tableView.footer endRefreshing];
        currentPage=nextPage;
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMKuaiDiYuanModel *model = [JMKuaiDiYuanModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            
        }
        
        if (listArray.count == 0) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        
        [self.tableView reloadData];
        ///如果没有数据，则加载空数据页面
        if (dataArray.count==0) {
            self.tableView.hidden = YES;
            [CommonView emptyViewWithView:self.view];
        }
    } withFaileBlock:^(NSError *error) {
        ///如果没有数据，则加载空数据页面
        if (dataArray.count==0) {
            self.tableView.hidden = YES;
            [CommonView emptyViewWithView:self.view];
        }
    }];
}
-(void)requestMoreData
{
    currentPage=currentPage+1;
    [self requestData];
}
#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT - NAV_TOP_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[JMMailDeliveryOneTypeTableViewCell class] forCellReuseIdentifier:@"JMMailDeliveryOneTypeTableViewCell"];
    
    [_tableView registerClass:[JMMailDeliveryTwoTypeTableViewCell class] forCellReuseIdentifier:@"JMMailDeliveryTwoTypeTableViewCell"];
     [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        JMMailDeliveryOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMMailDeliveryOneTypeTableViewCell"];
        JMKuaiDiYuanModel *model = [dataArray objectAtIndex:indexPath.section];
        cell.showOrderNumberLabel.text = [NSString stringWithFormat:@"订单编号%@",model.order_id];
        cell.showDateLabel.text = model.create_time;
        
        if ([model.status integerValue]==0) {
            ///等待寄出
            cell.showOrderNumberLabel.textColor=[CommonUtils colorWithHex:NORMAL_TITLE_BLACK_COLOR];
            
            cell.showStatuesLabel.text = @"等待寄出";
            cell.showStatuesLabel.textColor = [CommonUtils colorWithHex:@"fb8c6e"];
            cell.showWaitTimeLabel.text = @"";
            cell.showWaitTimeLabel.hidden = NO;
        }else if ([model.status integerValue]==1){
            ///已寄出
            cell.showOrderNumberLabel.textColor=[CommonUtils colorWithHex:NORMAL_TITLE_BLACK_COLOR];
            
            cell.showStatuesLabel.text = @"已寄出";
            cell.showStatuesLabel.textColor = [CommonUtils colorWithHex:NORMAL_SUBTITLE_BLACK_COLOR];
            cell.showWaitTimeLabel.hidden = YES;
        }else{
            ///未寄出失败
            cell.showOrderNumberLabel.textColor=[CommonUtils colorWithHex:NORMAL_SUBTITLE_BLACK_COLOR];
            
            cell.showStatuesLabel.text = @"未寄出失败";
            cell.showStatuesLabel.textColor = [CommonUtils colorWithHex:NORMAL_SUBTITLE_BLACK_COLOR];
            cell.showWaitTimeLabel.hidden = YES;
        }
        
        return cell;
        
    }else{
        
        
        JMMailDeliveryTwoTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMMailDeliveryTwoTypeTableViewCell"];
        JMKuaiDiYuanModel *model = [dataArray objectAtIndex:indexPath.section];
        if ([model.status integerValue]==0) {
            ///等待寄出
            cell.jiImageView.image =[UIImage imageNamed:@"send_address_a"];
            
            cell.quImageView.image =[UIImage imageNamed:@"receive_address_b"];
            
            cell.jiAddressLabel.textColor = [CommonUtils colorWithHex:NORMAL_TITLE_BLACK_COLOR];
            cell.quAddressLabel.textColor = [CommonUtils colorWithHex:NORMAL_TITLE_BLACK_COLOR];
        }else if ([model.status integerValue]==1){
            ///已寄出
            cell.jiImageView.image =[UIImage imageNamed:@"send_address_a"];
            
            cell.quImageView.image =[UIImage imageNamed:@"receive_address_b"];
            
            cell.jiAddressLabel.textColor = [CommonUtils colorWithHex:NORMAL_TITLE_BLACK_COLOR];
            cell.quAddressLabel.textColor = [CommonUtils colorWithHex:NORMAL_TITLE_BLACK_COLOR];
        }else{
            ///未寄出失败
            cell.jiImageView.image =[UIImage imageNamed:@"send_address_a_grey"];
            
            cell.quImageView.image =[UIImage imageNamed:@"receive_address_b_grey"];
            
            cell.jiAddressLabel.textColor = [CommonUtils colorWithHex:NORMAL_SUBTITLE_BLACK_COLOR];
            cell.quAddressLabel.textColor = [CommonUtils colorWithHex:NORMAL_SUBTITLE_BLACK_COLOR];
        }
        cell.jiAddressLabel.text = [NSString stringWithFormat:@"%@(%@)%@",model.sender_addr.user_name,model.sender_addr.telphone,model.sender_addr.addr];
        cell.quAddressLabel.text = [NSString stringWithFormat:@"%@(%@)%@",model.receiver_addr.user_name,model.receiver_addr.telphone,model.receiver_addr.addr];
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
