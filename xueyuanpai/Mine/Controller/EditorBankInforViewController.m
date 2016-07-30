//
//  EditorBankInforViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/7/30.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "EditorBankInforViewController.h"
#import "TopUpTableViewCell.h"
#import "TopUpTwoTableViewCell.h"
#import "WithdrawaTableViewCell.h"
#import "SelectedBankViewController.h"
@interface EditorBankInforViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)NSString *bankUserName;
@property (nonatomic,strong)NSString *bankName;
@property (nonatomic,strong)NSString *bankNum;
@property (nonatomic,strong)NSString *branchBankName;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)BankListModel  *bankListModel;
@end

@implementation EditorBankInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑银行卡信息";
    
    self.bankUserName = self.bankModel.name;
    self.bankName     = self.bankModel.bankName;
    self.bankNum      = self.bankModel.bankNum;
    self.branchBankName = self.bankModel.branchBankName;
    
    [self createLeftBackNavBtn];
    [self createTableView];
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
    [button setTitle:@"确定" forState:UIControlStateNormal];
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

#pragma mark - tableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        if (indexPath.row == 1) {
            
            WithdrawaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.contentLabel.text = self.bankName;
            return cell;
            
        }else {
            TopUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
            cell.inputTextField.delegate = self;
            cell.yuanLabel.hidden = YES;
            
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"姓名";
                cell.inputTextField.tag = MethodUserName;
                cell.inputTextField.text = self.bankUserName;
            }else if (indexPath.row == 2){
                cell.titleLabel.text = @"支行名称";
                cell.inputTextField.tag = MethodBankName;
                cell.inputTextField.text = self.branchBankName;
            }else if (indexPath.row == 3){
                cell.titleLabel.text = @"银行卡号";
                cell.inputTextField.tag = MethodBankAdress;
                cell.inputTextField.text = self.bankNum;
            }
            
            return cell;
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 42;
    }else{
        
        return 48;
    }
}
#pragma mark - 支付响应的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        [CommonUtils showToastWithStr:@"请选择银行"];
        SelectedBankViewController * bankVC = [[SelectedBankViewController alloc]init];
        bankVC.bankListModel = self.bankListModel;
        bankVC.callBackBlock = ^(BankListModel *model){
            self.bankListModel = model;
            [tableView reloadData];
        };
        [self.navigationController pushViewController:bankVC animated:YES];
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==MethodGetMoney) {
        ///提取金额
//        self.bankMoney = textField.text;
    }else if (textField.tag==MethodUserName){
        ///姓名
        self.bankUserName = textField.text;
    }else if (textField.tag==MethodBankName){
        ///支行名称
        self.branchBankName = textField.text;
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
    [CommonUtils showToastWithStr:@"确定"];
    [self requestToUpdateBankInfo];
}

-(void)requestToUpdateBankInfo
{
    /*
     
     user_id      int          必需    用户序号
     name         string       必需    姓名
     bank_id      int          必需    银行序号
     branch_bank  string       必需    支行名称
     card_no      string       必需    银行卡号
     
     @property (nonatomic,strong)NSString *bankUserName;
     @property (nonatomic,strong)NSString *bankName;
     @property (nonatomic,strong)NSString *bankNum;
     @property (nonatomic,strong)NSString *branchBankName;
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.bankUserName forKey:@"name"];
    [dic setValue:self.bankListModel?self.bankListModel.bankId:self.bankModel.bankId forKey:@"bank_id"];
    [dic setValue:self.branchBankName forKey:@"branch_bank"];
    [dic setValue:self.bankNum forKey:@"card_no"];
    [[HttpClient sharedInstance] updateBackInfoWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess ) {
            ///提现成功
            [CommonUtils showToastWithStr:@"编辑成功"];
            self.callBackBlock(self.bankModel);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ///提现失败
            [CommonUtils showToastWithStr:@"编辑失败"];
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
