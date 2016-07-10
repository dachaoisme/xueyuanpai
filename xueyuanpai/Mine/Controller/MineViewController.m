//
//  MineViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MineViewController.h"

#import "MineOneStyleTableViewCell.h"
#import "MineTwoStyleTableViewCell.h"

#import "MineIntegralViewController.h"

#import "MineProjectViewController.h"
#import "MineBankViewController.h"
#import "MineJobMarketViewController.h"
#import "MineFriendsViewController.h"
#import "MineCollectionViewController.h"
#import "MineSettingViewController.h"


#import "MyWalletViewController.h"


#import "EditProfileViewController.h"

#import "EditTeacherProfileViewController.h"
#import "SelectedSchollViewController.h"



@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,MineOneStyleTableViewCellDelegate>


@property (nonatomic,strong)UITableView *tableView;

///展示地理位置的lable
@property (nonatomic,strong) UILabel *showLocationLable;

@end

@implementation MineViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self setUserDefineLeftReturnBtn];
    [self setTitle:@"我的"];
    [self createLeftBackNavBtn];
    
    [self creatRightNavWithTitle:@"编辑认证资料"];
    
    
    [self createTableView];
    
    
    //添加切换学校视图
    [self changeSchoolView];
    
}

#pragma mark - 导航栏右侧按钮响应方法
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    
    
    if ([UserAccountManager sharedInstance].userRole == UserInfoRoleStudent) {
        
        //编辑认证个人资料
        EditProfileViewController *editProfileVC = [[EditProfileViewController alloc] init];
        
        [self.navigationController pushViewController:editProfileVC animated:YES];

    }else if ([UserAccountManager sharedInstance].userRole == UserInfoRoleTeacher){
        //编辑认证导师资料
    
        EditTeacherProfileViewController *teacherVC = [[EditTeacherProfileViewController alloc] init];
        
        [self.navigationController pushViewController:teacherVC animated:YES];
    
    }
    
    
    
    
}

#pragma mark - 添加切换学校视图
- (void)changeSchoolView{
    UIView *schoolShowView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 50)];
    schoolShowView.layer.borderWidth = 1;
    schoolShowView.layer.borderColor = [CommonUtils colorWithHex:@"999999"].CGColor;
    schoolShowView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:schoolShowView];
    
    
    //定位信息的显示  deliver_icon_location
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 16, 16)];
    imageView.image = [UIImage imageNamed:@"shetuan_icon_location"];
    [schoolShowView addSubview:imageView];
    
    
    UILabel *showLocationLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5,10, SCREEN_WIDTH - CGRectGetMaxX(imageView.frame) - 15, 20)];
    showLocationLable.text = [UserAccountManager sharedInstance].userCollegeName;
    showLocationLable.font = [UIFont systemFontOfSize:14];
    [schoolShowView addSubview:showLocationLable];
    self.showLocationLable = showLocationLable;
    
    
    
    //切换的按钮
    UILabel *changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 10, 50, 20)];
    changeLabel.font = [UIFont systemFontOfSize:14];
    changeLabel.text = @"切换";
    changeLabel.textAlignment = NSTextAlignmentCenter;
    changeLabel.textColor = [CommonUtils colorWithHex:@"00beaf"];
    changeLabel.layer.borderColor = [CommonUtils colorWithHex:@"00beaf"].CGColor;
    changeLabel.layer.borderWidth = 1;
    changeLabel.layer.cornerRadius = 3;
    changeLabel.layer.masksToBounds = YES;
    [schoolShowView addSubview:changeLabel];
    
    
    
    //添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSchoolAction)];
    
    [schoolShowView addGestureRecognizer:tapGesture];
    
    
    
}

#pragma mark - 修改学校
- (void)changeSchoolAction{
    
    SelectedSchollViewController *selectedSchoolVC = [[SelectedSchollViewController alloc] init];
    
    __weak typeof(self)weakSelf = self;
    selectedSchoolVC.callBackBlock = ^(CollegeModel *collegeModel) {
        
        //修改存储本地的学校
        [[NSUserDefaults standardUserDefaults] setObject:collegeModel.collegeName forKey:@"college_name"];
        

        
        weakSelf.showLocationLable.text = collegeModel.collegeName;
        
        
        [weakSelf requestSchoolName:collegeModel.collegeID];
        
    };
    [self.navigationController pushViewController:selectedSchoolVC animated:YES];
    

}

- (void)requestSchoolName:(NSString *)collegeID{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    
    if (collegeID.length > 0) {
        [dic setValue:collegeID forKey:@"college_id"];

    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]updateUserSchoolWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model.responseCode ==ResponseCodeSuccess) {

            [CommonUtils showToastWithStr:@"切换成功"];
            
            if (model.responseCommonDic.count > 0) {
                
                //修改用户id和积分数
                [[NSUserDefaults standardUserDefaults] setObject:[model.responseCommonDic objectForKey:@"user_id"] forKey:@"user_id"];
                
                [[NSUserDefaults standardUserDefaults] setObject:[model.responseCommonDic objectForKey:@"points"] forKey:@"points"];
                
            }

        }else{

            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];

}


