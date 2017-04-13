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

@interface JMSendExpressViewController ()<UITableViewDelegate,UITableViewDataSource>

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
    
    
    [self createTableView];
}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[JMSignUpOneTypeTableViewCell class] forCellReuseIdentifier:@"JMSignUpOneTypeTableViewCell"];
    

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
            [cell.rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];
            
        }else{
            
            cell.leftTitleLabel.text = @"收件人地址";
            [cell.rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];

        }
        
    }else if (indexPath.section == 1){
        
        cell.leftTitleLabel.text = @"选择站点";
        [cell.rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];

        
    }else{
        
        cell.leftTitleLabel.text = @"选择快递公司";
        [cell.rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];
        
    }
    
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 0:{
            
            JMSelectAddressViewController *selectAddressVC = [[JMSelectAddressViewController alloc] init];
            
            [self.navigationController pushViewController:selectAddressVC animated:YES];
        }
            break;
        case 1:{
            
            [CommonUtils showToastWithStr:@"选择站点"];
        }
            break;

        case 2:{
            
            [CommonUtils showToastWithStr:@"选择快递公司"];

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
