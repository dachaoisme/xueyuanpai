//
//  SchoolRecruitmentViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/24.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SchoolRecruitmentViewController.h"
#import "SchoolShufflingView.h"

#import "SchoolColumnView.h"
#import "IndexBannerModel.h"

#import "SchoolRecruitmentTableViewCell.h"
#import "RecruitmentDetailViewController.h"

#import "SchoolRecruitmentModel.h"

#import "EmploymentRecruitmentViewController.h"
#import "PositionSearchViewController.h"

@interface SchoolRecruitmentViewController ()<UITableViewDataSource,UITableViewDelegate,SchoolShufflingViewDelegate>

{
    NSMutableArray * bannerImageArray;
    NSMutableArray * bannerItemArray;
    NSMutableArray * columnItemArray;
    NSMutableArray * schoolRecruitmentListArray;
}

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation SchoolRecruitmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"校园招聘";
    bannerImageArray = [NSMutableArray array];
    bannerItemArray  = [NSMutableArray array];
    columnItemArray  = [NSMutableArray array];
    schoolRecruitmentListArray = [NSMutableArray array];
    //设置左侧返回按钮
    [self createLeftBackNavBtn];
    
    //设置右侧按钮
    [self creatRightNavWithImageName:@"nav_icon_search"];
    
    //隐藏选项框栏
    [self theTabBarHidden:YES];
    
    //设置tableView
    [self createTableView];
    
    [self requestBannerData];
    [self requestColumnsData];
    [self requestListData];
}

#pragma mark - 右侧导航栏按钮响应方法
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    
    //跳转职位搜索界面
    PositionSearchViewController *searchVC = [[PositionSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}


#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //注册cell
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolRecruitmentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SchoolRecruitmentTableViewCell1"];
    
    [tableView registerClass:[SchoolRecruitmentTableViewCell class] forCellReuseIdentifier:@"SchoolRecruitmentCell"];
    
}

//校园招聘轮播图
-(void)requestBannerData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:@"10" forKey:@"size"];
    [dic setObject:@"3" forKey:@"type"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance]getBannerOfIndexWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *listDic) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            for (NSDictionary * dic in [listDic objectForKey:@"lists"] ) {
                
                IndexBannerModel * model = [[IndexBannerModel alloc]initWithDic:dic];
                [bannerItemArray addObject:model];
                [bannerImageArray addObject:model.IndexBannerPicUrl];
                //[bannerImageArray addObject:@"http://imgk.zol.com.cn/samsung/4600/a4599073_s.jpg"];

            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        [self.tableView reloadData];
        //[self requestColumnsData];
        
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

//校园招聘栏目分类
-(void)requestColumnsData
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]getColumnsOfSchoolRecruitmentWithParams:nil withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            for (NSDictionary * dic in [ListDic objectForKey:@"lists"] ) {
                
                IndexColumnsModel * model = [[IndexColumnsModel alloc]initWithDic:dic];
                [columnItemArray addObject:model];
            }
            
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    
}
//校园招聘列表list
-(void)requestListData
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:@"10" forKey:@"size"];
    [[HttpClient sharedInstance]getListOfSchoolRecruitmentWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            
            for (NSDictionary * dic in [ListDic objectForKey:@"lists"] ) {
                
                SchoolRecruitmentModel * model = [[SchoolRecruitmentModel alloc]initWithDic:dic];
                [schoolRecruitmentListArray addObject:model];
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
}
#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return schoolRecruitmentListArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolRecruitmentCell"];
        
        cell.textLabel.text = @"最新职位";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor grayColor];
        return cell;
    }else{
        SchoolRecruitmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchoolRecruitmentTableViewCell1" forIndexPath:indexPath];
        [cell setContentViewWithModel:[schoolRecruitmentListArray objectAtIndex:indexPath.row-1]];
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 20;
    }else{
        return 100;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    //初始化一个背景的UIView
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 180)];
    
    
    //初始化轮播图
    SchoolShufflingView *schoolShufflingView = [[SchoolShufflingView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100)];
    
    [backGroundView addSubview:schoolShufflingView];
    
//    schoolShufflingView.backgroundColor = [UIColor whiteColor];
    
    schoolShufflingView.delegate = self;
    
    schoolShufflingView.imageArray = bannerImageArray;


    
    UIView *showColumView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, [[UIScreen mainScreen] bounds].size.width, 90)];
    showColumView.backgroundColor = [UIColor whiteColor];
    [backGroundView addSubview:showColumView];

    
    
    //初始化三个按钮
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 70*3)/4;
    SchoolColumnView *columnView1 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width, 10, 80, 100)];
    columnView1.columnImageView.image = [UIImage imageNamed:@"hire_icon_job"];
    columnView1.columnTitileLable.text = @"就业招聘";
    [showColumView addSubview:columnView1];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action:)];
    [columnView1 addGestureRecognizer:tap1];

    
    

    
    SchoolColumnView *columnView2 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*2 + 80, 10, 80, 100)];
    columnView2.columnImageView.image = [UIImage imageNamed:@"hire_icon_intern"];
    columnView2.columnTitileLable.text = @"实习招聘";
    columnView2.tag = 101;
    [showColumView addSubview:columnView2];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action:)];
    [columnView2 addGestureRecognizer:tap2];

    
    
    SchoolColumnView *columnView3 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*3 + 80*2, 10, 80, 100)];
    columnView3.columnImageView.image = [UIImage imageNamed:@"hire_icon_partime"];
    columnView3.columnTitileLable.text = @"兼职招聘";
    columnView3.tag = 102;
    [showColumView addSubview:columnView3];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3Action:)];
    [columnView3 addGestureRecognizer:tap3];


    
    return backGroundView;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 260;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if (indexPath.row > 0) {
        SchoolRecruitmentModel * model =  [schoolRecruitmentListArray objectAtIndex:indexPath.row-1];
        RecruitmentDetailViewController *recruitmentVC = [[RecruitmentDetailViewController alloc] init];
        recruitmentVC.jobId = model.schoolRecruitmentId;
        [self.navigationController pushViewController:recruitmentVC animated:YES];
    }
    
}

#pragma mark - 点击banner图
-(void)selectedImageIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld张图片",(long)index+1);
}

#pragma mark - 轮播图下方三个小按钮点击响应的方法
-(void) tap1Action:(UITapGestureRecognizer*) tap {
        
    
    EmploymentRecruitmentViewController *employmentVC = [[EmploymentRecruitmentViewController alloc] init];
    employmentVC.type = SchoolRecruitmentTypeJiuYe;
    employmentVC.title = @"就业招聘";
    [self.navigationController pushViewController:employmentVC animated:YES];

}
-(void) tap2Action:(UITapGestureRecognizer*) tap {
    
    EmploymentRecruitmentViewController *employmentVC = [[EmploymentRecruitmentViewController alloc] init];
    employmentVC.type = SchoolRecruitmentTypeShiXi;
    employmentVC.title = @"实习招聘";
    [self.navigationController pushViewController:employmentVC animated:YES];
    
}
-(void) tap3Action:(UITapGestureRecognizer*) tap {
    
    EmploymentRecruitmentViewController *employmentVC = [[EmploymentRecruitmentViewController alloc] init];
    employmentVC.type = SchoolRecruitmentTypeJianZhi;
    employmentVC.title = @"兼职招聘";
    [self.navigationController pushViewController:employmentVC animated:YES];
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