#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    [tableView registerClass:[MineOneStyleTableViewCell class] forCellReuseIdentifier:@"oneCell"];
    
    
    [tableView registerNib:[UINib nibWithNibName:@"MineTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];

    
    //设置头部视图
    UIView *headBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    headBackGroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    //头像
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 35, 20, 70, 70)];
    headImageView.layer.cornerRadius = 35;
    headImageView.layer.masksToBounds = YES;
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[UserAccountManager sharedInstance].userIcon] placeholderImage:[UIImage imageNamed:@"avatar"]];
    [headBackGroundView addSubview:headImageView];
    
    
    //姓名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(headImageView.frame), 180, 20)];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.text = [UserAccountManager sharedInstance].userNickname;
    [headBackGroundView addSubview:nameLabel];
    
    //性别
    UIImageView *sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame) - 20, CGRectGetMinY(nameLabel.frame), 12, 12)];
    if ([UserAccountManager sharedInstance].userSex == SexOfManType) {
        ///男
        [sexImageView setImage:[UIImage imageNamed:@"gender_male"]];
    }else{
        ///女
        [sexImageView setImage:[UIImage imageNamed:@"gender_female"]];
    }
    [headBackGroundView addSubview:sexImageView];

    
    //工作职称
    UILabel *jobNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 40, CGRectGetMaxY(nameLabel.frame), 80, 17)];
    jobNameLabel.font = [UIFont systemFontOfSize:14];
    jobNameLabel.textAlignment = NSTextAlignmentCenter;
    
    if ([UserAccountManager sharedInstance].userRole  == UserInfoRoleStudent) {
        //学生
        jobNameLabel.text = [UserAccountManager sharedInstance].userCollegeName;
        
    } else {
        //老师
        jobNameLabel.text = [UserAccountManager sharedInstance].userJob;
        
    }
    jobNameLabel.textColor = [UIColor lightGrayColor];
    
    [headBackGroundView addSubview:jobNameLabel];
    
    
    tableView.tableHeaderView = headBackGroundView;
    
}


#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 60;
    }else{
        
        return 45;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        MineOneStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        
        cell.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.moneyLabel.text = [NSString stringWithFormat:@"￥%@",[UserAccountManager sharedInstance].userUsableMoney?[UserAccountManager sharedInstance].userUsableMoney:@"0"];
        cell.integralLabel.text = [[UserAccountManager sharedInstance]userUsablePoints];
        return cell;

        
    }else{
        
        MineTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        switch (indexPath.row) {
            case 1:{
                
                
                break;
            }
            case 2:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_timebank"];
                
                cell.contentLabel.text = @"我的时间银行";
                
                break;
            }
            case 3:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_market"];
                
                cell.contentLabel.text = @"我的跳蚤市场";

                
                break;
            }
            case 4:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_friends"];
                
                cell.contentLabel.text = @"我的好友";

                
                break;
            }
            case 5:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_fav"];
                
                cell.contentLabel.text = @"我的收藏";
                
                break;
            }
            case 6:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_settings"];
                
                cell.contentLabel.text = @"设置";

                
                break;
            }
                
            default:
                break;
        }
        
        return cell;
        
    }
   
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if (indexPath.row == 1) {
        //跳转我的项目
        MineProjectViewController *projectVC = [[MineProjectViewController alloc] init];
        projectVC.user_id = [UserAccountManager sharedInstance].userId;
        [self.navigationController pushViewController:projectVC animated:YES];
        
        
    }else if (indexPath.row == 2){
        
        //跳转我的时间银行
        MineBankViewController *bankVC = [[MineBankViewController alloc] init];
        bankVC.user_id = [UserAccountManager sharedInstance].userId;

        [self.navigationController pushViewController:bankVC animated:YES];
        
        
    }else if (indexPath.row == 3) {
        
        //跳转跳槽市场界面
        MineJobMarketViewController *jobMarketVC = [[MineJobMarketViewController alloc] init];
        jobMarketVC.user_id = [UserAccountManager sharedInstance].userId;
        [self.navigationController pushViewController:jobMarketVC animated:YES];
    }else if (indexPath.row == 4) {
        
        //跳转好友列表界面
//        MineFriendsViewController *friendsVC = [[MineFriendsViewController alloc] init];
//        
//        [self.navigationController pushViewController:friendsVC animated:YES];
        
        EaseUsersListViewController *listViewController = [[EaseUsersListViewController alloc] init];
        [self.navigationController pushViewController:listViewController animated:YES];
        
    }else if (indexPath.row == 5) {
        
        //跳转我的收藏界面
        MineCollectionViewController *collectionVC = [[MineCollectionViewController alloc] init];
        
        [self.navigationController pushViewController:collectionVC animated:YES];
        
    }else if (indexPath.row == 6) {
        
        //跳转设置界面
        MineSettingViewController *settingVC = [[MineSettingViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}


#pragma mark - 我的钱包按钮的跳转事件
- (void)leftAction{
    
    
    MyWalletViewController *walletVC = [[MyWalletViewController alloc] init];
    
    [self.navigationController pushViewController:walletVC animated:YES];
    
}


#pragma mark - 我的积分按钮的跳转事件
- (void)rightAction{
        
    MineIntegralViewController *integralVC = [[MineIntegralViewController alloc] init];
    
    [self.navigationController pushViewController:integralVC animated:YES];
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
