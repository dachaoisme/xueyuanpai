//
//  JMSendExpressViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSendExpressViewController.h"

#import "JMSignUpOneTypeTableViewCell.h"

#import "JMSelectAddressViewController.h"
#import "JMExpressSiteModel.h"
#import "JMExpressSiteViewController.h"
#import "JMExpressCompanyViewController.h"
#import "JMSuccessSendExpressViewController.h"
@interface JMSendExpressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    JMAdressListModel *sendAddressModel;
    JMAdressListModel *receiveAddressModel;
    JMExpressSiteModel *expressSiteModel;
    NSString *expressCompanyName;
    NSString *expressCompanyId;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMSendExpressViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"寄快递";
    
    [self createLeftBackNavBtn];
    
    self.view.backgroundColor =[CommonUtils colorWithHex:@"e5e5e5"];
    [self createTableView];
}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    int sureBtnHeight = 50;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-sureBtnHeight-10) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [CommonUtils colorWithHex:@"e5e5e5"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[JMSignUpOneTypeTableViewCell class] forCellReuseIdentifier:@"JMSignUpOneTypeTableViewCell"];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundColor:[CommonUtils colorWithHex:@"00c05c"]];
    [sureBtn setFrame:CGRectMake(10, SCREEN_HEIGHT-sureBtnHeight-10, SCREEN_WIDTH-10*2, sureBtnHeight)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 5;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
        
    }else{
        
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMSignUpOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSignUpOneTypeTableViewCell"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            cell.leftTitleLabel.text = @"寄件人地址";
            if (sendAddressModel) {
                [cell.rightContentBtn setTitle:sendAddressModel.addr forState:UIControlStateNormal];
            }else{
                [cell.rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];
            }
            
            
        }else{
            
            cell.leftTitleLabel.text = @"收件人地址";
            if (receiveAddressModel) {
                [cell.rightContentBtn setTitle:receiveAddressModel.addr forState:UIControlStateNormal];
            }else{
                [cell.rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];
            }
        }
    }else if (indexPath.section == 1){
        
        cell.leftTitleLabel.text = @"选择站点";
        if (expressSiteModel) {
            [cell.rightContentBtn setTitle:expressSiteModel.site_name forState:UIControlStateNormal];
        }else{
            [cell.rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];
        }

    }else{
        cell.leftTitleLabel.text = @"选择快递公司";
        if (expressCompanyName && expressCompanyName.length>0) {
            [cell.rightContentBtn setTitle:expressCompanyName forState:UIControlStateNormal];
        }else{
            [cell.rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];
        }
        
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    weakSelf(weakSelf);
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                
                JMSelectAddressViewController *selectAddressVC = [[JMSelectAddressViewController alloc] init];
                selectAddressVC.returnBlock = ^(JMAdressListModel *returnAddressModel) {
                    sendAddressModel = returnAddressModel;
                    [weakSelf.tableView reloadData];
                };
                [self.navigationController pushViewController:selectAddressVC animated:YES];
                
            }else{
                
                JMSelectAddressViewController *selectAddressVC = [[JMSelectAddressViewController alloc] init];
                selectAddressVC.returnBlock = ^(JMAdressListModel *returnAddressModel) {
                    receiveAddressModel = returnAddressModel;
                    [weakSelf.tableView reloadData];
                };
                [self.navigationController pushViewController:selectAddressVC animated:YES];
                
            }
            
            
        }
            break;
        case 1:{
            
            [CommonUtils showToastWithStr:@"选择站点"];
            JMExpressSiteViewController  *expressSiteVC = [[JMExpressSiteViewController alloc] init];
            expressSiteVC.returnBlock = ^(JMExpressSiteModel*returnExpressSiteModel) {
                expressSiteModel = returnExpressSiteModel;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:expressSiteVC animated:YES];
        }
            break;

        case 2:{
            
            [CommonUtils showToastWithStr:@"选择快递公司"];
            JMExpressCompanyViewController  *expressSiteVC = [[JMExpressCompanyViewController alloc] init];
            expressSiteVC.returnBlock = ^(NSString *companyName, NSString *companyId) {
                expressCompanyName =companyName;
                expressCompanyId = companyId;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:expressSiteVC animated:YES];
        }
            break;

            
        default:
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

-(void)sure:(UIButton *)sender
{
    [CommonUtils showToastWithStr:@"确定"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:sendAddressModel.address_id forKey:@"sender_addr"];
    [dic setValue:receiveAddressModel.address_id forKey:@"receive_addr"];
    [dic setValue:expressSiteModel.expressSiteId forKey:@"expresssite_id"];
    [dic setValue:expressCompanyId forKey:@"expresscompany_id"];
    [[HttpClient sharedInstance] sendExpressWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"寄件成功"];
            NSString *orderId = [model.responseCommonDic objectForKey:@"order_id"];
            JMSuccessSendExpressViewController *successSendExpressVC = [[JMSuccessSendExpressViewController alloc] init];
            successSendExpressVC.orderId = orderId;
            [self.navigationController pushViewController:successSendExpressVC animated:YES];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
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
