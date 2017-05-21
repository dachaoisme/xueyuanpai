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


#import "LoginViewController.h"
@interface MineSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString * netDownloadUrl;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MineSettingViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
}


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
    tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要退出登录？" message:@"\n" preferredStyle:UIAlertControllerStyleAlert];
    
    //这跟 actionSheet有点类似了,因为都是UIAlertController里面的嘛
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UserAccountManager sharedInstance]exitLogin];
        
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:^{
            
            [self.navigationController popToRootViewControllerAnimated:NO];

        }];

    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    //添加按钮
    [alert addAction:ok];
    [alert addAction:cancel];
    //以modal的方式来弹出
    [self presentViewController:alert animated:YES completion:^{ }];
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
                cell.contentLabel.text = [NSString stringWithFormat:@"%.2fM",[self folderSizeAtPath]];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if (indexPath.section == 0) {
        
        //跳转修改手机绑定界面
        BindPhoneViewController *bindPhoneVC = [[BindPhoneViewController alloc] init];
        [self.navigationController pushViewController:bindPhoneVC animated:YES];
        
        
    }else if (indexPath.section == 1) {
        
        MineSettingTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        
        if (indexPath.row == 0) {
            
            //跳转意见反馈
            FeedbackViewController *feedVC = [[FeedbackViewController alloc] init];
            [self.navigationController pushViewController:feedVC animated:YES];
            
        }else if (indexPath.row == 1){
            weakSelf(weakSelf);
            NSString *message = [NSString stringWithFormat:@"缓存大小为：%.2f,确定要清理吗?",[self folderSizeAtPath]];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
                [weakSelf clearCache];
                
                
                cell.contentLabel.hidden = YES;
                
                
            }];
            
            // Add the actions.
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            

            
        }else if (indexPath.row == 2) {
            //检查更新
            [self appstoreUpDate];
        }else if (indexPath.row == 3) {
            //跳转关于我们界面
            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
            
            [self.navigationController pushViewController:aboutUsVC animated:YES];
        }
    }
}
-(void)appstoreUpDate
{
    //获取版本号
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [[HttpClient sharedInstance]checkUpdateWithParams:params withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        if (responseModel.responseCode==ResponseCodeSuccess) {
            
            NSString * netNewVersion = [NSString stringWithFormat:@"%@",[responseModel.responseCommonDic objectForKey:@"ios_version"]];
            netDownloadUrl = [responseModel.responseCommonDic objectForKey:@"ios_download_url"];
            NSString *currentAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            if ([[self removeDotWithString:netNewVersion] floatValue]>[[self removeDotWithString:currentAppVersion] floatValue]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"更新" message:[NSString stringWithFormat:@"发现新的app版本%@",netNewVersion] delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"立即更新", nil];
                [alertView show];
            }else{
                [CommonUtils showToastWithStr:@"已经是最新版本哦"];
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
   
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:netDownloadUrl]];
        exit(0);
    }
}
#pragma mark - 清除缓存
-(float)folderSizeAtPath{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];

    if ([fileManager fileExistsAtPath:path]) {
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

-(void)clearCache{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];

    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}
-(NSString *)removeDotWithString:(NSString *)string
{
    NSString *finalStr = [string stringByReplacingOccurrencesOfString:@"." withString:@""];
    return finalStr;
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
