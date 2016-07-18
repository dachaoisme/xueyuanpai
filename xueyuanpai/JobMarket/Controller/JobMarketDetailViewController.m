//
//  JobMarketDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/31.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "JobMarketDetailViewController.h"
#import "SchoolShufflingView.h"
#import "JobMarketDetailOneStyleTableViewCell.h"
#import "JobMarkDetailTwoStyleTableViewCell.h"

#import "UILabel+VerticalAlign.h"
#import "LoginViewController.h"
#import "MyHomePageByPhoneNumberViewController.h"


@interface JobMarketDetailViewController ()<UITableViewDataSource,UITableViewDelegate,SchoolShufflingViewDelegate,JobMarkDetailTwoStyleTableViewCellDelegate>
{
    JobMarketDetailModel * jobMarketDetailModel;
    BOOL yesIsCollection ;
    
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIBarButtonItem * favoriteButtonItem;

///存储图片的数组
@property (nonatomic,strong)NSMutableArray *imageArray;

@property (nonatomic,strong)SchoolShufflingView *myHeaderView;


@property (nonatomic,strong)NSAttributedString * attrStr;


@end

@implementation JobMarketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageArray = [NSMutableArray array];
    
    self.title = @"跳蚤市场详情";
    yesIsCollection = NO;
    //返回
    [self createLeftBackNavBtn];
    
    //设置分享收藏按钮
    [self p_setupShareButtonItem];
    
    //设置tableView
    [self createTableView];

    [self requestToGetJobMarketDetail];
    
    [self checkoutIsCollectionOrNot];
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
                                            url:[NSURL URLWithString:SHARESDK_URL]
                                          title:@"跳蚤市场详情"
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
    [dic setValue:self.jobMarketId forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfJobMarket] forKey:@"type"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance] addCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (model.responseCode == ResponseCodeSuccess) {
            ///已收藏
            [_favoriteButtonItem setImage:[[UIImage imageNamed:@"nav_icon_fav_full"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            yesIsCollection = YES;
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
-(void)cancelCollection
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.jobMarketId forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfJobMarket] forKey:@"type"];
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
    [dic setValue:self.jobMarketId forKey:@"obj_id"];
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

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //创建headerView
    //初始化轮播图[复用校园招聘轮播视图的封装]
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 150)];
    
    self.myHeaderView =  [[SchoolShufflingView alloc] initWithFrame:backGroundView.bounds];
    _myHeaderView.delegate = self;

    
    [backGroundView addSubview:_myHeaderView];
    
    self.tableView.tableHeaderView = backGroundView;
    
    
    
    //注册第一个区里的cell
    [tableView registerClass:[JobMarketDetailOneStyleTableViewCell class] forCellReuseIdentifier:@"oneCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"JobMarkDetailTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            if (indexPath.row == 0) {
                JobMarketDetailOneStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if (jobMarketDetailModel) {
                    [cell bindModel:jobMarketDetailModel];

                }
                
                return cell;
 
            }else{
                JobMarkDetailTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                
                cell.delegate = self;
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                if (jobMarketDetailModel) {
                    [cell bindModel:jobMarketDetailModel];
                    
                }

                
                return cell;
            }
            
        }
            break;
            
        case 1:{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            
            if (indexPath.row == 0) {
        
                cell.textLabel.text = @"宝贝描述";
                cell.textLabel.textColor = [CommonUtils colorWithHex:@"999999"];
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                
                return cell;
                
            }else{
                

                cell.textLabel.textColor = [CommonUtils colorWithHex:@"333333"];
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                
                
                self.attrStr = [[NSAttributedString alloc] initWithData:[jobMarketDetailModel.jobMarketDetailDescription dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                

                cell.textLabel.attributedText = _attrStr;
                cell.textLabel.numberOfLines = 0;

               
                return cell;
            }
        }
            
            break;
            
        default:{
            UITableViewCell *cell = nil;
            
            return cell;
        }
            break;
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 70;
            break;
            
        case 1:{
            
            if (indexPath.row == 0) {
                return 45;
            }else{
                
                //计算文本高度
                return  [self textHeight:[self.attrStr string]];
            }
        }
            
            break;
            
        default:
            return 30;

            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
//    if (indexPath.section == 0) {
//        
//        if (indexPath.row == 1) {
//            
//            //跳转打电话界面
//            
//            [CommonUtils callServiceWithTelephoneNum:jobMarketDetailModel.jobMarketDetailMobile];
//            
//        }
//    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 10;
    
    
}

#pragma mark - 打电话活动
- (void)callAction{
    
     [CommonUtils callServiceWithTelephoneNum:jobMarketDetailModel.jobMarketDetailMobile];
}

#pragma mark - 添加头像的点击事件
- (void)clickHeadImageViewAction:(id)sender{
    
    MyHomePageByPhoneNumberViewController *homePageVC = [[MyHomePageByPhoneNumberViewController alloc] init];
    
    homePageVC.telePhoneNumber = jobMarketDetailModel.jobMarketDetailMobile;
    
    [self.navigationController pushViewController:homePageVC animated:YES];
}

#pragma mark - 点击banner图
-(void)selectedImageIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld张图片",(long)index+1);
}

#pragma mark - 请求跳蚤市场详情数据
-(void)requestToGetJobMarketDetail
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.jobMarketId?self.jobMarketId:@"" forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]jobMarketDetailWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSDictionary * dataDic = model.responseCommonDic ;
            jobMarketDetailModel = [[JobMarketDetailModel alloc]initWithDic:dataDic];
            
            [_imageArray addObjectsFromArray:jobMarketDetailModel.jobMarketDetailImageArr];
            
            
            if (_imageArray.count > 0) {
                _myHeaderView.imageArray = _imageArray;
        
            }
            
            [self.tableView reloadData];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}



//自适应撑高
//计算字符串的frame
- (CGFloat)textHeight:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    //返回计算好的高度
    return rect.size.height;
    
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
