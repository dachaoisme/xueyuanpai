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

#pragma mark - 充值
- (void)topUpAction{
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
    
    
    NSString *getAccessTokenUrl = [NSString stringWithFormat:@"%@?total_fee=%@",WeiXinPayStyleUrl,_topUpMoney];
    
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
            
            
            
        }else{
            [CommonUtils showToastWithStr:@"请求失败"];
        }
        
        
    }];

    
    
    /*
    [[HttpClient sharedInstance]weiXinPayWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
//        if (model.responseCode ==ResponseCodeSuccess) {
//            ///请求成功
//            //
//            
//            
//            
//            
//        }else{
//            ///反馈失败
//            [CommonUtils showToastWithStr:model.responseMsg];
//        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        

        
    }];
     */

    
    
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
            [cell.payStatusButton setBackgroundImage:[[UIImage imageNamed:@"pay_checkbox"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            cell.delegate = self;
            return cell;
        }else {
            TopUpTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.payImageView.image = [UIImage imageNamed:@"acount_icon_alipay"];
            cell.payWay.text = @"支付宝支付";
            cell.payWay.tag = 101;
            cell.delegate = self;
            [cell.payStatusButton setBackgroundImage:[[UIImage imageNamed:@"pay_checkbox_empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            
            
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


#pragma mark - 支付响应的方法
- (void)payStyleAction:(id)sender{
    
    UIButton *button=(UIButton *)sender;
    [button setSelected:!button.selected];
    
    if (button.selected) {
        [button setImage:[[UIImage imageNamed:@"pay_checkbox"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal]; //被勾选中的图片
    }else {
        
        [button setImage:[[UIImage imageNamed:@"pay_checkbox_empty"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];　//未被勾选中的图片
    }
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.topUpMoney = textField.text;
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
