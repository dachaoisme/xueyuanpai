//
//  MineSettingViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MineSettingViewController.h"

#import "MineSettingTableViewCell.h"

#import "BindPhoneViewController.h"
#import "FeedbackViewController.h"
#import "AboutUsViewController.h"

@interface MineSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MineSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
    
    
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
        
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"MineSettingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
    
    //退出登录按钮
    UIButton *existButton = [UIButton buttonWithType:UIButtonTypeCustom];
    existButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    existButton.backgroundColor = [UIColor whiteColor];
    [existButton setTitleColor:[CommonUtils colorWithHex:@"ff6478"] forState:UIControlStateNormal];
    [existButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [existButton addTarget:self action:@selector(existAction) forControlEvents:UIControlEventTouchUpInside];
    tableView.tableFooterView = existButton;
    
    
    
}

#pragma mark - 退出按钮的响应方法
- (void)existAction{
    
    [CommonUtils showToastWithStr:@"退出"];
}


#pragma mark - tableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return 4;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        
        cell.contentLabel.text = [UserAccountManager sharedInstance].userMobile;
        
    }else{
        
        
        switch (indexPath.row) {
            case 0:{
                cell.titleLabel.text = @"意见反馈";
                
                cell.contentLabel.hidden = YES;
                break;
            }
            case 1:{
                cell.titleLabel.text = @"清除缓存";
                cell.contentLabel.text = @"4M";
                break;
            }
            case 2:{
                cell.titleLabel.text = @"检查更新";
                cell.contentLabel.hidden = YES;

                break;
            }
            case 3:{
                cell.titleLabel.text = @"关于我们";
                cell.contentLabel.hidden = YES;


                break;
            }

                
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        //跳转修改手机绑定界面
        BindPhoneViewController *bindPhoneVC = [[BindPhoneViewController alloc] init];
        [self.navigationController pushViewController:bindPhoneVC animated:YES];
        
        
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            //跳转意见反馈
            FeedbackViewController *feedVC = [[FeedbackViewController alloc] init];
            [self.navigationController pushViewController:feedVC animated:YES];
            
        }else if (indexPath.row == 3) {
            //跳转关于我们界面
            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
            
            [self.navigationController pushViewController:aboutUsVC animated:YES];
        }
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
