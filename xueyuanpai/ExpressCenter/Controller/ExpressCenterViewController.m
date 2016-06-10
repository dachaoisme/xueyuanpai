//
//  ExpressCenterViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ExpressCenterViewController.h"

#import "SendCourierViewController.h"

#import "SendCourierReecordViewController.h"

#import "CourierNoticeViewController.h"


#import <CoreLocation/CoreLocation.h>
@interface ExpressCenterViewController ()<CLLocationManagerDelegate>
{
    CALayer *_layer;
    CAAnimationGroup *_animaTionGroup;
    CADisplayLink *_disPlayLink;
    
    ExpressCenterPeopleModel * expressCenterPeopleModel;

    
}

///显示接单数量的控件视图
@property (nonatomic,strong)UILabel *showNumberCourier;


///定位管理器
@property (nonatomic,strong)CLLocationManager *manager;

///编码反编码的类
@property (nonatomic,strong)CLGeocoder *geocoder;


///位置信息
@property (nonatomic,strong)NSString *locationStr;


@property (nonatomic,strong) UILabel *showLocationLable;




@end

@implementation ExpressCenterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self theTabBarHidden:NO];
    
    [self.view.layer removeAllAnimations];
    [_disPlayLink invalidate];
    _disPlayLink = nil;

    
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
    
    [self createCenterView];
    
    [self requestExpressPeopleCount];

    
    
    //开始定位
    [self startGetPosition];
    
    
    //定位信息的显示  deliver_icon_location
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, NAV_TOP_HEIGHT + 10, 8, 12)];
    imageView.image = [UIImage imageNamed:@"deliver_icon_location"];
    [self.view addSubview:imageView];
    
    
    UILabel *showLocationLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, NAV_TOP_HEIGHT + 5, SCREEN_WIDTH - CGRectGetMaxX(imageView.frame) - 15, 20)];
    
    showLocationLable.text = @"北京";
    showLocationLable.font = [UIFont systemFontOfSize:14];
    showLocationLable.textColor = [UIColor whiteColor];
    [self.view addSubview:showLocationLable];

    self.showLocationLable = showLocationLable;


    
    
}

#pragma mark - 开始定位
- (void)startGetPosition{
    
    //第一步：初始化定位管理器
    self.manager = [[CLLocationManager alloc] init];
    
    
    //第二步：进行隐私的判断并授权
    
    
    //进行隐私的判断
    if (![CLLocationManager locationServicesEnabled]) {
        
        NSLog(@"是否前往隐私进行设置允许定位");
        
        
    }
    
    //根据状态进行授权
    
    //进行版本的判断
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 8.0) {
        
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
            
            //请求授权
            [self.manager requestWhenInUseAuthorization];
            
        }
        
    }
    
    //第三步：设置管理器的代理和相关属性
    self.manager.delegate = self;
    
    //设置精度
    self.manager.desiredAccuracy = 100;
    
    //设置最小更新距离
    self.manager.distanceFilter = 100;
    
    //第四步：开启定位
    [self.manager startUpdatingLocation];
    
    
    

}

#pragma mark - CLLocationManagerDelegate的代理方法
//这个代理方法是定位成功之后开始更新位置信息，只要移动设置的最小距离之后也开始走这个方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //获取最后一次的位置
    CLLocation *location = locations.lastObject;
    //获取位置坐标
    CLLocationCoordinate2D coordinate= location.coordinate;
    
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航海方向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    
    
    
    //初始化对象
    self.geocoder = [[CLGeocoder alloc] init];
    
    
    //根据经纬度反编码取出地名
    [self getAdressByLongitude:coordinate.longitude Latitude:coordinate.latitude];
}

#pragma mark - 根据经纬度获取地址
- (void)getAdressByLongitude:(CLLocationDegrees)longitude Latitude:(CLLocationDegrees)latitude{
    
    
    //反编码
    //创建CLLocation
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        
        //显示最前面的地标信息
        CLPlacemark *firstPlacemark=[placemarks firstObject];
        self.showLocationLable.text=firstPlacemark.name;
        
        
        
    }];
    
}


//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"定位失败了");
}


///获取正在接单的快递员数量
-(void)requestExpressPeopleCount
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    
    [[HttpClient sharedInstance]expressCenterGetExpressPeopleWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSString * expressPeopleCount = [model.responseCommonDic objectForKey:@"count"];
        
        _showNumberCourier.text = [NSString stringWithFormat:@"本校有%@个快递员正在接单",expressPeopleCount];
        NSLog(@"%@",expressPeopleCount);
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
    showTextLabel.text = @"我要发快递";
    showTextLabel.textAlignment = NSTextAlignmentCenter;
    showTextLabel.numberOfLines = 0;
    showTextLabel.font = [UIFont systemFontOfSize:20];
    [backGroundView addSubview:showTextLabel];
    
    
    //本校有多少个快递员正在接单
    UILabel *showNumberCourier = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(showTextLabel.frame), 80, 30)];
    showNumberCourier.textAlignment = NSTextAlignmentCenter;
    showNumberCourier.numberOfLines = 0;
    showNumberCourier.textColor = [CommonUtils  colorWithHex:@"5f746c"];
    showNumberCourier.font = [UIFont systemFontOfSize:10];
    [backGroundView addSubview:showNumberCourier];
    self.showNumberCourier = showNumberCourier;
    
    
    UIButton *noticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    noticeButton.frame = CGRectMake(15, SCREEN_HEIGHT - 109, 135, 40);
    noticeButton.backgroundColor = [UIColor whiteColor];
    [noticeButton setImage:[UIImage imageNamed:@"deliver_icon_noti"] forState:UIControlStateNormal];
    noticeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [noticeButton setTitle:@"快递通知" forState:UIControlStateNormal];
    [noticeButton setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    [noticeButton addTarget:self action:@selector(noticeButtonAction) forControlEvents:UIControlEventTouchUpInside];
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
    
    _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(delayAnimation)];
    _disPlayLink.frameInterval = 40;
    [_disPlayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    

    
}

#pragma mark - 我要发快递按钮的响应方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    SendCourierViewController *sendVC = [[SendCourierViewController alloc] init];
    
    [self.navigationController pushViewController:sendVC animated:YES];

    
}


#pragma mark - 发快递记录按钮的响应方法
- (void)sendRecordAction{
    
    
    SendCourierReecordViewController *recordVC = [[SendCourierReecordViewController alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
}


#pragma mark - 快递通知按钮响应方法
- (void)noticeButtonAction{
    
    CourierNoticeViewController *courierNoticeVC = [[CourierNoticeViewController alloc] init];
    
    [self.navigationController pushViewController:courierNoticeVC animated:YES];
    
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
