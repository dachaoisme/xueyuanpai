//
//  BusinessProjectDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessProjectDetailViewController.h"


#import "BusinessProjectDetailOneTableViewCell.h"
#import "BusinessProjectDetailTwoTableViewCell.h"
#import "BusinessProjectDetailThreeTableViewCell.h"
#import "BusinessProjectDetailFourTableViewCell.h"

@interface BusinessProjectDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BusinessCenterProgectDetailModel * businessCenterProgectDetailModel;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation BusinessProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"项目详情";
    
    [self createLeftBackNavBtn];
    
    [self theTabBarHidden:YES];
    
    
    [self p_setupShareButtonItem];
    
    
    [self createTableView];
    
    [self requestToGetBusinessProjectDetail];
    
    
    
#warning 判定是否有导师逻辑暂未处理，个人中心逻辑页面搭建完毕之后继续
    
    
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

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"BusinessProjectDetailOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessProjectDetailTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessProjectDetailThreeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"threeCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessProjectDetailFourTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"fourCell"];

}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 1;
    }else{
        return 2;

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 0:{
            
            
            if (indexPath.row == 0) {
                
                BusinessProjectDetailOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                
                cell.titleLabel.text = businessCenterProgectDetailModel.businessCenterProgectDetailTitle;
                
                cell.dateLabel.text = businessCenterProgectDetailModel.businessCenterProgectDetailDate;
                
            
                return cell;

                
            }else{
                
                BusinessProjectDetailTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                
                //头像
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[CommonUtils getEffectiveUrlWithUrl:businessCenterProgectDetailModel.businessCenterProgectDetailUserModel.businessCenterProgectDetailUserIcon withType:1]] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
                
                //姓名
                cell.nameLabel.text = businessCenterProgectDetailModel.businessCenterProgectDetailUserModel.businessCenterProgectDetailUserRealName;
                
                //性别
                if ([businessCenterProgectDetailModel.businessCenterProgectDetailUserModel.businessCenterProgectDetailUserSex intValue]== SexOfManType) {
                    ///男
                    [cell.genderImageView setImage:[UIImage imageNamed:@"gender_male"]];
                }else if ([businessCenterProgectDetailModel.businessCenterProgectDetailUserModel.businessCenterProgectDetailUserSex intValue]==SexOfWomanType){
                    ///女
                    [cell.genderImageView setImage:[UIImage imageNamed:@"gender_female"]];
                }else{
                    ///保密
                    [cell.genderImageView setImage:[UIImage imageNamed:@"timebank_icon_user"]];
                }

                
                //学校名称
                cell.schoolLabel.text = businessCenterProgectDetailModel.businessCenterProgectDetailUserModel.businessCenterProgectDetailCollege;
                
                
                
                return cell;

            }
        }
            break;
            
        case 1:{
            
            
            
            BusinessProjectDetailThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
            
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[CommonUtils getEffectiveUrlWithUrl:businessCenterProgectDetailModel.businessCenterProgectDetailTutorModel.businessCenterProgectDetailTutorImage withType:1]] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
            
            cell.nameLabel.text = businessCenterProgectDetailModel.businessCenterProgectDetailTutorModel.businessCenterProgectDetailTutorRealName;
            
            
            cell.jobNameLabel.text = businessCenterProgectDetailModel.businessCenterProgectDetailTutorModel.businessCenterProgectDetailTutorJob;
            
            
            
            
            
            return cell;
            
                
            
        }
            break;
            
        case 2:{
            
            
            
            BusinessProjectDetailFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fourCell" forIndexPath:indexPath];
            
            if (indexPath.row == 0) {
                
                cell.titleLabel.text = @"经费预算";
                
                cell.contentLabel.text =  businessCenterProgectDetailModel.businessCenterProgectDetailBudge;
                
            }else{
                
                cell.titleLabel.text = @"项目领域";
                
                cell.contentLabel.text =  businessCenterProgectDetailModel.businessCenterProgectDetailField;
                


            }
            
            
            
            return cell;
            
            
            
        }
            break;

        case 3:{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:14];

            
            
            if (indexPath.row == 0) {
                
                cell.textLabel.textColor = [UIColor lightGrayColor];
                
                cell.textLabel.text = @"项目简介";
                
                
            }else{
                
                
                cell.textLabel.text =  businessCenterProgectDetailModel.businessCenterProgectDetailDescription;
            }
            
           
            
            return cell;
            
            
            
        }
            break;
        case 4:{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:14];

            
            if (indexPath.row == 0) {
                
                cell.textLabel.textColor = [UIColor lightGrayColor];
                
                cell.textLabel.text = @"项目成员";
                
                
            }else{
                
                
                cell.textLabel.text =  businessCenterProgectDetailModel.businessCenterProgectDetailMember;
            }
            
            return cell;
        }
            break;
        case 5:{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:14];

            
            
            if (indexPath.row == 0) {
                
                cell.textLabel.textColor = [UIColor lightGrayColor];
                
                cell.textLabel.text = @"项目面临问题及需求";
                
                
            }else{
                
                
                cell.textLabel.text =  businessCenterProgectDetailModel.businessCenterProgectDetailBackground;
            }
            
            return cell;
        }
            break;
            
        case 6:{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:14];

            
            if (indexPath.row == 0) {
                
                cell.textLabel.textColor = [UIColor lightGrayColor];
                
                cell.textLabel.text = @"项目实施计划和预期进展";
                
                
            }else{
                
                
                cell.textLabel.text =  businessCenterProgectDetailModel.businessCenterProgectDetailPlan;
            }
            
            return cell;
        }
            break;




            
        default:{
            return nil;
        }
            break;
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            
            return 80;
            
            break;
            
        default:
            
            return 45;
            break;
    }
}

#pragma mark - 请求创业项目详情数据
-(void)requestToGetBusinessProjectDetail
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.businessCenterProgectModel.businessCenterProgectId?self.businessCenterProgectModel.businessCenterProgectId:@"" forKey:@"id"];
    //[dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance]businessCenterGetProjectDetailWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSDictionary * dataDic = model.responseCommonDic ;
            businessCenterProgectDetailModel = [[BusinessCenterProgectDetailModel alloc]initWithDic:dataDic];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        [self.tableView reloadData];
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
