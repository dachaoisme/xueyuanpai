//
//  ActivityDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/23.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ActivityDetailViewController.h"

#import "ActivityDetailView.h"
#import "HotActivityModel.h"

#import "LoginViewController.h"
@interface ActivityDetailViewController ()
{
    ///是否收藏
    BOOL yesIsCollection;

}

@property (nonatomic,strong)ActivityDetailView *detailView;


@property (nonatomic,strong)UIBarButtonItem * favoriteButtonItem;



@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"活动详情";
    
    [self createLeftBackNavBtn];
    yesIsCollection = NO;

    
    ActivityDetailView *detailView = [[ActivityDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:detailView];
    self.detailView = detailView;
    
    
    [self p_setupShareButtonItem];
    
    
    //刷新数据
    [self refreshData];
    
    [self checkoutIsCollectionOrNot];

    
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
    [imageView sd_setImageWithURL:[NSURL URLWithString:_model.logoUrl] placeholderImage:[UIImage imageNamed:@"share.png"]];
    UIImage *image = imageView.image;
    NSArray* imageArray = [NSArray arrayWithObject:image];

    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:_model.title
                                         images:imageArray
                                            url:[NSURL URLWithString:SHARESDK_URL]
                                          title:_model.title
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
    
    if ([UserAccountManager sharedInstance].isLogin==YES) {
        
        //活动详情收藏按钮接口
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
-(void)addCollection
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.model.hotActivityID forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfUniversityAssnActivity] forKey:@"type"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance] addCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (model.responseCode == ResponseCodeSuccess) {
            [_favoriteButtonItem setImage:[[UIImage imageNamed:@"nav_icon_fav_full"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            yesIsCollection = YES;
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
-(void)cancelCollection
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.model.hotActivityID forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfUniversityAssnActivity] forKey:@"type"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance] cancelCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (model.responseCode == ResponseCodeSuccess) {
            [_favoriteButtonItem setImage:[[UIImage imageNamed:@"nav_icon_fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            yesIsCollection = NO;
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
-(void)checkoutIsCollectionOrNot
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.model.hotActivityID forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfUniversityAssnActivity] forKey:@"type"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance]checkCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if (model.responseCode == ResponseCodeSuccess) {
            NSInteger status = [[model.responseCommonDic objectForKey:@"stat"] integerValue];
            if (status==1) {
                ///已收藏
                [_favoriteButtonItem setImage:[[UIImage imageNamed:@"nav_icon_fav_full"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                yesIsCollection = YES;
            }else{
                ///未收藏
                [_favoriteButtonItem setImage:[[UIImage imageNamed:@"nav_icon_fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                yesIsCollection = NO;

                
            }
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}



#pragma mark - 显示数据
- (void)refreshData{
    
    [_detailView adjustSubviewsWithContent:_model.content];
    
    
    [_detailView.activityImageView sd_setImageWithURL:[NSURL URLWithString:_model.logoUrl] placeholderImage:[UIImage imageNamed:@"placeHoder.png"]];
    _detailView.titleLabel.text = _model.title;
    _detailView.authorLable.text = [NSString stringWithFormat:@"作者 %@  %@",_model.author,_model.createTime];
    
    _detailView.timeLabel.text = _model.createTime;
    _detailView.locationLable.text = _model.place;
    
    
    //显示富文本的内容
    [_detailView.webView loadHTMLString:_model.content baseURL:nil];
    
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
