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
#define kExchangeButtonHeight 50

@interface GiftDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

///轮播展示商品图片
@property(nonatomic,strong)ParallaxHeaderView * showImageHeaderView;


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
    [self createLeftBackNavBtn];
    
    //创建一个tableView
    [self createTableView];
    
    
    
    //创建导航栏右侧按钮
    [self p_setupShareButtonItem];
    
    //创建立即兑换按钮
    [self createExchangeButton];
    
}

#pragma mark - 创建列表
- (void)createTableView{
    
    //[[UIScreen mainScreen] bounds]
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - kExchangeButtonHeight)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    self.showImageHeaderView = [ParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:@"placeHoder.png"] forSize:CGSizeMake(tableView.frame.size.width, 200)];
    [tableView setTableHeaderView:self.showImageHeaderView];

    
}

#pragma mark - 设置分享按钮
- (void)p_setupShareButtonItem{
    
    //分享按钮
    UIBarButtonItem *shareButtonItem =[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickSharButtonItemAction:)];
    //收藏按钮
    UIBarButtonItem * favoriteButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickFavoriteButtonItemAction:)];
    self.navigationItem.rightBarButtonItems = @[favoriteButtonItem,shareButtonItem];
    
    
}

#pragma mark - 分享按钮
- (void)didClickSharButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [CommonUtils showToastWithStr:@"分享"];
}

#pragma mark - 收藏按钮
- (void)didClickFavoriteButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [CommonUtils showToastWithStr:@"收藏"];
    
}

#pragma mark - 创建立即兑换
- (void)createExchangeButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kExchangeButtonHeight, [UIScreen mainScreen].bounds.size.width, kExchangeButtonHeight);
    btn.backgroundColor = [CommonUtils colorWithHex:@"00BEAF"];
    [btn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(exchangeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
            [cell setWithContentModel:self.mallModel];
            return cell;

        }
            break;
            
        case 1:{
            GiftDetailStyleTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GiftDetailStyleTwoTableViewCell1"];
            if (!cell) {
                cell = [[GiftDetailStyleTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GiftDetailStyleTwoTableViewCell1"];
            }
            
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
            cell.introduceLabel.text = @"兑换方法";

            cell.detailContentLabel.text = self.mallModel.indexMallExchangemethod;

            
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
