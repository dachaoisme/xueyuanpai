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

#import "RecruitmentDetailsViewController.h"

@interface SchoolRecruitmentViewController ()<UITableViewDataSource,UITableViewDelegate,SchoolShufflingViewDelegate>

{
    NSMutableArray * bannerImageArray;

}

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation SchoolRecruitmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"校园招聘";
    bannerImageArray = [NSMutableArray array];

    
    //设置左侧返回按钮
    [self createLeftBackNavBtn];
    
    //隐藏选项框栏
    [self theTabBarHidden:YES];
    
    //设置tableView
    [self createTableView];
    
    [self requestBannerData];
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //注册cell
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolRecruitmentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SchoolRecruitmentTableViewCell1"];
    
    [tableView registerClass:[SchoolRecruitmentTableViewCell class] forCellReuseIdentifier:@"SchoolRecruitmentCell"];
    
}

//首页轮播图
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
//                [bannerItemArray addObject:model];
                [bannerImageArray addObject:[CommonUtils getEffectiveUrlWithUrl:model.IndexBannerPicUrl withType:2]];
            }
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        
        [self.tableView reloadData];
//        [self requestColumnsData];
        
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}


#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
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
    
    schoolShufflingView.backgroundColor = [UIColor redColor];
    
    schoolShufflingView.delegate = self;
    
//    if (bannerImageArray.count > 0) {
//            schoolShufflingView.imageArray = bannerImageArray;
//    }else{
    
#warning 测试的死数据，需要修改
    
        //仅用来测试布局用的
        NSString *path1 = @"http://imgk.zol.com.cn/samsung/4600/a4599073_s.jpg";
        NSString *path2 = @"http://www.qqpk.cn/Article/UploadFiles/201111/2011112212072571.jpg";
        NSArray *pathArray = [NSArray arrayWithObjects:path1,path2, nil];

        schoolShufflingView.imageArray = pathArray;

//    }


    
    UIView *showColumView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, [[UIScreen mainScreen] bounds].size.width, 90)];
    showColumView.backgroundColor = [UIColor whiteColor];
    [backGroundView addSubview:showColumView];

    
    
    //初始化三个按钮
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 80*3)/4;
    SchoolColumnView *columnView1 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width, 10, 80, 100)];
    columnView1.columnImageView.image = [UIImage imageNamed:@"home_icon_market"];
    columnView1.columnTitileLable.text = @"就业招聘";
    [showColumView addSubview:columnView1];
    
    SchoolColumnView *columnView2 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*2 + 80, 10, 80, 100)];
    columnView2.columnImageView.image = [UIImage imageNamed:@"home_icon_market"];
    columnView2.columnTitileLable.text = @"实习招聘";
    [showColumView addSubview:columnView2];
    
    
    SchoolColumnView *columnView3 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*3 + 80*2, 10, 80, 100)];
    columnView3.columnImageView.image = [UIImage imageNamed:@"home_icon_market"];
    columnView3.columnTitileLable.text = @"兼职招聘";
    [showColumView addSubview:columnView3];
    
    
    //需要添加灰色的UIView
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(columnView1.frame) - 30, [UIScreen mainScreen].bounds.size.width, 10)];
    grayView.backgroundColor = [CommonUtils colorWithHex:@"e5e5e5"];
    [showColumView addSubview:grayView];

    
    return backGroundView;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 260;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecruitmentDetailsViewController *recruitmentVC = [[RecruitmentDetailsViewController alloc] init];
    [self.navigationController pushViewController:recruitmentVC animated:YES];
}

#pragma mark - 点击banner图
-(void)selectedImageIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld张图片",(long)index+1);
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
