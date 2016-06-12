//
//  BussinessProjectTeacherDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BussinessProjectTeacherDetailViewController.h"

#import "BusinessProjectDetailOneTableViewCell.h"
#import "BusinessProjectDetailTwoTableViewCell.h"
#import "BusinessProjectDetailThreeTableViewCell.h"
#import "BusinessProjectDetailFourTableViewCell.h"

#import "BusinessProjectDetailFiveTableViewCell.h"


@interface BussinessProjectTeacherDetailViewController ()<UITableViewDelegate,UITableViewDataSource,BusinessProjectDetailFiveTableViewCellDelegate>
{
    BusinessCenterProgectDetailModel * businessCenterProgectDetailModel;
    BOOL yesIsCollection;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIBarButtonItem * favoriteButtonItem;


@end

@implementation BussinessProjectTeacherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导师查看到的详情
    
    self.title = @"项目详情";
    yesIsCollection = NO;
    [self createLeftBackNavBtn];
    
    [self theTabBarHidden:YES];
    
    
    [self p_setupShareButtonItem];
    
    
    [self createTableView];
    
    [self requestToGetBusinessProjectDetail];
    
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
    [dic setValue:self.projectId forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfProject] forKey:@"type"];
    [[HttpClient sharedInstance] addCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"收藏成功"];
            [_favoriteButtonItem setImage:[UIImage imageNamed:@"nav_icon_fav_full"]];
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
    [dic setValue:self.projectId forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfProject] forKey:@"type"];
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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    float space = 16;
    float btnHeight = 44;
    float footViewHeight = 48;
    float btnWidth = SCREEN_WIDTH - 30;
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footViewHeight)];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"申领该项目" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [submitBtn setFrame:CGRectMake(space, space, btnWidth,btnHeight)];
    submitBtn.layer.cornerRadius = 10.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(applyProject) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:submitBtn];
    
    self.tableView.tableFooterView = backGroundView;
    

    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"BusinessProjectDetailOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessProjectDetailTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessProjectDetailThreeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"threeCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessProjectDetailFourTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"fourCell"];
    
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessProjectDetailFiveTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"fiveCell"];

    
}

#pragma mark - 申领项目按钮响应方法
- (void)applyProject{
    
    [CommonUtils showToastWithStr:@"申领项目"];
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
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.titleLabel.text = businessCenterProgectDetailModel.businessCenterProgectDetailTitle;
                
                cell.dateLabel.text = businessCenterProgectDetailModel.businessCenterProgectDetailDate;
                
                
                return cell;
                
                
            }else{
                
                BusinessProjectDetailTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
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
            
            BusinessProjectDetailFiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fiveCell" forIndexPath:indexPath];
            cell.delegate = self;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
           
            [cell bindModel:businessCenterProgectDetailModel.businessCenterProgectDetailChiefModel];

            return cell;
            
        }
            break;
            
            
        case 2:{
            
            
            
            BusinessProjectDetailFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fourCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
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
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
            if (indexPath.row == 0) {
                
                cell.textLabel.textColor = [UIColor lightGrayColor];
                
                cell.textLabel.text = @"项目简介";
                
                
            }else{
                
                
                cell.textLabel.text =  businessCenterProgectDetailModel.businessCenterProgectDetailDescription;
                cell.textLabel.numberOfLines = 0;
                
                cell.textLabel.frame =  CGRectMake(5, 5, SCREEN_WIDTH - 10, [self textHeight:businessCenterProgectDetailModel.businessCenterProgectDetailDescription]);
            }
            
            
            
            return cell;
            
            
            
        }
            break;
        case 4:{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (indexPath.row == 0) {
                
                cell.textLabel.textColor = [UIColor lightGrayColor];
                
                cell.textLabel.text = @"项目成员";
                
                
            }else{
                
                
                cell.textLabel.text =  businessCenterProgectDetailModel.businessCenterProgectDetailMember;
                
                cell.textLabel.numberOfLines = 0;
                
                
                cell.textLabel.frame =  CGRectMake(5, 5, SCREEN_WIDTH - 10, [self textHeight: businessCenterProgectDetailModel.businessCenterProgectDetailMember]);
            }
            
            return cell;
        }
            break;
        case 5:{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (indexPath.row == 0) {
                
                cell.textLabel.textColor = [UIColor lightGrayColor];
                
                cell.textLabel.text = @"项目面临问题及需求";
                
                
            }else{
                
                
                cell.textLabel.text =  businessCenterProgectDetailModel.businessCenterProgectDetailBackground;
                
                
                cell.textLabel.numberOfLines = 0;
                
                
                cell.textLabel.frame =  CGRectMake(5, 5, SCREEN_WIDTH - 10, [self textHeight:businessCenterProgectDetailModel.businessCenterProgectDetailBackground]);
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
                cell.textLabel.textColor = [UIColor blackColor];
                
                
                cell.textLabel.numberOfLines = 0;
                
                
                cell.textLabel.frame =  CGRectMake(5, 5, SCREEN_WIDTH - 10, [self textHeight:businessCenterProgectDetailModel.businessCenterProgectDetailPlan]);
                
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
        case 0:{
            
            return 80;
        }
            break;
            
        case 1:{
            
            return 180;
        }
            break;
            
        case 3:{
            
            if (indexPath.row == 0) {
                
                return 45;
                
            }else{
                
                //根据文本信息多少调整cell的高度
                NSString * string =   businessCenterProgectDetailModel.businessCenterProgectDetailDescription;
                return [self textHeight:string];
                
            }
            
            
        }
            break;
        case 4:{
            
            if (indexPath.row == 0) {
                return 45;
            }else{
                
                //根据文本信息多少调整cell的高度
                NSString * string =   businessCenterProgectDetailModel.businessCenterProgectDetailMember;
                return [self textHeight:string];
                
            }
            
            
        }
            break;
        case 5:{
            
            if (indexPath.row == 0) {
                return 45;
            }else{
                //根据文本信息多少调整cell的高度
                NSString * string = businessCenterProgectDetailModel.businessCenterProgectDetailBackground;
                return [self textHeight:string];
                
            }
            
            
        }
            break;
        case 6:{
            
            if (indexPath.row == 0) {
                
                return 45;
                
            }else{
                
                //根据文本信息多少调整cell的高度
                NSString * string =   businessCenterProgectDetailModel.businessCenterProgectDetailPlan;
                return [self textHeight:string];
                
            }
            
            
        }
            break;
            
        default:
            return 45;
            break;
    }
}


//自适应撑高
//计算字符串的frame
- (CGFloat)textHeight:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 10, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    //返回计算好的高度
    return rect.size.height;
    
}


#pragma mark - 请求创业项目详情数据
-(void)requestToGetBusinessProjectDetail
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.projectId?self.projectId:@"" forKey:@"id"];
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

#pragma mark - 打电话的代理方法
- (void)callPhoneNumberAction{
    
    [CommonUtils callServiceWithTelephoneNum:businessCenterProgectDetailModel.businessCenterProgectDetailChiefModel.businessCenterProgectDetailChiefTelephone];

    
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