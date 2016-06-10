//
//  ExpressCenterViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ExpressCenterViewController.h"

#import "SendCourierViewController.h"

@interface ExpressCenterViewController ()

{
    CALayer *_layer;
    CAAnimationGroup *_animaTionGroup;
    CADisplayLink *_disPlayLink;
    
    ExpressCenterPeopleModel * expressCenterPeopleModel;
}



@end

@implementation ExpressCenterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self theTabBarHidden:NO];
    
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(delayAnimation)];
    _disPlayLink.frameInterval = 40;
    [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view.layer removeAllAnimations];
    [_disPlayLink invalidate];
    _disPlayLink = nil;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的快递"];
    
    

    
    self.view.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    
    
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(delayAnimation)];
    _disPlayLink.frameInterval = 40;
    [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

    
    
    [self createCenterView];
    [self requestExpressPeopleCount];
    
}
///获取正在接单的快递员
-(void)requestExpressPeopleCount
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance]expressCenterGetExpressPeopleWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSString * expressPeopleCount = [model.responseCommonDic objectForKey:@"count"];
        NSLog(@"%@",expressPeopleCount);
    } withFaileBlock:^(NSError *error) {
        
    }];
}
///分配de快递员接口
-(void)requestDistributeExpressPeople
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance]expressCenterDistributeExpressPeopleWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSString * expressPeopleCount = [model.responseCommonDic objectForKey:@"count"];
        NSLog(@"%@",expressPeopleCount);
        ///快递员信息
        expressCenterPeopleModel = [[ExpressCenterPeopleModel alloc]initWithDic:model.responseCommonDic];
    } withFaileBlock:^(NSError *error) {
        
    }];
}
///发送快递
-(void)sendExpress
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:expressCenterPeopleModel.ExpressCenterPeopleId forKey:@"courier_id"];
    ///取件地址
    [dic setValue:@"地址" forKey:@"address"];
    ///取件时间
    [dic setValue:@"取件时间" forKey:@"fetchtime"];
    ///联系电话
    [dic setValue:@"联系电话" forKey:@"telphone"];
    
    [[HttpClient sharedInstance]expressCenterSendExpressWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///发件成功
            [CommonUtils showToastWithStr:@"发件成功"];
        }else
        {
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [CommonUtils showToastWithStr:@"发件失败"];
    }];
}
///取消发送快递
-(void)requestCancelSendExpress
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    ///发快递序号
    [dic setValue:expressCenterPeopleModel.ExpressCenterPeopleId forKey:@"id"];
    [[HttpClient sharedInstance]expressCenterCancelExpressWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            ///发件成功
            [CommonUtils showToastWithStr:@"取消发件成功"];
        }else
        {
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [CommonUtils showToastWithStr:@"取消发件成功"];
    }];
}
///发送快递记录
-(void)requestExpressHistory
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    ///发快递序号
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:@"2" forKey:@"page"];
    [dic setValue:@"10" forKey:@"size"];
    [[HttpClient sharedInstance]expressCenterExpressListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                ExpressCenterExpressInfoModel * model = [[ExpressCenterExpressInfoModel alloc]initWithDic:smallDic];
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
    
}
#pragma mark - 创建中间视图
- (void)createCenterView{
    
    //SCREEN_WIDTH - 95*2
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 90, SCREEN_HEIGHT/2 - 90, 180, 180)];
    
    backGroundView.backgroundColor = [UIColor whiteColor];
    backGroundView.layer.cornerRadius = 89;
    backGroundView.layer.masksToBounds = YES;
    [self.view addSubview:backGroundView];
    
    
    //创建wifi图片
    UIImageView *wifiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90 - 20, 15, 40, 30)];
    wifiImageView.image = [UIImage imageNamed:@"deliver_icon_signal"];
    [backGroundView addSubview:wifiImageView];
    
    //创建显示label
    UILabel *showTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(wifiImageView.frame), 120, 56)];
    showTextLabel.text = @"正在为您分配快递";
    showTextLabel.textAlignment = NSTextAlignmentCenter;
    showTextLabel.numberOfLines = 0;
    showTextLabel.font = [UIFont systemFontOfSize:20];
    [backGroundView addSubview:showTextLabel];
    
    
    
    UIButton *noticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    noticeButton.frame = CGRectMake(15, SCREEN_HEIGHT - 109, 135, 40);
    noticeButton.backgroundColor = [UIColor whiteColor];
    [noticeButton setImage:[UIImage imageNamed:@"deliver_icon_noti"] forState:UIControlStateNormal];
    noticeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [noticeButton setTitle:@"快递通知" forState:UIControlStateNormal];
    [noticeButton setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    noticeButton.layer.cornerRadius = 3;
    noticeButton.layer.masksToBounds = YES;
    [self.view addSubview:noticeButton];
    
    
    UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    recordButton.frame = CGRectMake(SCREEN_WIDTH - 15 - 135, SCREEN_HEIGHT - 109, 135, 40);
    recordButton.backgroundColor = [UIColor whiteColor];
    [recordButton setImage:[UIImage imageNamed:@"deliver_icon_order"] forState:UIControlStateNormal];
    recordButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [recordButton setTitle:@"发快递记录" forState:UIControlStateNormal];
    [recordButton setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(sendRecordAction) forControlEvents:UIControlEventTouchUpInside];
    recordButton.layer.cornerRadius = 3;
    recordButton.layer.masksToBounds = YES;
    [self.view addSubview:recordButton];
    

    
}


#pragma mark - 发快递按钮的响应方法
- (void)sendRecordAction{
    
    SendCourierViewController *sendVC = [[SendCourierViewController alloc] init];
    
    [self.navigationController pushViewController:sendVC animated:YES];
}

#pragma mark - 动画效果
- (void)delayAnimation
{
    [self startAnimation];
}

- (void)startAnimation
{
    CALayer *layer = [[CALayer alloc] init];
    layer.cornerRadius = [UIScreen mainScreen].bounds.size.width/2;
    layer.frame = CGRectMake(0, 0, layer.cornerRadius * 2, layer.cornerRadius * 2);
    layer.position = self.view.layer.position;
    UIColor *color = [UIColor whiteColor];
    layer.backgroundColor = color.CGColor;
    [self.view.layer addSublayer:layer];
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    _animaTionGroup = [CAAnimationGroup animation];
    _animaTionGroup.delegate = self;
    _animaTionGroup.duration = 2;
    _animaTionGroup.removedOnCompletion = YES;
    _animaTionGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.0;
    scaleAnimation.toValue = @1.0;
    scaleAnimation.duration = 2;
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration = 2;
    opencityAnimation.values = @[@0.8,@0.4,@0];
    opencityAnimation.keyTimes = @[@0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    
    NSArray *animations = @[scaleAnimation,opencityAnimation];
    _animaTionGroup.animations = animations;
    [layer addAnimation:_animaTionGroup forKey:nil];
    
    [self performSelector:@selector(removeLayer:) withObject:layer afterDelay:1.5];
}

- (void)removeLayer:(CALayer *)layer
{
    [layer removeFromSuperlayer];
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
