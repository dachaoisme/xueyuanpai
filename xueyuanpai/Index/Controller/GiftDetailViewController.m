//
//  GiftDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/23.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "GiftDetailViewController.h"

#import "ParallaxHeaderView.h"
#import "GiftDetailStyleOneTableViewCell.h"
#import "GiftDetailStyleTwoTableViewCell.h"
#import "GiftExchangeViewController.h"

#import "LoginViewController.h"
#define kExchangeButtonHeight 50

@interface GiftDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL yesIsCollection;
}
///轮播展示商品图片
@property(nonatomic,strong)ParallaxHeaderView * showImageHeaderView;
@property(nonatomic,strong)UIBarButtonItem * favoriteButtonItem;

@end

@implementation GiftDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self theTabBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"礼品详情";
    yesIsCollection = NO;
    [self createLeftBackNavBtn];
    
    //创建一个tableView
    [self createTableView];
    
    
    
    //创建导航栏右侧按钮
    [self p_setupShareButtonItem];
    
    //创建立即兑换按钮
    [self createExchangeButton];
    
    [self checkoutIsCollectionOrNot];
}

#pragma mark - 创建列表
- (void)createTableView{
    
    //[[UIScreen mainScreen] bounds]
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - kExchangeButtonHeight)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.mallModel.indexMallThumbUrl] placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    
    self.showImageHeaderView = [ParallaxHeaderView parallaxHeaderViewWithImage:imageView.image forSize:CGSizeMake(tableView.frame.size.width, 200)];
    
    
    [tableView setTableHeaderView:self.showImageHeaderView];

    
}

#pragma mark - 设置分享按钮
- (void)p_setupShareButtonItem{
    
    //分享按钮
    UIBarButtonItem *shareButtonItem =[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickSharButtonItemAction:)];
    //收藏按钮
    _favoriteButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickFavoriteButtonItemAction:)];
    self.navigationItem.rightBarButtonItems = @[_favoriteButtonItem,shareButtonItem];
    
    
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
                                            url:[NSURL URLWithString:@"https://www.pgyer.com/hbV2"]
                                          title:@"礼品详情"
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
    if (self.mallModel) {
        [dic setValue:self.mallModel.indexMallId forKey:@"obj_id"];
    }else{
        [dic setValue:self.giftDetailId forKey:@"obj_id"];
    }
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfGiftExchange] forKey:@"type"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance] addCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (model.responseCode == ResponseCodeSuccess) {
            ///已收藏
            [_favoriteButtonItem setImage:[[UIImage imageNamed:@"nav_icon_fav_full"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            yesIsCollection = YES;
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
-(void)cancelCollection
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    if (self.mallModel) {
        [dic setValue:self.mallModel.indexMallId forKey:@"obj_id"];
    }else{
        [dic setValue:self.giftDetailId forKey:@"obj_id"];
    }
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfGiftExchange] forKey:@"type"];
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
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}


-(void)checkoutIsCollectionOrNot
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    if (self.mallModel) {
        [dic setValue:self.mallModel.indexMallId forKey:@"obj_id"];
    }else{
        [dic setValue:self.giftDetailId forKey:@"obj_id"];
    }
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfGiftExchange] forKey:@"type"];
    
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
            }
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
#pragma mark - 创建立即兑换
- (void)createExchangeButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kExchangeButtonHeight, [UIScreen mainScreen].bounds.size.width, kExchangeButtonHeight);
    btn.backgroundColor = [CommonUtils colorWithHex:@"00BEAF"];
    [btn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(exchangeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:btn];
}

#pragma mark - 立即兑换按钮的响应方法
- (void)exchangeButtonAction:(UIButton *)sender{
    
    NSLog(@"立即兑换");
    GiftExchangeViewController * giftExchangeVC = [[GiftExchangeViewController alloc]init];
    giftExchangeVC.mallModel = self.mallModel;
    [self.navigationController pushViewController:giftExchangeVC animated:YES];
    
}

#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            GiftDetailStyleOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GiftDetailStyleOneTableViewCell0"];
            if (!cell) {
                cell = [[GiftDetailStyleOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GiftDetailStyleOneTableViewCell0"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            [cell setWithContentModel:self.mallModel];
            return cell;

        }
            break;
            
        case 1:{
            GiftDetailStyleTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GiftDetailStyleTwoTableViewCell1"];

            if (!cell) {
                cell = [[GiftDetailStyleTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GiftDetailStyleTwoTableViewCell1"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.introduceLabel.text = @"适用学校";
            cell.detailContentLabel.text = self.mallModel.indexMallCollegeName ;
            return cell;
            
        }
            break;
        case 2:{
            GiftDetailStyleTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GiftDetailStyleTwoTableViewCell2"];

            if (!cell) {
                cell = [[GiftDetailStyleTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GiftDetailStyleTwoTableViewCell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.introduceLabel.text = @"礼品描述";

            cell.detailContentLabel.text = self.mallModel.indexMallDescription;

            return cell;
            
        }
            break;
        case 3:{
            GiftDetailStyleTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GiftDetailStyleTwoTableViewCell3"];

            if (!cell) {
                cell = [[GiftDetailStyleTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GiftDetailStyleTwoTableViewCell3"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.introduceLabel.text = @"兑换方法";
            
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.mallModel.indexMallExchangemethod dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            
            cell.detailContentLabel.attributedText = attrStr;

//            cell.detailContentLabel.text = self.mallModel.indexMallExchangemethod;

            
            return cell;
        }
            break;


            
        default:{
            UITableViewCell *cell = nil;
            
            return cell;
        }
            break;
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
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
