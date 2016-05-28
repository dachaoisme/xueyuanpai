//
//  RecruitmentDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RecruitmentDetailViewController.h"

#import "UniversityAssnHeaderView.h"
#import "RecruitmentOneStyleTableViewCell.h"
#import "RecruitmentTwoStyleTableViewCell.h"
#import "RecruitmentThreeStyleTableViewCell.h"

@interface RecruitmentDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation RecruitmentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"职位详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建返回按钮
    [self createLeftBackNavBtn];
    
    //创建头的显示样式
    [self createHeadView];
    
    //创建显示内容的tableView
    [self createTableView];
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentOneStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecruitmentThreeStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"threeCell"];
    
    
}

#pragma mark - 创建头部视图样式
- (void)createHeadView{
    NSArray *arrar = [NSArray arrayWithObjects:@"职位信息",@"公司信息", nil];
    UniversityAssnHeaderView *headerView = [[UniversityAssnHeaderView alloc]initWithFrame:CGRectMake(self.view.center.x - 70, 64, 140, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.type = PiecewiseInterfaceTypeMobileLin;
    //    headerView.delegate = self;
    headerView.textFont = [UIFont systemFontOfSize:14];
    headerView.textNormalColor = [UIColor blackColor];
    headerView.textSeletedColor = [CommonUtils colorWithHex:@"00BEAF"];
    headerView.linColor = [CommonUtils colorWithHex:@"00BEAF"];
    [headerView loadTitleArray:arrar];
    [self.view addSubview:headerView];
    
    
}

#pragma mark - 创建显示内容的tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            RecruitmentOneStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:{
            RecruitmentTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            return cell;
        }
            break;
            
        case 2:{
             RecruitmentThreeStyleTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            return cell;
        }
            break;

            
            

            
        default:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
            }
            return cell;

        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 200;
            break;
        case 1:
            return 100;
            break;

        case 2:
            return 50;
            break;
            
        default:
            return 100;
            break;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    grayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    return grayView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
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
