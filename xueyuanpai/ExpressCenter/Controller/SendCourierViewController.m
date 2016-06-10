//
//  SendCourierViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SendCourierViewController.h"

#import "SendCourierOneTableViewCell.h"
#import "SendCourierTwoTableViewCell.h"
#import "SendCourierThreeTableViewCell.h"

#import "ExpressCenterModel.h"


@interface SendCourierViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

{
    ExpressCenterPeopleModel * expressCenterPeopleModel;

}

@property (nonatomic,strong)UITableView *tableView;

///地址
@property (nonatomic,strong)NSString *address;

///取件时间
@property (nonatomic,strong)NSString *time;

///取件电话
@property (nonatomic,strong)NSString *phone;

@end

@implementation SendCourierViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [self theTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.phone = [UserAccountManager sharedInstance].userMobile;
    
    self.title = @"发快递";
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
    [self requestDistributeExpressPeople];
}

- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //发布按钮的创建
    
    float space = 16;
    float btnHeight = 44;
    float footViewHeight = 48;
    float btnWidth = SCREEN_WIDTH - 30;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footViewHeight)];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"发送取件请求" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [submitBtn setFrame:CGRectMake(space, space, btnWidth,btnHeight)];
    submitBtn.layer.cornerRadius = 10.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(sendTakeRequest) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:submitBtn];
    
    self.tableView.tableFooterView = backGroundView;
    

    
    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"SendCourierOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"SendCourierTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    [tableView registerNib:[UINib nibWithNibName:@"SendCourierThreeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"threeCell"];
}


#pragma mark - 发送取件请求
- (void)sendTakeRequest{
    
//    [CommonUtils showToastWithStr:@"发送取件请求"];

    
    [self requestSendCourier];
}


///发送取件请求
- (void)requestSendCourier{
    
    if (self.address.length<=0) {
        [CommonUtils showToastWithStr:@"请输入取件地址"];
        return;
    }else if (self.time.length<=0){
        [CommonUtils showToastWithStr:@"请输入取件时间"];
        return;
    }else if (self.phone.length<=0){
        [CommonUtils showToastWithStr:@"请输入电话"];
        return;
    }
    
    
    NSMutableDictionary  *dic = [NSMutableDictionary dictionary];
    
    /*
     参数:
     user_id          int        必需   用户序号
     courier_id       int        必需   快递员序号
     address          string     必需   取件地址
     fetchtime        string     必需   取件时间
     telphone         sgring     必需   联系电话

     */
    
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
#warning 缺少快递序号
    [dic setObject:@"快递序号" forKey:@"courier_id"];
    [dic setObject:self.address forKey:@"address"];
    [dic setObject:self.time forKey:@"fetchtime"];
    [dic setObject:self.phone forKey:@"telphone"];
    
    [[HttpClient sharedInstance] expressCenterSendExpressWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"发送取件请求成功"];
        }else{
            [CommonUtils showToastWithStr:@"发送取件请求失败"];
        }

        
    } withFaileBlock:^(NSError *error) {
        
    }];
    
    
}

///分配de快递员接口
-(void)requestDistributeExpressPeople
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[HttpClient sharedInstance]expressCenterDistributeExpressPeopleWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSString * expressPeopleCount = [model.responseCommonDic objectForKey:@"count"];
        NSLog(@"%@",expressPeopleCount);
        ///快递员信息
        expressCenterPeopleModel = [[ExpressCenterPeopleModel alloc]initWithDic:model.responseCommonDic];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
        [self.tableView reloadData];
        

    } withFaileBlock:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
    }];
}


#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        
        return 3;
 
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 120;
    }else{
        
        return 48;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SendCourierOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell bindModel:expressCenterPeopleModel];
        
        return cell;
    }else{
        
        if (indexPath.row == 0) {
            
            SendCourierTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.contextTextField.delegate = self;

            cell.contextTextField.tag = 100;

            return cell;
            
        }else if (indexPath.row == 1){
            SendCourierThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.contentLabel.textColor = [CommonUtils colorWithHex:@"c7c6cb"];
            
            
            return cell;

            
        }else{
            
            SendCourierTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleLabel.text = @"联系电话";
            
            cell.contextTextField.text = [UserAccountManager sharedInstance].userMobile;
            cell.contextTextField.delegate = self;


            cell.tag = 101;
            
            return cell;
            
           
        }
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        
        //给取件时间赋值
        self.time = @"2016-6-10";
    }
}

#pragma mark - textField的代理方法

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 100) {
        self.address = textField.text;
    }else{
        
        self.phone = textField.text;
    }

    
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 100) {
        self.address = textField.text;
    }else{
        
        self.phone = textField.text;
    }

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
