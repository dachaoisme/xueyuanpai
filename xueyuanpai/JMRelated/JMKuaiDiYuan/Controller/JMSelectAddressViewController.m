//
//  JMSelectAddressViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSelectAddressViewController.h"

#import "JMSelectAddressTableViewCell.h"

#import "JMAddOrEditViewController.h"

@interface JMSelectAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArray;
    int currentPage;
    int pageSize;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMSelectAddressViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    currentPage=1;
    pageSize=10;
    dataArray = [NSMutableArray array];
    [self requestData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择地址";
 
    [self createLeftBackNavBtn];
    //创建收获地址静态界面
    [self createTableView];
}
-(void)requestData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance] addressListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [self.tableView.footer endRefreshing];
        
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        
        if (listArray.count == 0) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMAdressListModel *model = [JMAdressListModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            [self.tableView reloadData];

        }
        

    } withFaileBlock:^(NSError *error) {
        
    }];
}
-(void)requestMoreData
{
    currentPage=currentPage+1;
    [self requestData];
}
#pragma mark - 创建tableView
- (void)createTableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
        [self.view addSubview:_tableView];
    }
    
    
    [_tableView registerClass:[JMSelectAddressTableViewCell class] forCellReuseIdentifier:@"JMSelectAddressTableViewCell"];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    
    //在最底部添加增加收获地址
    UIButton *addAdressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addAdressBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    addAdressBtn.backgroundColor = [UIColor whiteColor];
    [addAdressBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    [addAdressBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addAdressBtn setTitleColor:[CommonUtils colorWithHex:@"00c05c"] forState:UIControlStateNormal];
    addAdressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addAdressBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAdressBtn];

}

- (void)addAddress{
    
    JMAddOrEditViewController *addVC = [[JMAddOrEditViewController alloc] init];
    addVC.title = @"新增地址";
    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMSelectAddressTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSelectAddressTableViewCell"];
    [cell.editBtn addTarget:self action:@selector(editAdress:) forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag = indexPath.row;
    JMAdressListModel *model = [dataArray objectAtIndex:indexPath.row];
    cell.nameAndPhoneLabel.text = [NSString stringWithFormat:@"%@   %@",model.user_name,model.telphone];
    cell.addressLabel.text = model.addr;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    self.returnBlock([dataArray objectAtIndex:indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 72;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.row < dataArray.count) {
            
            JMAdressListModel * model = [dataArray objectAtIndex:indexPath.row];
            
            [self requestDeleteAddressWithModel:model];
            
            [dataArray removeObjectAtIndex:indexPath.row];
            
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}


#pragma mark - 删除消息接口
- (void)requestDeleteAddressWithModel:(JMAdressListModel *)model{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setValue:model.address_id forKey:@"address_id"];
    [[HttpClient sharedInstance] deleteAddressWithParams:paramsDic withSuccessBlock:^(HttpResponseCodeModel *model) {
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
-(void)editAdress:(UIButton *)sender
{
    JMAddOrEditViewController *editVC = [[JMAddOrEditViewController alloc] init];
    editVC.title = @"编辑地址";
    editVC.addressModel = [dataArray objectAtIndex:sender.tag];
    [self.navigationController pushViewController:editVC animated:YES];
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
