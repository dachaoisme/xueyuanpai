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
@interface ActivityDetailViewController ()

@property (nonatomic,strong)ActivityDetailView *detailView;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"活动详情";
    
    [self createLeftBackNavBtn];
    
    ActivityDetailView *detailView = [[ActivityDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:detailView];
    self.detailView = detailView;
    
    
    [self p_setupShareButtonItem];
    
    
    //刷新数据
    [self refreshData];
    
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
    
   // [HttpClient sharedInstance]
}


#pragma mark - 显示数据
- (void)refreshData{
    
    [_detailView adjustSubviewsWithContent:_model.content];
    
    
    _detailView.titleLabel.text = _model.title;
    _detailView.authorLable.text = [NSString stringWithFormat:@"作者 %@",_model.author];
    
    _detailView.timeLabel.text = _model.createTime;
    _detailView.locationLable.text = _model.place;
    
    
    _detailView.detailLabel.text = _model.content;
    
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
