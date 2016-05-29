//
//  EmploymentRecruitmentViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "EmploymentRecruitmentViewController.h"

#import "EmploymentRecruitmentTableViewCell.h"
#import "SchoolRecruitmentModel.h"
#import "RecruitmentDetailViewController.h"
@interface EmploymentRecruitmentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * schoolRecruitmentListArray;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation EmploymentRecruitmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    schoolRecruitmentListArray = [NSMutableArray array];
    
//    self.title = @"就业招聘";
    [self requestListData];
    [self createLeftBackNavBtn];
    
    
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //注册cell

    [tableView registerNib:[UINib nibWithNibName:@"EmploymentRecruitmentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

//校园招聘列表list
-(void)requestListData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:@"10" forKey:@"size"];
    if (self.type == SchoolRecruitmentTypeJiuYe) {
        [dic setObject:@"1" forKey:@"type"];
    }else if (self.type == SchoolRecruitmentTypeShiXi){
        [dic setObject:@"2" forKey:@"type"];
    }else if (self.type == SchoolRecruitmentTypeJianZhi){
        [dic setObject:@"3" forKey:@"type"];
    }else if (self.type ==SchoolRecruitmentTypeCompanyPosition){
        [dic setObject:self.companyID?self.companyID:@"" forKey:@"company_id"];
    }else if (self.type == SchoolRecruitmentTypeCompanySearch){
        [dic addEntriesFromDictionary:self.companySearchDic];
    }
    
    [[HttpClient sharedInstance]getListOfSchoolRecruitmentWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            for (NSDictionary * dic in [ListDic objectForKey:@"lists"] ) {
                
                SchoolRecruitmentModel * model = [[SchoolRecruitmentModel alloc]initWithDic:dic];
                [schoolRecruitmentListArray addObject:model];
            }
            [self createTableView];
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return schoolRecruitmentListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EmploymentRecruitmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
   
    SchoolRecruitmentModel * model = [schoolRecruitmentListArray objectAtIndex:indexPath.row];
    [cell bindModel:model];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolRecruitmentModel * model =  [schoolRecruitmentListArray objectAtIndex:indexPath.row];
    RecruitmentDetailViewController *recruitmentVC = [[RecruitmentDetailViewController alloc] init];
    recruitmentVC.jobId = model.schoolRecruitmentId;
    [self.navigationController pushViewController:recruitmentVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
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
