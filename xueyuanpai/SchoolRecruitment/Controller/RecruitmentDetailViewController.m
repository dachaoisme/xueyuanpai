//
//  RecruitmentDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RecruitmentDetailViewController.h"

#import "UniversityAssnHeaderView.h"

#import "SchoolRecruitmentModel.h"

#import "PositionInforViewController.h"
#import "ComponeyInforViewController.h"

#import "LoginViewController.h"
@interface RecruitmentDetailViewController ()<UniversityAssnHeaderViewDelegate>
{
    ///请求数据的model类
    SchoolRecruitmentDetailModel * schoolRecruitmentDetailModel;
    
    ///职位信息
    PositionInforViewController *positionVC;
    ///公司信息
    ComponeyInforViewController *componyVC;
    
    
    BOOL yesIsCollection ;
}
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIBarButtonItem * favoriteButtonItem;


@end

@implementation RecruitmentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"职位详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    yesIsCollection = NO;

    [self requeestData];
    //创建返回按钮
    [self createLeftBackNavBtn];
    
    //创建头的显示样式
    [self createHeadView];
    
    
//    [self p_setupShareButtonItem];
    
    
//    [self checkoutIsCollectionOrNot];
    
}

#pragma mark - 设置分享按钮
- (void)p_setupShareButtonItem{
    
    //分享按钮
    UIBarButtonItem *shareButtonItem =[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickSharButtonItemAction:)];
    //收藏按钮
    UIBarButtonItem * favoriteButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickFavoriteButtonItemAction:)];
    self.navigationItem.rightBarButtonItems = @[favoriteButtonItem,shareButtonItem];
    self.favoriteButtonItem = favoriteButtonItem;
    
    
}
#pragma mark - 分享按钮
- (void)didClickSharButtonItemAction:(UIBarButtonItem *)buttonItem
{
    //1、创建分享参数
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"share.png"]];
    UIImage *image = imageView.image;
    NSArray* imageArray = [NSArray arrayWithObject:image];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@""
                                         images:imageArray
                                            url:[NSURL URLWithString:SHARESDK_URL]
                                          title:@"职位详情"
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

#pragma mark - 收藏按钮
- (void)didClickFavoriteButtonItemAction:(UIBarButtonItem *)buttonItem
{
//    [CommonUtils showToastWithStr:@"收藏"];
    
    if ([UserAccountManager sharedInstance].isLogin==YES) {
        
        if (yesIsCollection==YES) {
            [self cancelCollection];
        }else{
            [self addCollection];
        }
        
    }else{
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }

}

- (void)cancelCollection{
    
}

- (void)addCollection{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.jobId forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfJobMarket] forKey:@"type"];
    [[HttpClient sharedInstance] addCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            NSInteger status = [[model.responseCommonDic objectForKey:@"stat"] integerValue];
            if (status==1) {
                ///已收藏
                [_favoriteButtonItem setImage:[[UIImage imageNamed:@"nav_icon_fav_full"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                yesIsCollection = YES;
            }else{
                ///未收藏
            }
        }
    } withFaileBlock:^(NSError *error) {
        
    }];

    
}

-(void)checkoutIsCollectionOrNot
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.jobId forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfJobMarket] forKey:@"type"];
    [[HttpClient sharedInstance]checkCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            NSInteger status = [[model.responseCommonDic objectForKey:@"stat"] integerValue];
            if (status==1) {
                ///已收藏
                [_favoriteButtonItem setImage:[[UIImage imageNamed:@"nav_icon_fav_full"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                yesIsCollection = YES;
            }else{
                ///未收藏
            }
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}

-(void)requeestData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.jobId forKey:@"id"];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[HttpClient sharedInstance] getSchoolRecruitmentDetailWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        schoolRecruitmentDetailModel = [[SchoolRecruitmentDetailModel alloc]initWithDic:listDic];
        
        //创建各个显示的子视图
        [self createSubView:schoolRecruitmentDetailModel];

        
        
        
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
#pragma mark - 创建头部视图样式
- (void)createHeadView{
    NSArray *arrar = [NSArray arrayWithObjects:@"职位信息",@"公司信息", nil];
    UniversityAssnHeaderView *headerView = [[UniversityAssnHeaderView alloc]initWithFrame:CGRectMake(self.view.center.x - 70, 64, 140, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.type = PiecewiseInterfaceTypeMobileLin;
    headerView.delegate = self;
    headerView.textFont = [UIFont systemFontOfSize:14];
    headerView.textNormalColor = [UIColor blackColor];
    headerView.textSeletedColor = [CommonUtils colorWithHex:@"00BEAF"];
    headerView.linColor = [CommonUtils colorWithHex:@"00BEAF"];
    [headerView loadTitleArray:arrar];
    [self.view addSubview:headerView];
    
    
}
-(void)createSubView:(SchoolRecruitmentDetailModel *)model
{
    //创建显示职位信息和公司信息的controller
    positionVC = [[PositionInforViewController alloc] init];
    
    positionVC.view.hidden = NO;
    positionVC.view.frame = CGRectMake(0, 64+50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114);
    
    positionVC.model = model;
    [self.view addSubview:positionVC.view];
    
    
    componyVC = [[ComponeyInforViewController alloc] init];
    componyVC.view.hidden = YES;
    componyVC.superVC = self;
    componyVC.view.frame = CGRectMake(0, 64+50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114);
    
    componyVC.model = model;
    [self.view addSubview:componyVC.view];
}
#pragma mark - UniversityAssnHeaderViewDelegate代理方法
#pragma mark - 点击每个选项卡响应的方法
- (void)headerViewSelctAction:(UniversityAssnHeaderView *)headerView index:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            //职位信息
            positionVC.view.hidden = NO;
            componyVC.view.hidden = YES;
        }
            break;
        case 1:
        {
            //公司信息
            positionVC.view.hidden = YES;
            componyVC.view.hidden = NO;

            
        }
            break;
        default:
            break;
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
