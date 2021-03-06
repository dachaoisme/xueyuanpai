//
//  JMMineViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/9.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMineViewController.h"
#import "MineTwoStyleTableViewCell.h"
#import "LoginViewController.h"

#import "MineIntegralViewController.h"
#import "MineSettingViewController.h"

#import "JMEditProfileViewController.h"

#import "JMMIneProjectRootViewController.h"
#import "JMStartupProjectRootViewController.h"
#import "JMMIneSalonRootViewController.h"


@interface JMMineViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UIImageView *headImageView;
    //工作职称
    UILabel *jobNameLabel;
    
    UIButton *headBtn;
    
}
///展示地理位置的lable
@property (nonatomic,strong) UILabel *showLocationLable;
@property (nonatomic,strong)UITableView *tableView;


///展示积分
@property (nonatomic,strong)NSString *jifenStr;

@end

@implementation JMMineViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:NO];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self setUserDefineLeftReturnBtn];
    [self setTitle:@"个人中心"];

    [self creatRightNavWithTitle:@"编辑个人资料"];

    
    [self createTableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshInfo) name:NOTI_UPDATE_BY_USER_ID object:nil];
}
-(void)refreshInfo
{
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[UserAccountManager sharedInstance].userIcon] placeholderImage:[UIImage imageNamed:@"avatar"]];
    [headBtn setTitle:[UserAccountManager sharedInstance].userNickname forState:UIControlStateNormal];
    if ([UserAccountManager sharedInstance].userSex == SexOfManType) {
        ///男
        [headBtn setImage:[UIImage imageNamed:@"gender_male"] forState:UIControlStateNormal];
        
    }else{
        ///女
        [headBtn setImage:[UIImage imageNamed:@"gender_female"] forState:UIControlStateNormal];
    }
    jobNameLabel.text = [UserAccountManager sharedInstance].userCollegeName;
    
    
    //显示积分的数值，并刷新列表界面
    self.jifenStr =  [UserAccountManager sharedInstance].userPoint;
    [self.tableView reloadData];
}
#pragma mark - 导航栏右侧按钮响应方法
-(void)rightItemActionWithBtn:(UIButton *)sender
{

    [self editProfileAction];
}

- (void)editProfileAction{
    
    if ([UserAccountManager sharedInstance].isLogin==YES) {
        
        //编辑认证个人资料
        JMEditProfileViewController *editProfileVC = [[JMEditProfileViewController alloc] init];
        [self.navigationController pushViewController:editProfileVC animated:YES];

        
        
    }else{
        
        [self judgeLoginStatus];
        
    }

    
}




#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"MineTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    
    //设置头部视图
    UIView *headBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    headBackGroundView.backgroundColor = [CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    
    
    //头像
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 45, 20, 70, 70)];
    headImageView.layer.cornerRadius = 35;
    headImageView.layer.masksToBounds = YES;
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[UserAccountManager sharedInstance].userIcon] placeholderImage:[UIImage imageNamed:@"avatar"]];
    headImageView.userInteractionEnabled = YES;
    [headBackGroundView addSubview:headImageView];
    
    
    UITapGestureRecognizer *tapHeadImageRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editProfileAction)];
    [headBackGroundView addGestureRecognizer:tapHeadImageRecognizer];

   
    headBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [headBtn setTitle:[UserAccountManager sharedInstance].userNickname forState:UIControlStateNormal];
    [headBtn setTitleColor:[CommonUtils colorWithHex:NORMAL_SUBTITLE_BLACK_COLOR] forState:UIControlStateNormal];
    headBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [headBtn setFrame:CGRectMake(0, CGRectGetMaxY(headImageView.frame), SCREEN_WIDTH, 20)];
    [headBackGroundView addSubview:headBtn];
    [headBtn setTitle:[UserAccountManager sharedInstance].userNickname forState:UIControlStateNormal];
    if ([UserAccountManager sharedInstance].userSex == SexOfManType) {
        ///男
        [headBtn setImage:[UIImage imageNamed:@"gender_male"] forState:UIControlStateNormal];
        
    }else{
        ///女
        [headBtn setImage:[UIImage imageNamed:@"gender_female"] forState:UIControlStateNormal];
    }

    //工作职称
    jobNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headBtn.frame), SCREEN_WIDTH, 17)];
    jobNameLabel.font = [UIFont systemFontOfSize:14];
    jobNameLabel.textAlignment = NSTextAlignmentCenter;
    
    jobNameLabel.text =  [NSString stringWithFormat:@"%@ %@",[UserAccountManager sharedInstance].userCollegeName,[UserAccountManager sharedInstance].userGrade];
    jobNameLabel.textColor =[CommonUtils colorWithHex:NORMAL_SUBTITLE_BLACK_COLOR];
    
    [headBackGroundView addSubview:jobNameLabel];
    
    
    tableView.tableHeaderView = headBackGroundView;
    
    
    
    

}


#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        MineTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        switch (indexPath.row) {

            case 0:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_coin"];
                
                cell.contentLabel.text = @"我的积分";
                
                cell.scoreLabel.text = [UserAccountManager sharedInstance].userPoint;
                
                break;
            }
            case 1:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_project"];
                
                cell.contentLabel.text = @"我的实训项目";
                
                
                break;
            }
            case 2:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_lesson"];
                
                cell.contentLabel.text = @"我的创业课程";
                
                
                break;
            }
            case 3:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_salong"];
                
                cell.contentLabel.text = @"我的沙龙活动";
                
                
                break;
            }
            case 4:{
                
                cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_settings"];
                
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
    
    
   if (indexPath.row == 1){
       
       if ([UserAccountManager sharedInstance].isLogin==YES) {
           
           //跳转我的实训项目
           JMMIneProjectRootViewController *projectVC = [[JMMIneProjectRootViewController alloc] init];
           
           [self.navigationController pushViewController:projectVC animated:YES];
           

           
       }else{
           
           [self judgeLoginStatus];

       }

    }else if (indexPath.row == 2) {
        
        if ([UserAccountManager sharedInstance].isLogin==YES) {
            
            //我的创业课程
            JMStartupProjectRootViewController *startupProjectVC = [[JMStartupProjectRootViewController alloc] init];
            
            [self.navigationController pushViewController:startupProjectVC animated:YES];
            
        }else{
            
            [self judgeLoginStatus];

            
        }
        
        

    }else if (indexPath.row == 3) {
        
        if ([UserAccountManager sharedInstance].isLogin==YES) {
            
            //我的沙龙活动
            JMMIneSalonRootViewController *activityListVC = [[JMMIneSalonRootViewController alloc] init];
            
            [self.navigationController pushViewController:activityListVC animated:YES];
            
        }else{
            
            [self judgeLoginStatus];

            
        }
        
        
    }else if (indexPath.row == 4) {
        
        if ([UserAccountManager sharedInstance].isLogin==YES) {
            
            //设置
            MineSettingViewController *settingVC = [[MineSettingViewController alloc] init];
            [self.navigationController pushViewController:settingVC animated:YES];
            
 
            
        }else{
            
            [self judgeLoginStatus];

            
        }

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

