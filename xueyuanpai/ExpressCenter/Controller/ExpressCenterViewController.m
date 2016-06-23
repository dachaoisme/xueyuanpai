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

#import "RadarView.h"

@interface ExpressCenterViewController ()<CLLocationManagerDelegate>
{
    ExpressCenterPeopleModel * expressCenterPeopleModel;
    
    UIView *backGroundView;
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



@property (nonatomic,strong)NSString *count;

///点的坐标的数组
@property (nonatomic, strong) NSArray *pointsArray;


///动画效果
@property (nonatomic,strong)RadarView *animationRadarView;


@end

@implementation ExpressCenterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self theTabBarHidden:NO];
    
    [self.radarView removeFromSuperview];

    [self createAnimationView];


    [super viewWillAppear:YES];


}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [self.animationRadarView removeFromSuperview];
    
    [self.radarView removeFromSuperview];


    [super viewWillDisappear:YES];

    
}

- (void)createAnimationView{
    //添加动画视图
    RadarView *radarView = [[RadarView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 90, SCREEN_HEIGHT/2 - 90, 160, 160)];
    radarView.backgroundColor = [UIColor clearColor];
    
    backGroundView.center = radarView.center;
    [self.view addSubview:radarView];
    self.animationRadarView = radarView;
    
    
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
        
        self.count = expressPeopleCount;
        
        _showNumberCourier.text = [NSString stringWithFormat:@"本校有%@个快递员正在接单",expressPeopleCount];
        NSLog(@"%@",expressPeopleCount);
    } withFaileBlock:^(NSError *error) {
        
    }];
}

#pragma mark - 创建中间视图
- (void)createCenterView{
    
    //SCREEN_WIDTH - 95*2
    backGroundView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 110, SCREEN_HEIGHT/2 - 110, 220, 220)];
    
    backGroundView.backgroundColor = [UIColor whiteColor];
    backGroundView.layer.cornerRadius = 110;
    backGroundView.layer.masksToBounds = YES;
    [self.view addSubview:backGroundView];
    
    
    //创建wifi图片
    UIImageView *wifiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(110 - 20, 40, 40, 30)];
    wifiImageView.image = [UIImage imageNamed:@"deliver_icon_signal"];
    [backGroundView addSubview:wifiImageView];
    
    //创建显示label
    UILabel *showTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(wifiImageView.frame), 120, 56)];
    showTextLabel.text = @"我要发快递";
    showTextLabel.textAlignment = NSTextAlignmentCenter;
    showTextLabel.numberOfLines = 0;
    showTextLabel.font = [UIFont systemFontOfSize:20];
    [backGroundView addSubview:showTextLabel];
    
    
    
    //本校有多少个快递员正在接单
    UILabel *showNumberCourier = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(showTextLabel.frame), 80, 30)];
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
    
}

#pragma mark - 我要发快递按钮的响应方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_animationRadarView removeFromSuperview];

    
    XHRadarView *radarView = [[XHRadarView alloc] initWithFrame:self.view.bounds];
    radarView.frame = self.view.frame;
    radarView.dataSource = self;
    radarView.delegate = self;
    
    radarView.radius = SCREEN_WIDTH / 2;
    
    radarView.backgroundImage = [UIImage imageNamed:@"radar_background"];
    radarView.labelText = @"正在搜索附近的目标";
    radarView.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [self.view addSubview:radarView];
    _radarView = radarView;
    
    UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x-39, self.view.center.y-39, 78, 78)];
    avatarView.layer.cornerRadius = 39;
    avatarView.layer.masksToBounds = YES;
    
    [avatarView setImage:[UIImage imageNamed:@"avatar"]];
    [_radarView addSubview:avatarView];
    [_radarView bringSubviewToFront:avatarView];
    
    //目标点位置
    _pointsArray = @[
                     @[@6, @90],
                     @[@-140, @108],
                     @[@-83, @98],
                     @[@-25, @142],
                     @[@60, @111],
                     @[@-111, @96],
                     @[@150, @145],
                     @[@25, @144],
                     @[@-55, @110],
                     @[@95, @109],
                     @[@170, @180],
                     @[@125, @112],
                     @[@-150, @145],
                     @[@-7, @160],
                     ];
    
    [self.radarView scan];
    [self startUpdatingRadar];
    
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



#pragma mark - Custom Methods
- (void)startUpdatingRadar {
    
    self.view.userInteractionEnabled = NO;
    
    typeof(self) __weak weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.radarView.labelText = [NSString stringWithFormat:@"搜索已完成，共找到%lu个目标", (unsigned long)[weakSelf.count intValue]];
        
        
        if ([self.count intValue] > 0) {

            
            SendCourierViewController *sendVC = [[SendCourierViewController alloc] init];
            [_radarView removeFromSuperview];
            
            
            [self.navigationController pushViewController:sendVC animated:YES];
            
        }else{
            
            self.view.userInteractionEnabled = YES;
            [weakSelf.animationRadarView removeFromSuperview];

            
            weakSelf.radarView.hidden = YES;
            
            [weakSelf createAnimationView];
            
            
//            [CommonUtils showToastWithStr:@"暂无快递员分配"];
        }

//        [weakSelf.radarView show];
    });
}

#pragma mark - XHRadarViewDataSource
- (NSInteger)numberOfSectionsInRadarView:(XHRadarView *)radarView {
    return 4;
}
- (NSInteger)numberOfPointsInRadarView:(XHRadarView *)radarView {
    return [self.count intValue];
}
//- (UIView *)radarView:(XHRadarView *)radarView viewForIndex:(NSUInteger)index {
//    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 25)];
//    
//    //设置搜索目标图片
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [imageView setImage:[UIImage imageNamed:@"signup_student"]];
//    [pointView addSubview:imageView];
//    return pointView;
//}
//- (CGPoint)radarView:(XHRadarView *)radarView positionForIndex:(NSUInteger)index {
//    NSArray *point = [self.pointsArray objectAtIndex:index];
//    return CGPointMake([point[0] floatValue], [point[1] floatValue]);
//}

#pragma mark - XHRadarViewDelegate

- (void)radarView:(XHRadarView *)radarView didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"didSelectItemAtIndex:%lu", (unsigned long)index);
    
    
     if ([self.count intValue] > 0) {
         
 
         
        SendCourierViewController *sendVC = [[SendCourierViewController alloc] init];
         [_radarView removeFromSuperview];


        [self.navigationController pushViewController:sendVC animated:YES];

    }else{
        
        [CommonUtils showToastWithStr:@"暂无快递员分配"];
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
