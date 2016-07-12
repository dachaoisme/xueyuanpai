//
//  TopUpViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TopUpViewController.h"

#import "TopUpTableViewCell.h"
#import "TopUpTwoTableViewCell.h"



@interface TopUpViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,TopUpTwoTableViewCellDelegate>
{
    NSString * prepayId;
    PayMethod payMethod;
    NSString * aLiNotifyUrl;
}
@property (nonatomic,strong)UITableView *tableView;

///充值金额
@property (nonatomic,strong)NSString *topUpMoney;


@end

@implementation TopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"充值";
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
    payMethod = PayMethodWx;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateWXPaySuccess) name:NOTI_WXSUCCESS_PAY object:nil];
    
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
    [button setTitle:@"充值" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(topUpAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [backGroundView addSubview:button];

    self.tableView.tableFooterView = backGroundView;
    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"TopUpTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"TopUpTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
}
#pragma mark - tableView代理方法

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        TopUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"提现金额";
        cell.inputTextField.delegate = self;
        cell.inputTextField.text = _topUpMoney;
        
        return cell;
        
    }else{
        
        if (indexPath.row == 0) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.text = @"支付方式";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            cell.textLabel.textColor = [UIColor lightGrayColor];
            
            
            return cell;
            
        }else if(indexPath.row == 1){
            TopUpTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.payImageView.image = [UIImage imageNamed:@"acount_icon_wechat"];
            cell.payWay.text = @"微信支付";
            cell.payWay.tag = 100;
            cell.payStatusButton.tag = 100;
            if (payMethod == PayMethodWx) {
                [cell.payStatusButton setBackgroundImage:[[UIImage imageNamed:@"pay_checkbox"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            }else{
                [cell.payStatusButton setBackgroundImage:[[UIImage imageNamed:@"pay_checkbox_empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            }
            
            cell.delegate = self;
            return cell;
        }else {
            TopUpTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.payImageView.image = [UIImage imageNamed:@"acount_icon_alipay"];
            cell.payWay.text = @"支付宝支付";
            cell.payWay.tag = 101;
            cell.payStatusButton.tag = 101;
            cell.delegate = self;
            if (payMethod == PayMethodALi) {
                [cell.payStatusButton setBackgroundImage:[[UIImage imageNamed:@"pay_checkbox"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            }else{
                [cell.payStatusButton setBackgroundImage:[[UIImage imageNamed:@"pay_checkbox_empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
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
#pragma mark - 支付响应的方法TopUpTwoTableViewCellDelegate
- (void)payStyleAction:(id)sender{
    
    UIButton *button=(UIButton *)sender;
    if (button.tag==100) {
        ///微信
        if (payMethod==PayMethodWx) {
            
        }else{
            payMethod=PayMethodWx;
        }
    }else if (button.tag==101){
        ///支付宝
        if (payMethod==PayMethodWx) {
            payMethod=PayMethodALi;
        }else{
            
        }
    }else{
        
    }
    
    [self.tableView reloadData];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.topUpMoney = textField.text;
}

#pragma mark - 充值
- (void)topUpAction{
    
    if (payMethod==PayMethodWx) {
        [self wxpay];
    }else if (payMethod==PayMethodALi){
        [self aLipay];
    }else{
        
    }

}
-(void)wxpay
{
    //    [CommonUtils showToastWithStr:@"充值"];
    
    /*
     参数:
     title 标题
     order_sn 订单号
     total_fee  费用
     body 内容
     */
    /*
     {
     "appid": "wx31cb0dc3d4e9d04f",
     "sign": "CBC8ED76DAE175945BD70A1BF0D8A93D",
     "partnerid": "1359503002",
     "prepayid": "wx20160707172745e8325a4b3c0344570306",
     "package": "Sign=WXPay",
     "timestamp": 1467883665,
     "noncestr": "XmKA5GTCV3e7KihHRWgTHqrjdwT3nD",
     "total_fee": 1
     }
     */
    
    if (_topUpMoney.length == 0) {
        
        _topUpMoney = @"0.01";
        
    }
    NSString *getAccessTokenUrl = [NSString stringWithFormat:@"%@?total_fee=%@&user_id=%@&title=学院派",WeiXinPayStyleUrl,_topUpMoney,[UserAccountManager sharedInstance ].userId];
    
    NSLog(@"--- GetAccessTokenUrl: %@", getAccessTokenUrl);
    NSURLRequest *reuqest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:getAccessTokenUrl]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [NSURLConnection sendAsynchronousRequest:reuqest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (!connectionError) {
            
            
            //得到接口返回的字典数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            //处理微信回调数据
            PayReq *request = [[PayReq alloc] init];
            request.partnerId = [dic objectForKey:@"partnerid"];
            request.prepayId= [dic objectForKey:@"prepayid"];
            request.package = [dic objectForKey:@"package"];
            request.nonceStr= [dic objectForKey:@"noncestr"];
            request.timeStamp= [[dic objectForKey:@"timestamp"] intValue];
            request.sign= [dic objectForKey:@"sign"];
            [WXApi sendReq:request];
            
            prepayId = request.prepayId;
        }else{
            [CommonUtils showToastWithStr:@"请求失败"];
        }
        
        
    }];
}
-(void)aLipay
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [[HttpClient sharedInstance] aLiPayCallBackUrlWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            aLiNotifyUrl = [model.responseCommonDic objectForKey:@"notify_url"];
        }
        ///获取到支付宝支付回调地址以后，就调取支付宝SDK进行支付
    } withFaileBlock:^(NSError *error) {
        
    }];
}
#pragma mark - 微信支付成功以后，需要手动调取后台，把订单状态改成已支付状态
-(void)updateWXPaySuccess
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setObject:prepayId forKey:@"prepayid"];
    [[HttpClient sharedInstance] wxPayCallBackWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            
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
