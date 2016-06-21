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

@interface BusinessNewsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL yesIsCollection;

}

@property(nonatomic,strong)UIBarButtonItem * favoriteButtonItem;


@end

@implementation BusinessNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createLeftBackNavBtn];
    
    yesIsCollection = NO;
    
    [self p_setupShareButtonItem];
    
    
    [self createTableView];
    
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
    [CommonUtils showToastWithStr:@"分享"];
}

#pragma mark - 收藏按钮
- (void)didClickFavoriteButtonItemAction:(UIBarButtonItem *)buttonItem
{
    if (yesIsCollection==YES) {
        [self cancelCollection];
    }else{
        [self addCollection];
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



#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"BusinessNewsDetailOneStleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
    //BusinessNewsDetailTwoStyleTableViewCell.h

    [tableView registerNib:[UINib nibWithNibName:@"BusinessNewsDetailTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
}

#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if ([self.title isEqualToString:@"新闻详情"]) {
//        
//        if (indexPath.section == 1) {
//            
//            return <#expression#>
//        }
//    }else{
//        
//    }
    
    return 100;
}


//自适应撑高
//计算字符串的frame
- (CGFloat)textHeight:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 10, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
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
