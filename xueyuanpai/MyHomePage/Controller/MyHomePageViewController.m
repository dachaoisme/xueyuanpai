//
//  MyHomePageViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/7/8.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MyHomePageViewController.h"
#import "MineTwoStyleTableViewCell.h"
#import "MyHomePageModel.h"

#import "MineProjectViewController.h"
#import "MineBankViewController.h"
#import "MineJobMarketViewController.h"

@interface MyHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
///头像
@property (nonatomic,strong)UIImageView *headImageView;
///性别
@property (nonatomic,strong)UIImageView *sexImageView;
///姓名
@property (nonatomic,strong)UILabel *nameLabel;
///工作
@property (nonatomic,strong)UILabel *jobNameLabel;

///是否为好友关系
@property (nonatomic,strong)NSString *isFriend;



@property (nonatomic,strong)MyHomePageModel *homePageModel;

@end

@implementation MyHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createLeftBackNavBtn];
    [self createTableView];

    
    //根据用户id获取个人信息
    [self requestMineInformation];

}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;

    
    
    [tableView registerNib:[UINib nibWithNibName:@"MineTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    [self createHeaderView];
    [self createFooterView];
}

#pragma mark - 创建tableView的头部视图
- (void)createHeaderView{
    
    //设置头部视图
    UIView *headBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    headBackGroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    //头像
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 35, 20, 70, 70)];
    headImageView.layer.cornerRadius = 35;
    headImageView.layer.masksToBounds = YES;
    [headBackGroundView addSubview:headImageView];
    self.headImageView = headImageView;
    
    
    //姓名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(headImageView.frame), 180, 20)];
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [headBackGroundView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //性别
    UIImageView *sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame) - 20, CGRectGetMinY(nameLabel.frame), 12, 12)];
    [headBackGroundView addSubview:sexImageView];
    self.sexImageView = sexImageView;
    
    
    
    //工作职称
    UILabel *jobNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 60, CGRectGetMaxY(nameLabel.frame), 120, 17)];
    jobNameLabel.font = [UIFont systemFontOfSize:14];
    
    jobNameLabel.textAlignment = NSTextAlignmentCenter;
    
    jobNameLabel.textColor = [UIColor lightGrayColor];
    [headBackGroundView addSubview:jobNameLabel];
    self.jobNameLabel = jobNameLabel;
    self.tableView.tableHeaderView = headBackGroundView;

}

