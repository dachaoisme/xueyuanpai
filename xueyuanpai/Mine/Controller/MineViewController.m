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


#import "EditProfileViewController.h"
#import "MyWalletViewController.h"



@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,MineOneStyleTableViewCellDelegate>


@property (nonatomic,strong)UITableView *tableView;

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
    
    
}

#pragma mark - 导航栏右侧按钮响应方法
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    
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
    [tableView registerClass:[MineOneStyleTableViewCell class] forCellReuseIdentifier:@"oneCell"];
    
    
    [tableView registerNib:[UINib nibWithNibName:@"MineTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];

    
    //设置头部视图
    UIView *headBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    headBackGroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    //头像
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 35, 20, 70, 70)];
    headImageView.layer.cornerRadius = 35;
    headImageView.layer.masksToBounds = YES;
    headImageView.image = [UIImage imageNamed:@"test.jpg"];
    [headBackGroundView addSubview:headImageView];
    
    
    //姓名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 40, CGRectGetMaxY(headImageView.frame), 80, 20)];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"王石";
    [headBackGroundView addSubview:nameLabel];
    
    //工作职称
    UILabel *jobNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 40, CGRectGetMaxY(nameLabel.frame), 80, 17)];
    jobNameLabel.font = [UIFont systemFontOfSize:14];
    
    jobNameLabel.textAlignment = NSTextAlignmentCenter;
    
    jobNameLabel.text = @"万科CEO";
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
                
                cell.contentLabel.text = @"我的跳槽市场";

                
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
    
    if (indexPath.row == 1) {
        //跳转我的项目
        MineProjectViewController *projectVC = [[MineProjectViewController alloc] init];
        [self.navigationController pushViewController:projectVC animated:YES];
        
        
    }else if (indexPath.row == 2){
        
        //跳转我的时间银行
        MineBankViewController *bankVC = [[MineBankViewController alloc] init];
        [self.navigationController pushViewController:bankVC animated:YES];
        
        
    }else if (indexPath.row == 3) {
        
        //跳转跳槽市场界面
        MineJobMarketViewController *jobMarketVC = [[MineJobMarketViewController alloc] init];
        [self.navigationController pushViewController:jobMarketVC animated:YES];
    }else if (indexPath.row == 4) {
        
        //跳转好友列表界面
        MineFriendsViewController *friendsVC = [[MineFriendsViewController alloc] init];
        
        [self.navigationController pushViewController:friendsVC animated:YES];
        
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
   
//    [CommonUtils showToastWithStr:@"我的钱包"];
    
    
    MyWalletViewController *walletVC = [[MyWalletViewController alloc] init];
    
    [self.navigationController pushViewController:walletVC animated:YES];
    
}


#pragma mark - 我的积分按钮的跳转事件
- (void)rightAction{
    
//    [CommonUtils showToastWithStr:@"我的积分"];
    
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
