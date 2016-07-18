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
#import "PayOrder.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
//#import "APAuthV2Info.h"

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateWXPaySuccessWithNotification:) name:NOTI_WXSUCCESS_PAY object:nil];
    
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
     user_id             int       必需      当前用户序号
     title                string 必需 标题
     order_sn             string 订单号
     total_fee             float 费用
     body                  string 内容
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
    //获取当前时间apptime
    NSString *appCurrentTimeString = [NSString stringWithFormat:@"%ld", time(NULL)];//转为字符型
    //加密MD5KEY
    NSString * md5key = @"8409-4E89-A81A-B7FF-u(#d";
    NSString *sign = [[CommonUtils md5:[appCurrentTimeString stringByAppendingString:md5key]] uppercaseString];
    NSString *title = @"学院派";
    NSString *getAccessTokenUrl = [NSString stringWithFormat:@"%@?total_fee=%@&user_id=%@&title=%@&apptime=%@&sign=%@",WeiXinPayStyleUrl,_topUpMoney,[UserAccountManager sharedInstance ].userId,[title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],appCurrentTimeString,sign];
    
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
    
    //获取当前时间apptime
    NSString *appCurrentTimeString = [NSString stringWithFormat:@"%ld", time(NULL)];//转为字符型
    //加密MD5KEY
    NSString * md5key = @"8409-4E89-A81A-B7FF-u(#d";
    NSString *sign = [[CommonUtils md5:[appCurrentTimeString stringByAppendingString:md5key]] uppercaseString];
    NSString *getAccessTokenUrl = [NSString stringWithFormat:@"%@%@apptime=%@&sign=%@",baseApiUrl,SYSTEM_ALIPAY_CALLBACK,appCurrentTimeString,sign];
    
    NSLog(@"--- GetAccessTokenUrl: %@", getAccessTokenUrl);
    
    NSURLRequest *reuqest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:getAccessTokenUrl]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [NSURLConnection sendAsynchronousRequest:reuqest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (!connectionError) {
            //得到接口返回的字典数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            aLiNotifyUrl = [dic objectForKey:@"notify_url"];
            [self doAliPay:aLiNotifyUrl withMoneyOfALiToPay:_topUpMoney];
            
        }else{
            [CommonUtils showToastWithStr:@"请求失败"];
        }
        
        
    }];
}

- (void)doAliPay:(NSString*)callBackUrl withMoneyOfALiToPay:(NSString *)moneyOfALiToPay
{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    //学院派的支付宝账户
    NSString *partner = @"2088221848035302";
    NSString *seller = @"ucpai_111@163.com";
    NSString * privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALOtZYaiJK4VsCUSlUgYzKbMkfU5Bomoxq+4UgqKNNJJ4hvyapIJF6GP58kHK91vHSSMjEjkwcyzVOoqy7xLclIxz6D0DjlIsvMaFiOmQACfrLi/W5na9SLQTnMMsRnveJFtacGXSQzq0FLGgdy+ZTgyy3aRekQoJZQ7WisS7aUzAgMBAAECgYAl7tmcTucHibSiXwX9Lp8mJ9I4v01OCr/HoVZQu1TjgI2n8MnnAtxmU4dPvZ/ZI/g3GyUSzpjLqqCmv1o76oG71cWtJk4Z1/U+ofQZIv7UYQ481CdmopRzo2+xatSeehFxzB7J4KLJDNq8Szw1kDHDa6+HzBRDF+rPHy+Hgi/VoQJBAOiFxX3Z3ijtc8/LxskN3ec9/08e8qhTVVhS7CgCI2cBKWQMIatzqWlIl/1yw/6SW5ptRt1Dp9nzRAnoex7FKOcCQQDF0a9tHXvyRbVVC56HDIzaR9WXiCphbFOTmb6Agq5S4oBIaUgCGSaHTpKitmsKcCPEDZllsBN1PQ/9XbqUU9vVAkAPRTnDGhvM9Es2ylszuQVpuliaCZ5GD7L7Kfb4aauJiDn/qAxOBjqJ/4p7yp20ikgZzDNrNJZBagh93ha33prhAkEAg3DSWXRP2SkMVdgEm8NxC9DTUX5+eoFZ/ycW95jdb+FkT7j0ycAgY6OHt2nyMdtVSH2owXJ/W1UZfMZ8pPYbiQJAXE3zDb9BTk1ROWFwK9PVQ1t0qo9cwk79e20I9dvkJM4NHwciTj5nSpL6HqiaBBPHwld2q/gfAgPL3lWfOacUeQ==";
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    PayOrder  *order = [[PayOrder alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.subject = @"学院派";//product.subject; //商品标题
    order.body = @"学院派充值"; //商品描述
    order.totalFee = [NSString stringWithFormat:@"%.2f",[_topUpMoney floatValue]]; //商品价格
    order.notifyURL = callBackUrl; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"xueyuanpaiAli";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString * orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString
                                  fromScheme:appScheme
                                    callback:^(NSDictionary *resultDic) {
                                        int statusCode = [[resultDic objectForKey:@"resultStatus"] intValue];
                                        switch (statusCode) {
                                                
                                            case PayStatusCancel:
                                            {
                                                //取消付款
                                                [CommonUtils showToastWithStr:@"支付失败"];
                                                MFLog(@"用户取消支付");
                                            }
                                                break;
                                                
                                            case PayStatusSuccess:
                                            {
                                                [CommonUtils showToastWithStr:@"支付成功"];
                                                MFLog(@"支付成功");
                                            }
                                                break;
                                                
                                            case PayStatusUnusual:
                                            {
                                                [CommonUtils showToastWithStr:@"支付失败"];
                                                MFLog(@"系统异常");
                                            }
                                                break;
                                                
                                            case PayStatusNetError:
                                            {
                                                [CommonUtils showToastWithStr:@"支付失败"];
                                                MFLog(@"网络异常");
                                            }
                                                break;
                                                
                                            case PayStatusParamError:
                                                
                                            {
                                                [CommonUtils showToastWithStr:@"支付失败"];
                                                MFLog(@"订单参数错误");
                                            }
                                                break;
                                        }
                                        
                                        
                                    }];
    }
}

#pragma mark - 微信支付成功以后，需要手动调取后台，把订单状态改成已支付状态
-(void)updateWXPaySuccessWithNotification:(NSNotification *)notification
{
    int errorCode = [[notification object] intValue];
    switch (errorCode) {
        case WXSuccess:
            //strMsg = @"支付结果：成功！";
            //NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            [CommonUtils showToastWithStr:@"支付成功"];
            [self changeWXPayStatus];
            break;
            
        default:
            //strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            //NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            [CommonUtils showToastWithStr:@"支付失败"];
            break;
    }
    
   
}
-(void)changeWXPayStatus
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

#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
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
