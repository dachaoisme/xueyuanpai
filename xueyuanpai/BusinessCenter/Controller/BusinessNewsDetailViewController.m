//
//  BusinessNewsDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/2.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessNewsDetailViewController.h"

#import "BusinessNewsDetailOneStleTableViewCell.h"
#import "BusinessNewsDetailTwoStyleTableViewCell.h"

#import "LoginViewController.h"


#import "BusinessNewsDetailView.h"

@interface BusinessNewsDetailViewController ()
{
    BOOL yesIsCollection;

}

@property(nonatomic,strong)UIBarButtonItem * favoriteButtonItem;

@property(nonatomic,strong)BusinessNewsDetailView *detailView;


@end

@implementation BusinessNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createLeftBackNavBtn];
    
    yesIsCollection = NO;
    
    [self p_setupShareButtonItem];
    
    //检查收藏按钮状态
    [self checkoutIsCollectionOrNot];
    
    
    BusinessNewsDetailView *detailView = [[BusinessNewsDetailView alloc] initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_TOP_HEIGHT)];
    [self.view addSubview:detailView];
    self.detailView = detailView;
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
    self.favoriteButtonItem = favoriteButtonItem;
    
    
}

#pragma mark - 分享按钮
- (void)didClickSharButtonItemAction:(UIBarButtonItem *)buttonItem
{
    //1、创建分享参数
    NSArray* imageArray; //图片
    NSString *title; //标题
    if ([self.title isEqualToString:@"新闻详情"]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.businessCenterNewsImage] placeholderImage:[UIImage imageNamed:@"share.png"]];
        UIImage *image = imageView.image;
        imageArray = [NSArray arrayWithObject:image];
        
        
        title = _newsModel.businessCenterNewsTitle;

        
    } else {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_competationModel.businessCenterCompetitionImage] placeholderImage:[UIImage imageNamed:@"share.png"]];
        UIImage *image = imageView.image;
        imageArray = [NSArray arrayWithObject:image];
        
        title = _competationModel.businessCenterCompetitionTitle;
    }
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:title
                                         images:imageArray
                                            url:[NSURL URLWithString:@"https://www.pgyer.com/hbV2"]
                                          title:title
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
    if ([self.title isEqualToString:@"新闻详情"]) {
        [dic setValue:_newsModel.businessCenterNewsId forKey:@"obj_id"];
    }else{
        [dic setValue:_competationModel.businessCenterCompetitionId forKey:@"obj_id"];
    }
    
    if ([self.title isEqualToString:@"新闻详情"]) {
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfBusinessNews] forKey:@"type"];
    }else{
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfBusinessCompetition] forKey:@"type"];
    }
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
    if ([self.title isEqualToString:@"新闻详情"]) {
        [dic setValue:_newsModel.businessCenterNewsId forKey:@"obj_id"];
    }else{
        [dic setValue:_competationModel.businessCenterCompetitionId forKey:@"obj_id"];
    }
    
    if ([self.title isEqualToString:@"新闻详情"]) {
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfBusinessNews] forKey:@"type"];
    }else{
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfBusinessCompetition] forKey:@"type"];
    }
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
    if ([self.title isEqualToString:@"新闻详情"]) {
        [dic setValue:_newsModel.businessCenterNewsId forKey:@"obj_id"];
    }else{
        [dic setValue:_competationModel.businessCenterCompetitionId forKey:@"obj_id"];
    }
    
    if ([self.title isEqualToString:@"新闻详情"]) {
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfBusinessNews] forKey:@"type"];
    }else{
        [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfBusinessCompetition] forKey:@"type"];
    }

    
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



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.title isEqualToString:@"新闻详情"]) {
        
        if (indexPath.section == 0) {
            
            BusinessNewsDetailOneStleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            cell.titleLabel.text = _newsModel.businessCenterNewsTitle;
            
            cell.authorLabel.text = [NSString stringWithFormat:@"作者 %@",_newsModel.businessCenterNewsAuthor];
            
            cell.timeLabel.text = _newsModel.businessCenterNewsCreateTime;
            
            
            
            return cell;
            
        }else{
            BusinessNewsDetailTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_newsModel.businessCenterNewsContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            
            cell.contentLabel.attributedText = attrStr;
            
            
            
//            cell.contentLabel.text = _newsModel.businessCenterNewsContent;
            
            [cell.detailImageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.businessCenterNewsImage] placeholderImage:[UIImage imageNamed:@"test.jpg"]];
            
            
            
            
            return cell;
            
            
        }

    }else{
        
        if (indexPath.section == 0) {
            
            BusinessNewsDetailOneStleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            cell.titleLabel.text = _competationModel.businessCenterCompetitionTitle;
            
            cell.authorLabel.text = [NSString stringWithFormat:@"作者 %@",_competationModel.businessCenterCompetitionAuthor];
            
            cell.timeLabel.text = _competationModel.businessCenterCompetitionCreateTime;
            

            
            
            return cell;
            
        }else{
            BusinessNewsDetailTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            

            
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[ _competationModel.businessCenterCompetitionContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            
            cell.contentLabel.attributedText = attrStr;
            
//            cell.contentLabel.text = _competationModel.businessCenterCompetitionContent;

            
            [cell.detailImageView sd_setImageWithURL:[NSURL URLWithString:_competationModel.businessCenterCompetitionImage] placeholderImage:[UIImage imageNamed:@"test.jpg"]];
            

            
            return cell;
            
            
        }

    }
    
    
    
    
    
}
 */

#pragma mark - 显示数据
- (void)refreshData{
    
    if ([self.title isEqualToString:@"新闻详情"]) {
        
        [_detailView adjustSubviewsWithContent:_newsModel.businessCenterNewsContent];
        
        
        _detailView.titleLabel.text =  _newsModel.businessCenterNewsTitle;
        _detailView.authorLable.text = [NSString stringWithFormat:@"作者 %@  %@",_newsModel.businessCenterNewsAuthor,_newsModel.businessCenterNewsCreateTime];
        
        
        //显示富文本的内容
        [_detailView.webView loadHTMLString:_newsModel.businessCenterNewsContent baseURL:nil];
        
        
        [_detailView.activityImageView sd_setImageWithURL:[NSURL URLWithString:_newsModel.businessCenterNewsImage] placeholderImage:[UIImage imageNamed:@"test.jpg"]];

    }else{
        [_detailView adjustSubviewsWithContent:_competationModel.businessCenterCompetitionContent];
        
        
        _detailView.titleLabel.text =  _competationModel.businessCenterCompetitionTitle;
        _detailView.authorLable.text = [NSString stringWithFormat:@"作者 %@  %@",_competationModel.businessCenterCompetitionAuthor,_competationModel.businessCenterCompetitionCreateTime];
        
        
        //显示富文本的内容
        [_detailView.webView loadHTMLString:_competationModel.businessCenterCompetitionContent baseURL:nil];
        
        
        [_detailView.activityImageView sd_setImageWithURL:[NSURL URLWithString:_competationModel.businessCenterCompetitionImage] placeholderImage:[UIImage imageNamed:@"test.jpg"]];
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