#pragma mark - 创建tableView的尾部视图
- (void)createFooterView{
    
    //设置头部视图
    UIView *footerBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    

    ///打招呼
    UIButton *sayHiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sayHiBtn.frame = CGRectMake(10, 20, SCREEN_WIDTH - 20, 40);
    [sayHiBtn addTarget:self action:@selector(sayHiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [sayHiBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [sayHiBtn setTitle:@"打招呼" forState:UIControlStateNormal];
    [sayHiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sayHiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sayHiBtn.layer.cornerRadius = 10;
    sayHiBtn.layer.masksToBounds = YES;
    [footerBackGroundView addSubview:sayHiBtn];
    ///加好友
    UIButton *addFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addFriendBtn.frame = CGRectMake(CGRectGetMinX(sayHiBtn.frame), CGRectGetMaxY(sayHiBtn.frame) + 20, CGRectGetWidth(sayHiBtn.frame), CGRectGetHeight(sayHiBtn.frame));
    [addFriendBtn addTarget:self action:@selector(addFriendAction:) forControlEvents:UIControlEventTouchUpInside];
    [addFriendBtn setBackgroundColor:[CommonUtils colorWithHex:@"f5f5f5"]];
    addFriendBtn.layer.borderColor = [CommonUtils colorWithHex:@"00beaf"].CGColor;
    addFriendBtn.layer.borderWidth = 0.5;
    [addFriendBtn setTitle:@"加好友" forState:UIControlStateNormal];
    [addFriendBtn setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    addFriendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addFriendBtn.layer.cornerRadius = 10;
    addFriendBtn.layer.masksToBounds = YES;
    [footerBackGroundView addSubview:addFriendBtn];
    
    
    self.tableView.tableFooterView = footerBackGroundView;

    
}

#pragma mark - 打招呼
- (void)sayHiBtnAction:(UIButton *)sender{
    
    if ([_isFriend isEqualToString:@"1"]) {
        
        NSLog(@"跳转聊天视图页面");
        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:[UserAccountManager sharedInstance].userMobile conversationType:EMConversationTypeChat];
        
        [self.navigationController pushViewController:chatController animated:YES];
    }else{
        
        
        [CommonUtils showToastWithStr:@"你们还不是好友，请添加它为好友" WithTime:2];

    }
    
    
    
}

#pragma mark - 加好友
- (void)addFriendAction:(UIButton *)sender{
    
    //好友关系  1好友 0 非好友
    if ([_isFriend isEqualToString:@"1"]) {
        [CommonUtils showToastWithStr:@"您们已是好友,可以打招呼" WithTime:2];
        
    }else{
        
        if ([[UserAccountManager sharedInstance].userMobile isEqualToString:_homePageModel.myHomePageMobile]) {
            
            [CommonUtils showToastWithStr:@"自己不能添加自己为好友哦" WithTime:2];

        }else{
            
            EMError *error = [[EMClient sharedClient].contactManager addContact:_homePageModel.myHomePageMobile message:@"我想加您为好友"];
            if (!error) {
                NSLog(@"添加成功");
                
                [CommonUtils showToastWithStr:@"好友申请已发出，请耐心等候回复" WithTime:2];
            }else{
                
                [CommonUtils showToastWithStr:error.description WithTime:2];
                
            }

        }
       
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    switch (indexPath.row) {
        case 0:{
            
            cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_project"];
            
            cell.contentLabel.text = @"TA的创业项目";

            
            break;
        }
        case 1:{
            
            cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_timebank"];
            
            cell.contentLabel.text = @"TA的时间银行";
            
            break;
        }
        case 2:{
            
            cell.oneImageView.image  = [UIImage imageNamed:@"profile_icon_market"];
            
            cell.contentLabel.text = @"TA的跳蚤市场";
            
            
            break;
        }
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //跳转我的项目
        MineProjectViewController *projectVC = [[MineProjectViewController alloc] init];
        projectVC.user_id = _homePageModel.myHomePageUserId;
        [self.navigationController pushViewController:projectVC animated:YES];
        
        
    }else if (indexPath.row == 1){
        
        //跳转我的时间银行
        MineBankViewController *bankVC = [[MineBankViewController alloc] init];
        bankVC.user_id = _homePageModel.myHomePageUserId;

        [self.navigationController pushViewController:bankVC animated:YES];
        
        
    }else if (indexPath.row == 2) {
        
        //跳转跳槽市场界面
        MineJobMarketViewController *jobMarketVC = [[MineJobMarketViewController alloc] init];
        jobMarketVC.user_id = _homePageModel.myHomePageUserId;

        [self.navigationController pushViewController:jobMarketVC animated:YES];
    }
}

#pragma mark - 获取个人信息
- (void)requestMineInformation{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setValue:self.currentUserId forKey:@"user_id"];
    
    if (![self.currentUserId isEqualToString:[UserAccountManager sharedInstance].userId]) {
        
        [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"current_user_id"];

    }

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance]myHomePageWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (model.responseCode == ResponseCodeSuccess) {
            
            _homePageModel = [[MyHomePageModel alloc] initWithDic:model.responseCommonDic];
            
            self.isFriend = _homePageModel.myHomePageIsFriend;
            
            //设置数据
            self.title = _homePageModel.myHomePageNickName;
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:_homePageModel.myHomePageIcon] placeholderImage:[UIImage imageNamed:@"avatar"]];

            if ([_homePageModel.myHomePageSex intValue]== SexOfManType) {
                ///男
                [_sexImageView setImage:[UIImage imageNamed:@"gender_male"]];
            }else if ([_homePageModel.myHomePageSex intValue]==SexOfWomanType){
                ///女
                [_sexImageView setImage:[UIImage imageNamed:@"gender_female"]];
            }else{
                ///保密
                [_sexImageView setImage:[UIImage imageNamed:@"timebank_icon_user"]];
            }
            
            _nameLabel.text = [NSString stringWithFormat:@"积分%@",_homePageModel.myHomePagePoints];
            
            if ([_homePageModel.myHomePageRole isEqualToString:@"1"]) {
                //学生
                _jobNameLabel.text = _homePageModel.myHomePageCollegeName;
                
            } else {
                //老师
                _jobNameLabel.text = _homePageModel.myHomePageJob;
                
            }

            
            
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
