//
//  BusinessCenterMessageDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/7/1.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessCenterMessageDetailViewController.h"

#import "JSONKit.h"

@interface BusinessCenterMessageDetailViewController ()

@end

@implementation BusinessCenterMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = @"创业项目申领";
    
    [self createLeftBackNavBtn];
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    
    [self initDetailView];
}

#pragma mark - 初始化详情视图
- (void)initDetailView{
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH, 280)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGroundView];
    
    //头像
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    headImageView.image = [UIImage imageNamed:@"placeHoder"];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 20;
    [backGroundView addSubview:headImageView];
    
    //时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 15, 180, 30)];
//    timeLabel.text = @"2016-7-1";
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = [UIColor lightGrayColor];
    [backGroundView addSubview:timeLabel];
    
    
    //内容
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame), CGRectGetMaxY(timeLabel.frame) - 15, SCREEN_WIDTH - CGRectGetMaxX(headImageView.frame) - 20, 30)];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor lightGrayColor];
    [backGroundView addSubview:contentLabel];
    
    
    //详情解释
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame), CGRectGetMaxY(headImageView.frame)+30,CGRectGetWidth(contentLabel.frame), 50)];
    detailLabel.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [backGroundView addSubview:detailLabel];
    
    if ([self.title  isEqualToString:@"时间银行申请"]) {
        contentLabel.text = _timeBankMessageModel.timeBankMessageTitle;
        timeLabel.text = _timeBankMessageModel.timeBankMessageCreateTime;
        detailLabel.text = _timeBankMessageModel.timeBankMessageMsg;
        

        
    }else{
        
        contentLabel.text = _inboxProgectModel.inboxProgectMessageTitle;
        timeLabel.text = _inboxProgectModel.inboxProgectMessageCreateTime;
        detailLabel.text = _inboxProgectModel.inboxProgectMessageMsg;


    }
    
    
    //同意好友请求button
    UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeButton.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [agreeButton setTitle:@"同意" forState:UIControlStateNormal];
    [agreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    agreeButton.frame = CGRectMake(CGRectGetMinX(detailLabel.frame), CGRectGetMaxY(detailLabel.frame) + 20, (CGRectGetWidth(detailLabel.frame) - 20)/2, 40);
    agreeButton.layer.cornerRadius = 10;
    [agreeButton addTarget:self action:@selector(agreeApplyAction:) forControlEvents:UIControlEventTouchUpInside];
    agreeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:agreeButton];
    
    
    //拒绝好友的button
    UIButton *refusedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    refusedButton.backgroundColor = [CommonUtils colorWithHex:@"d8d8d8"];
    [refusedButton setTitle:@"拒绝" forState:UIControlStateNormal];
    [refusedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    refusedButton.frame = CGRectMake(CGRectGetMaxX(agreeButton.frame) + 20, CGRectGetMaxY(detailLabel.frame) + 20, (CGRectGetWidth(detailLabel.frame) - 20)/2, 40);
    refusedButton.layer.cornerRadius = 10;
    refusedButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [refusedButton addTarget:self action:@selector(refusedApplyAction:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:refusedButton];

    
    //发私信按钮
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    messageButton.frame =  CGRectMake(CGRectGetMinX(agreeButton.frame), CGRectGetMaxY(refusedButton.frame) + 20, CGRectGetWidth(contentLabel.frame), 40);
    [messageButton setImage:[UIImage imageNamed:@"msg_icon_chat"] forState:UIControlStateNormal];
    messageButton.layer.borderWidth = 1;
    messageButton.layer.cornerRadius = 10;
    messageButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [messageButton setTitle:@"发私信" forState:UIControlStateNormal];
    [messageButton setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    messageButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:messageButton];
    
    
    
    
}

- (void)agreeApplyAction:(id)sender{
    
    if ([self.title  isEqualToString:@"时间银行申请"]) {
        
        [self requestTimeBankAgreeAction];
    }else{
        
        //创业项目申领状态
        [self requestBusinessCenterAgreeAction];
        
    }
}

- (void)refusedApplyAction:(id)sender{
    if ([self.title  isEqualToString:@"时间银行申请"]) {
        
        [self requestTimeBankRefuseAction];
    }else{
        
        [self requestBusinessCenterRefusedAction];
    }
}

#pragma mark - 请求创业项目申领同意
- (void)requestBusinessCenterAgreeAction{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSString *strUrl = [_inboxProgectModel.inboxProgectMessageExtra stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSString *jsonStr = [strUrl stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    NSString *jsonStr1 = [jsonStr stringByReplacingOccurrencesOfString:@"{" withString:@""];
    
    NSString *jsonStr2 = [jsonStr1 stringByReplacingOccurrencesOfString:@"}" withString:@""];
    
    
    NSArray *arr = [jsonStr2 componentsSeparatedByString:@","];
    
    
    NSString *tb_id = [[[arr objectAtIndex:1] componentsSeparatedByString:@":"] lastObject];
    
    NSString *user_id =  [[[arr objectAtIndex:0] componentsSeparatedByString:@":"] lastObject];
    
    
    
    [dic setObject:tb_id forKey:@"project_id"];
    [dic setObject:user_id forKey:@"user_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterAccepctWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (model.responseCode == ResponseCodeSuccess) {
            
            [CommonUtils showToastWithStr:@"同意申请成功"];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

#pragma mark - 请求创业项目拒绝
- (void)requestBusinessCenterRefusedAction{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSString *strUrl = [_inboxProgectModel.inboxProgectMessageExtra stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSString *jsonStr = [strUrl stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    NSString *jsonStr1 = [jsonStr stringByReplacingOccurrencesOfString:@"{" withString:@""];
    
    NSString *jsonStr2 = [jsonStr1 stringByReplacingOccurrencesOfString:@"}" withString:@""];
    
    
    NSArray *arr = [jsonStr2 componentsSeparatedByString:@","];
    
    
    NSString *tb_id = [[[arr objectAtIndex:1] componentsSeparatedByString:@":"] lastObject];
    
    NSString *user_id =  [[[arr objectAtIndex:0] componentsSeparatedByString:@":"] lastObject];
    
    
    
    [dic setObject:tb_id forKey:@"project_id"];
    [dic setObject:user_id forKey:@"user_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterRefusedWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (model.responseCode == ResponseCodeSuccess) {
            
            [CommonUtils showToastWithStr:@"拒绝申请成功"];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}



#pragma mark - 请求时间银行同意申请
- (void)requestTimeBankAgreeAction{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSString *strUrl = [_timeBankMessageModel.timeBankMessageExtra stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSString *jsonStr = [strUrl stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    NSString *jsonStr1 = [jsonStr stringByReplacingOccurrencesOfString:@"{" withString:@""];
    
    NSString *jsonStr2 = [jsonStr1 stringByReplacingOccurrencesOfString:@"}" withString:@""];
    
    
    NSArray *arr = [jsonStr2 componentsSeparatedByString:@","];
    
    
    NSString *tb_id = [[[arr objectAtIndex:1] componentsSeparatedByString:@":"] lastObject];
    
    NSString *user_id =  [[[arr objectAtIndex:0] componentsSeparatedByString:@":"] lastObject];

    
    
    [dic setObject:tb_id forKey:@"tb_id"];
    [dic setObject:user_id forKey:@"user_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankAccepctWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (model.responseCode == ResponseCodeSuccess) {
            
            [CommonUtils showToastWithStr:@"同意申请成功"];

        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

#pragma mark - 请求时间银行拒绝申请
- (void)requestTimeBankRefuseAction{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSString *strUrl = [_timeBankMessageModel.timeBankMessageExtra stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSString *jsonStr = [strUrl stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    NSString *jsonStr1 = [jsonStr stringByReplacingOccurrencesOfString:@"{" withString:@""];
    
    NSString *jsonStr2 = [jsonStr1 stringByReplacingOccurrencesOfString:@"}" withString:@""];
    
    
    NSArray *arr = [jsonStr2 componentsSeparatedByString:@","];
    
    
    NSString *tb_id = [[[arr objectAtIndex:1] componentsSeparatedByString:@":"] lastObject];
    
    NSString *user_id =  [[[arr objectAtIndex:0] componentsSeparatedByString:@":"] lastObject];
    
    
    
    [dic setObject:tb_id forKey:@"tb_id"];
    [dic setObject:user_id forKey:@"user_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankRefusedWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (model.responseCode == ResponseCodeSuccess) {
            
            [CommonUtils showToastWithStr:@"拒绝申请成功"];

            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}



#pragma mark - 将消息标记为已读
- (void)requestReadMessage:(NSString *)messageID{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [paramsDic setObject:messageID.length > 0?messageID:@"" forKey:@"msg_id"];
    [[HttpClient sharedInstance] setSystemMessageStatusWithParams:paramsDic withSuccessBlock:^(HttpResponseCodeModel *model) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (model.responseCode == ResponseCodeSuccess) {
            
            
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        
        
        
        
    } withFaileBlock:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
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
