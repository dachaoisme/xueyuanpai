//
//  BusinessTeacherDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessTeacherDetailViewController.h"

#import "BusinessTeacherOneTableViewCell.h"
#import "BusinessTeacherTwoTableViewCell.h"

@interface BusinessTeacherDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BusinessCenterTutorDetailModel *tutorDetailModel;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation BusinessTeacherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"导师详情";
    
    
    [self createLeftBackNavBtn];
    
    [self p_setupShareButtonItem];
    
    
    [self createTableView];
    
    [self requestToGetBusinessTutorDetail];
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
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessTeacherOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
     [tableView registerNib:[UINib nibWithNibName:@"BusinessTeacherTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 4;
            break;
        case 2:
            return 1;
            break;

            
        default:
            return 2;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    

    if (indexPath.section == 0) {
        
        BusinessTeacherOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        
        return cell;

    }else if (indexPath.section == 1){
        
        BusinessTeacherTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0:
                
                cell.titleLabel.text = @"工作单位";
                
                break;
            case 1:
                
                cell.titleLabel.text = @"职   务";

                break;
            case 2:
                
                cell.titleLabel.text = @"联系电话";
                
                break;
            case 3:
                
                cell.titleLabel.text = @"邮   箱";

                break;
                
            default:
                break;
        }
        
        return cell;

        
        
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        
        if (indexPath.section == 2) {
            
            cell.textLabel.text = @"已申领3个项目";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的
        }else if (indexPath.section == 3){
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"擅长辅导领域";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor = [UIColor lightGrayColor];

            }else{
                
                cell.textLabel.text = @"互联网等";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
            }
            
            
        }else if (indexPath.section == 4){
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"导师背景";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor = [UIColor lightGrayColor];
                
            }else{
                
                cell.textLabel.text = @"背景简介";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
            }
            
            
        }

        
        


        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 100;
    }else{
        
        return 45;
    }
    
    
}

#pragma mark - 请求明星导师详情数据
-(void)requestToGetBusinessTutorDetail
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.tutorModel.businessCenterTutorId?self.tutorModel.businessCenterTutorId:@"" forKey:@"id"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterGetTeachersDetailWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSDictionary * dataDic = model.responseCommonDic ;
            tutorDetailModel = [[BusinessCenterTutorDetailModel alloc]initWithDic:dataDic];
            
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
