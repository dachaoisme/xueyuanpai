//
//  JMMineViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/9.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMineViewController.h"
#import "EditProfileViewController.h"
#import "MineTwoStyleTableViewCell.h"
@interface JMMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

///展示地理位置的lable
@property (nonatomic,strong) UILabel *showLocationLable;


@end

@implementation JMMineViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self setUserDefineLeftReturnBtn];
    [self setTitle:@"我的"];
    
    [self creatRightNavWithTitle:@"编辑认证资料"];
    
    [self createTableView];
    
}

#pragma mark - 导航栏右侧按钮响应方法
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    //编辑认证个人资料
    EditProfileViewController *editProfileVC = [[EditProfileViewController alloc] init];
    [self.navigationController pushViewController:editProfileVC animated:YES];
}




#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
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
    UILabel *jobNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame), SCREEN_WIDTH, 17)];
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
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    

        MineTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        switch (indexPath.row) {

            case 0:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_timebank"];
                
                cell.contentLabel.text = @"我的积分";
                
                break;
            }
            case 1:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_market"];
                
                cell.contentLabel.text = @"我的实训项目";
                
                
                break;
            }
            case 2:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_friends"];
                
                cell.contentLabel.text = @"我的创业课程";
                
                
                break;
            }
            case 3:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_friends"];
                
                cell.contentLabel.text = @"我的沙龙活动";
                
                
                break;
            }
            case 4:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_friends"];
                
                cell.contentLabel.text = @"设置";
                
                
                break;
            }
            default:
                break;
        }
        
        return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row == 0) {
        //跳转我的积分
//        MineProjectViewController *projectVC = [[MineProjectViewController alloc] init];
//        projectVC.user_id = [UserAccountManager sharedInstance].userId;
//        [self.navigationController pushViewController:projectVC animated:YES];
        
        
    }else if (indexPath.row == 1){
        
        //跳转我的实训项目
//        MineBankViewController *bankVC = [[MineBankViewController alloc] init];
//        bankVC.user_id = [UserAccountManager sharedInstance].userId;
//        
//        [self.navigationController pushViewController:bankVC animated:YES];
        
        
    }else if (indexPath.row == 2) {
        
        //我的创业课程
//        MineJobMarketViewController *jobMarketVC = [[MineJobMarketViewController alloc] init];
//        jobMarketVC.user_id = [UserAccountManager sharedInstance].userId;
//        [self.navigationController pushViewController:jobMarketVC animated:YES];
    }else if (indexPath.row == 3) {
        
        //我的沙龙活动
        //        MineFriendsViewController *friendsVC = [[MineFriendsViewController alloc] init];
        //
        //        [self.navigationController pushViewController:friendsVC animated:YES];
        
        EaseUsersListViewController *listViewController = [[EaseUsersListViewController alloc] init];
        [self.navigationController pushViewController:listViewController animated:YES];
        
    }else if (indexPath.row == 4) {
        
        //设置
//        MineCollectionViewController *collectionVC = [[MineCollectionViewController alloc] init];
//        
//        [self.navigationController pushViewController:collectionVC animated:YES];
        
    }
}

@end
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

