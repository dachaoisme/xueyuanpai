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

@interface JobMarketDetailViewController ()<UITableViewDataSource,UITableViewDelegate,SchoolShufflingViewDelegate,JobMarkDetailTwoStyleTableViewCellDelegate>
{
    JobMarketDetailModel * jobMarketDetailModel;
    BOOL yesIsCollection ;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIBarButtonItem * favoriteButtonItem;

///存储图片的数组
@property (nonatomic,strong)NSMutableArray *imageArray;

///计算cell的高度
@property (nonatomic,assign)CGFloat height;

@end

@implementation JobMarketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageArray = [NSMutableArray array];
    
    self.title = @"跳槽市场详情";
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
    [CommonUtils showToastWithStr:@"分享"];
}

#pragma mark - 收藏按钮
- (void)didClickFavoriteButtonItemAction:(UIBarButtonItem *)buttonItem
{
    if (yesIsCollection==YES) {
        return;
    }
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.jobMarketId forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfJobMarket] forKey:@"type"];
    [[HttpClient sharedInstance] addCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            NSInteger status = [[model.responseCommonDic objectForKey:@"stat"] integerValue];
            if (status==1) {
                ///已收藏
                [_favoriteButtonItem setImage:[UIImage imageNamed:@"nav_icon_fav_full"]];
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
    [dic setValue:self.jobMarketId forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfJobMarket] forKey:@"type"];
    [[HttpClient sharedInstance]checkCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            NSInteger status = [[model.responseCommonDic objectForKey:@"stat"] integerValue];
            if (status==1) {
                ///已收藏
                [_favoriteButtonItem setImage:[UIImage imageNamed:@"nav_icon_fav_full"]];
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
    
    
    //注册第一个区里的cell
    [tableView registerClass:[JobMarketDetailOneStyleTableViewCell class] forCellReuseIdentifier:@"oneCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"JobMarkDetailTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    switch (section) {
        case 0:
            return 3;
            break;
            
        default:
            return 2;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            if (indexPath.row == 1) {
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
                
//               CGSize textSize =  [CommonUtils getTextSizeWithText:jobMarketDetailModel.jobMarketDetailDescription WithFont:14 WithTextWidth:SCREEN_WIDTH];
//                _height = textSize.height;
                
                cell.textLabel.text = jobMarketDetailModel.jobMarketDetailDescription;
                cell.textLabel.numberOfLines = 0;
                
                CGRect frame = CGRectMake(15, 5, SCREEN_WIDTH, _height);
                
                cell.textLabel.frame = frame;
                
                cell.textLabel.textColor = [CommonUtils colorWithHex:@"333333"];
                cell.textLabel.font = [UIFont systemFontOfSize:14];
               
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
                
                CGSize textSize =  [CommonUtils getTextSizeWithText:jobMarketDetailModel.jobMarketDetailDescription WithFont:16 WithTextWidth:SCREEN_WIDTH-36];
                _height = textSize.height;
                return _height;
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

    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 2) {
            
            //跳转打电话界面
            
            [CommonUtils callServiceWithTelephoneNum:jobMarketDetailModel.jobMarketDetailMobile];
            
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        //初始化轮播图[复用校园招聘轮播视图的封装]
        SchoolShufflingView *schoolShufflingView = [[SchoolShufflingView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100)];
        
        schoolShufflingView.delegate = self;
        
//        //仅用来测试布局用的
//        NSString *path1 = @"http://imgk.zol.com.cn/samsung/4600/a4599073_s.jpg";
//        NSString *path2 = @"http://www.qqpk.cn/Article/UploadFiles/201111/2011112212072571.jpg";
//        NSArray *pathArray = [NSArray arrayWithObjects:path1,path2, nil];
        
        
        if (_imageArray.count > 0) {
            schoolShufflingView.imageArray = _imageArray;

        }
        return schoolShufflingView;

    }else{
        
        UIView *view = nil;
        
        return view;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 75;
    }else{
        
        return 10;
    }
    
    
}

#pragma mark - 打电话活动
- (void)callAction{
    
     [CommonUtils callServiceWithTelephoneNum:jobMarketDetailModel.jobMarketDetailMobile];
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
            
            [self.tableView reloadData];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
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
