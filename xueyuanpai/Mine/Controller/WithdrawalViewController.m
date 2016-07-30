//
//  WithdrawalViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "WithdrawalViewController.h"
#import "TopUpTableViewCell.h"
#import "TopUpTwoTableViewCell.h"
#import "WithdrawaTableViewCell.h"
#import "SelectedBankViewController.h"
#import "BankModel.h"
@interface WithdrawalViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,TopUpTwoTableViewCellDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSString *bankMoney;
@property (nonatomic,strong)NSString *bankUserName;
@property (nonatomic,strong)NSString *bankName;
@property (nonatomic,strong)NSString *bankNum;
@property (nonatomic,strong)NSString *branchBankName;
///选择的银行卡信息
@property (nonatomic,strong)BankListModel  *bankListModel;
///输入框中展示的信息
@property (nonatomic,strong)BankModel  *bankModel;
@property (nonatomic,assign)BOOL yesCanEdit;

@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"提现";
    self.yesCanEdit = YES;
    [self createLeftBackNavBtn];
    [self createTableView];
    [self requestToSearchUserBankInfo];
    
    
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    //确定按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [button setTitle:@"提现" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(topUpAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [backGroundView addSubview:button];

    self.tableView.tableFooterView = backGroundView;
    
    
    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"TopUpTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
//    [tableView registerNib:[UINib nibWithNibName:@"TopUpTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    [tableView registerNib:[UINib nibWithNibName:@"WithdrawaTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];

}

-(void)requestToSearchUserBankInfo
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    
    [[HttpClient sharedInstance]getUserBankListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        if (responseModel.responseCode == ResponseCodeSuccess) {
            self.bankModel    = [[BankModel alloc] initWithDic:responseModel.responseCommonDic];
            self.bankUserName = self.bankModel.name;
            self.bankName     = self.bankModel.bankName;
            self.bankNum      = self.bankModel.bankNum;
            self.branchBankName = self.bankModel.branchBankName;
            _yesCanEdit = NO;
            [self creatRightNavWithTitle:@"编辑"];
        }else{
            
        }
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
}
#pragma mark - tableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return 4;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        TopUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"提现金额";
        cell.inputTextField.tag = MethodGetMoney;
        cell.inputTextField.delegate = self;
        cell.inputTextField.text = self.bankMoney;
        
        return cell;
        
    }else{
        
        if (indexPath.row == 1) {
            
            WithdrawaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.contentLabel.text = self.bankName;
            if (!_yesCanEdit) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
            
        }else {
            TopUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
            cell.inputTextField.delegate = self;
            cell.yuanLabel.hidden = YES;
            
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"姓名";
                cell.inputTextField.tag = MethodUserName;
                cell.inputTextField.text = self.bankUserName;
                if (!_yesCanEdit) {
                    cell.inputTextField.userInteractionEnabled = NO;
                }
            }else if (indexPath.row == 2){
                cell.titleLabel.text = @"支行名称";
                cell.inputTextField.tag = MethodBankName;
                cell.inputTextField.text = self.branchBankName;
                if (!_yesCanEdit) {
                    cell.inputTextField.userInteractionEnabled = NO;
                }
            }else if (indexPath.row == 3){
                cell.titleLabel.text = @"银行卡号";
                cell.inputTextField.tag = MethodBankAdress;
                cell.inputTextField.text = self.bankNum;
                if (!_yesCanEdit) {
                    cell.inputTextField.userInteractionEnabled = NO;
                }
            }

            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 42;
    }else{
        
        return 48;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==MethodGetMoney) {
        ///提取金额
        self.bankMoney = textField.text;
    }else if (textField.tag==MethodUserName){
        ///姓名
        self.bankUserName = textField.text;
    }else if (textField.tag==MethodBankName){
        ///支行名称
        self.bankName = textField.text;
    }else{
        ///银行卡号
        self.bankNum = textField.text;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    
    return YES;
}

#pragma mark - 提现
- (void)topUpAction{
    [CommonUtils showToastWithStr:@"提现"];
    [self requestToGetMoney];
}

-(void)requestToGetMoney
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.bankMoney forKey:@"amount"];
    [[HttpClient sharedInstance] getMoneyWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess ) {
            ///提现成功
            [CommonUtils showToastWithStr:@"提现成功"];
        }else{
            ///提现失败
            [CommonUtils showToastWithStr:@"提现失败"];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
#pragma mark - 支付响应的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            if (!_yesCanEdit) {
                return;
            }
            [CommonUtils showToastWithStr:@"请选择银行"];
            SelectedBankViewController * bankVC = [[SelectedBankViewController alloc]init];
            bankVC.bankListModel = self.bankListModel;
            bankVC.callBackBlock = ^(BankListModel *model){
                [tableView reloadData];
            };
            [self.navigationController pushViewController:bankVC animated:YES];
        
        }
    }
}

#pragma 推出编辑页面
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    
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
