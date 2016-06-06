//
//  BusinessPublishProjectViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessPublishProjectViewController.h"

#import "BusinessPublishProjectOneTableViewCell.h"
#import "BusinessPublishProjectTwoTableViewCell.h"
#import "BusinessPublishProjectThreeTableViewCell.h"

@interface BusinessPublishProjectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BusinessCenterPublicProgectModel * publicProgectModel;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation BusinessPublishProjectViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self theTabBarHidden:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发布项目";
    publicProgectModel = [[BusinessCenterPublicProgectModel alloc]initWithDic:nil];
    [self createLeftBackNavBtn];
    
    
    
    //创建tableView
    [self createTableView];

}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //设置tableView的footView
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(publishAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.tableView.tableFooterView = button;

    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"BusinessPublishProjectOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"BusinessPublishProjectTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    [tableView registerNib:[UINib nibWithNibName:@"BusinessPublishProjectThreeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"threeCell"];
    

}

#pragma mark - 发布按钮
- (void)publishAction{
    
    [CommonUtils showToastWithStr:@"发布项目"];
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            
            return 2;
            break;
            
        case 2:
            return 2;
            break;
            
        default:
            
            return 1;
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 45;
            break;
        case 1:
            return 45;
            break;
        case 2:
            return 45;
            break;
            
        default:
            
            return 150;
            
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            if (indexPath.row == 0) {
                BusinessPublishProjectOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                
                cell.yuanLabel.hidden = YES;
                
                
                return cell;
            }else{
                
                BusinessPublishProjectTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                return cell;
                
                
            }
        }
            break;
        case 1:{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            
            cell.textLabel.text = @"添加负责人信息";
            
            return cell;
            
        }
            break;
        case 2:{
            
            if (indexPath.row == 0) {
                BusinessPublishProjectOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                cell.titleLabel.text = @"经费预算";
                
                return cell;

            }else{
                
                BusinessPublishProjectTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.titleLabel.text = @"项目领域";
                cell.contentLabel.text = @"请选择分类";
                
                
                return cell;
                

                
            }
            
        }
            break;
            
        default:{
            BusinessPublishProjectThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
            
            if (indexPath.section == 3) {

                
            }else if (indexPath.section == 4) {
                
                cell.titleLabel.text = @"项目成员介绍";

            }else if (indexPath.section == 5) {
                
                cell.titleLabel.text = @"项目背景面临问题及需求";
                


            }else if (indexPath.section == 6) {
                
                cell.titleLabel.text = @"项目实施计划和预期进展";
                
            }

            return cell;

        }
            
            break;
    }
    
    
    
    
}
#pragma mark - 确认提交按钮响应方法
- (void)commitAction{
    
    [CommonUtils showToastWithStr:@"确认提交"];
    /*
     owner_id         int        必需  发布者序号
     title            string     必需  项目名称
     thumbUrl         string     必需 项目封面图  图片上传请调用跳蚤市场上传照片接口
     budget           string     必需 项目预算
     field            string     必需 项目领域
     description      string     必需 项目简介
     member           string     必需 项目成员介绍
     background       string     必需 项目背景
     plan             string     必需 项目实施计划
     master_name      string     必需 负责人姓名
     idcard          string     必需  负责人身份证号
     telphone        string     必需  联系电话
     college         string     必需  学校
     major           string     必需 专业
     education       string     必需 学历
     graduationtime  string     必需 毕业时间
     */
    /*
    if (publishJobMarketModel.publicJobMarketTitle.length<=0) {
        [CommonUtils showToastWithStr:@"请输入"];
        return;
    }
    
#warning 添加照片逻辑没处理
    //    else if (publishJobMarketModel.publicJobMarketImages.length<=0){
    //        [CommonUtils showToastWithStr:@"请添加照片"];
    //        return;
    //    }
    else if (publishJobMarketModel.publicJobMarketCategoryId.length<=0){
        [CommonUtils showToastWithStr:@"请选择分类"];
        return;
    }
    else if (publishJobMarketModel.publicJobMarketSalePrice.length<=0){
        [CommonUtils showToastWithStr:@"请输入价格"];
        return;
    }
    else if (publishJobMarketModel.publicJobMarketOriginPrice.length<=0){
        [CommonUtils showToastWithStr:@"请输入原价"];
        return;
    }
    else if (publishJobMarketModel.publicJobMarketCollegeId.length<=0){
        [CommonUtils showToastWithStr:@"请选择学校"];
        return;
    }else if (publishJobMarketModel.publicJobMarketTelephone.length<=0){
        [CommonUtils showToastWithStr:@"请输入联系方式"];
        return;
    }else if (publishJobMarketModel.publicJobMarketDescription.length<=0){
        [CommonUtils showToastWithStr:@"请添加描述"];
        return;
    }
    */
    /*
     
     master_name      string     必需 负责人姓名
     idcard          string     必需  负责人身份证号
     telphone        string     必需  联系电话
     college         string     必需  学校
     major           string     必需 专业
     education       string     必需 学历
     graduationtime  string     必需 毕业时间
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectTitle forKey:@"title"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectImage forKey:@"thumbUrl"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailBudge forKey:@"budget"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailField  forKey:@"field"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailDescription forKey:@"description"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailMember forKey:@"member"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailBackground forKey:@"background"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailPlan forKey:@"plan"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectRealName forKey:@"master_name"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectIdentityCard forKey:@"idcard"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectTelephone forKey:@"telphone"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectCollege forKey:@"college"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectMajor forKey:@"major"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectJob forKey:@"education"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectGraduationtime forKey:@"graduationtime"];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]jobMarketSubmitWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"发布跳蚤市场成功"];
            
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
