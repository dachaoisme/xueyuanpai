//
//  BusinessPublishProjectSuccessViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/21.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessPublishProjectSuccessViewController.h"

#import "BusinessCenterViewController.h"

@interface BusinessPublishProjectSuccessViewController ()

@end

@implementation BusinessPublishProjectSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发布成功";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createLeftBackNavBtn];
    
    
    [self createView];
    
}

- (void)createView{
    
    //创建成功的图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 124)/2, NAV_TOP_HEIGHT + 50, 124, 115)];
    imageView.image = [UIImage imageNamed:@"success_add_score"];
    [self.view addSubview:imageView];
    
    
    //成功积分显示
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.center.x - 25, imageView.center.y - 10, 50, 20)];
    //    moneyLabel.text = [NSString stringWithFormat:@"+%@",_points];
    moneyLabel.textColor = [UIColor colorWithRed:254/255.0 green:189/255.0 blue:47/255.0 alpha:1];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:moneyLabel];
    
    
    
    //提示语
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame) - 25, CGRectGetMaxY(imageView.frame) + 20, CGRectGetWidth(imageView.frame) + 50, 50)];
    alertLabel.numberOfLines = 0;
    alertLabel.font = [UIFont systemFontOfSize:16];
    alertLabel.text = [NSString stringWithFormat:@"创业项目发布成功 恭喜你获得%@积分",_points];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:alertLabel];
    
    
    //提示语2
    UILabel *alertTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(alertLabel.frame) - 25, CGRectGetMaxY(alertLabel.frame) + 10, CGRectGetWidth(alertLabel.frame) + 50, 20)];
    alertTwoLabel.font = [UIFont systemFontOfSize:14];
    alertTwoLabel.textColor = [UIColor lightGrayColor];
    alertTwoLabel.text = @"请保持电话畅通，及时获得通知哦";
    alertTwoLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:alertTwoLabel];
    
    
    //两个按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, CGRectGetMaxY(alertTwoLabel.frame) + 30, (SCREEN_WIDTH - 20*3)/2, 40);
    backButton.layer.cornerRadius = 6;
    backButton.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [backButton setTitle:@"返回创业中心" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(CGRectGetMaxX(backButton.frame) + 20, CGRectGetMaxY(alertTwoLabel.frame) + 30, CGRectGetWidth(backButton.frame), 40);
    shareButton.layer.cornerRadius = 6;
    shareButton.titleLabel.font = [UIFont systemFontOfSize:14];
    shareButton.backgroundColor = [UIColor whiteColor];
    shareButton.layer.borderWidth = 1;
    shareButton.layer.borderColor = [UIColor lightTextColor].CGColor;
    [shareButton setTitle:@"分享给好友" forState:UIControlStateNormal];
    [shareButton setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    
    
    
    if (_points.length == 0) {
        
        
        imageView.image =[UIImage imageNamed:@"success_no_score"];
        moneyLabel.hidden = YES;
        
        alertLabel.text = @"创业项目发布成功";
        
    }else{
        
        imageView.image =[UIImage imageNamed:@"success_add_score"];
        moneyLabel.hidden = NO;
        
        alertLabel.text = [NSString stringWithFormat:@"创业项目发布成功 恭喜你获得%@积分",_points];
    }
}


#pragma mark - 返回按钮的响应方法
- (void)backAction{
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[BusinessCenterViewController class]]) {
            
            BusinessCenterViewController *businessCenterVC = (BusinessCenterViewController *)controller;
            
            [self.navigationController popToViewController:businessCenterVC animated:YES];
            
            
        }
        
    }
    
}

- (void)shareAction{
//    [CommonUtils showToastWithStr:@"分享"];
    
    //1、创建分享参数
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"share.png"]];
    UIImage *image = imageView.image;
    NSArray* imageArray = [NSArray arrayWithObject:image];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"创业项目发布成功"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"https://www.pgyer.com/hbV2"]
                                          title:@"创业项目发布成功"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}

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
