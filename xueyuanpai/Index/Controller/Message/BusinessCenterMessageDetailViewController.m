//
//  BusinessCenterMessageDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/7/1.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessCenterMessageDetailViewController.h"

@interface BusinessCenterMessageDetailViewController ()

@end

@implementation BusinessCenterMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"创业项目申领";
    
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
    headImageView.backgroundColor = [UIColor cyanColor];
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 20;
    [backGroundView addSubview:headImageView];
    
    //时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 15, 180, 30)];
    timeLabel.text = @"2016-7-1";
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = [UIColor lightGrayColor];
    [backGroundView addSubview:timeLabel];
    
    
    //内容
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame), CGRectGetMaxY(timeLabel.frame) - 15, SCREEN_WIDTH - CGRectGetMaxX(headImageView.frame) - 20, 30)];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor lightGrayColor];
    contentLabel.text = @"我正在申请你的项目";
    [backGroundView addSubview:contentLabel];
    
    
    //详情解释
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame), CGRectGetMaxY(headImageView.frame)+30,CGRectGetWidth(contentLabel.frame), 50)];
    detailLabel.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [backGroundView addSubview:detailLabel];
    
    
    //同意好友请求button
    UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeButton.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [agreeButton setTitle:@"同意" forState:UIControlStateNormal];
    [agreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    agreeButton.frame = CGRectMake(CGRectGetMinX(detailLabel.frame), CGRectGetMaxY(detailLabel.frame) + 20, (CGRectGetWidth(detailLabel.frame) - 20)/2, 40);
    agreeButton.layer.cornerRadius = 10;
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
