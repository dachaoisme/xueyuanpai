//
//  BusinessCenterViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessCenterViewController.h"

#import "SchoolColumnView.h"

#import "BusinessCenterOneStyleTableViewCell.h"
#import "BusinessCenterTableViewCell.h"

#import "BusinessNewsViewController.h"
#import "BusinessGameViewController.h"
#import "BusinessClassRoomViewController.h"
#import "BusinessProjectViewController.h"

#import "BusinessTeacherDetailViewController.h"
#import "BusinessProjectDetailViewController.h"

#import "BusinessPublishProjectViewController.h"

#import "BusinessTeacherViewController.h"

#import "BussinessProjectTeacherDetailViewController.h"

#import "LoginViewController.h"


#import "OTPageScrollView.h"
#import "OTPageView.h"




@interface BusinessCenterViewController ()<UITableViewDelegate,UITableViewDataSource,OTPageScrollViewDataSource,OTPageScrollViewDelegate>

{
    NSMutableArray * tutorStarModelListArr;
    NSMutableArray * businessProjectModelListArr;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation BusinessCenterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self theTabBarHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"创业中心"];
    tutorStarModelListArr = [NSMutableArray array];
    businessProjectModelListArr = [NSMutableArray array];
    //创建导航栏右侧按钮
    [self creatRightNavWithTitle:@"发布项目"];
    
    
    //创建tableView
    [self createTableView];
    [self requestToGetBusinessTeachersList];
    [self requestToGetBusinessProgectList];
}

#pragma mark - 导航栏右侧按钮的响应方法
-(void)rightItemActionWithBtn:(UIButton *)sender
{
   
    BusinessPublishProjectViewController *publishProjectVC = [[BusinessPublishProjectViewController alloc] init];
    
    [self.navigationController pushViewController:publishProjectVC animated:YES];
}




#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //注册cell
    
    
    [tableView registerClass:[BusinessCenterOneStyleTableViewCell class] forCellReuseIdentifier:@"oneCell"];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"twoCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"BusinessCenterTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
    //创建tableView的headerView
    [self createHeaderView];
    
}

#pragma mark - 创建tabview的headerView
- (void)createHeaderView{
    UIView *showColumView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 90)];
    showColumView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = showColumView;
    
    //初始化三个按钮
    CGFloat width = (SCREEN_WIDTH - 50*4)/5;
    SchoolColumnView *columnView1 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width, 10, 50, 100)];
    columnView1.columnImageView.image = [UIImage imageNamed:@"startup_icon_news"];
    columnView1.columnTitileLable.text = @"创业新闻";
    [showColumView addSubview:columnView1];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action:)];
    [columnView1 addGestureRecognizer:tap1];
    
    
    
    SchoolColumnView *columnView2 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*2 + 50, 10, 50, 100)];
    columnView2.columnImageView.image = [UIImage imageNamed:@"startup_icon_contest"];
    columnView2.columnTitileLable.text = @"创业大赛";
    columnView2.tag = 101;
    [showColumView addSubview:columnView2];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action:)];
    [columnView2 addGestureRecognizer:tap2];
    
    
    
    SchoolColumnView *columnView3 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*3 + 50*2, 10, 50, 100)];
    columnView3.columnImageView.image = [UIImage imageNamed:@"startup_icon_lecture"];
    columnView3.columnTitileLable.text = @"创业讲堂";
    columnView3.tag = 102;
    [showColumView addSubview:columnView3];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3Action:)];
    [columnView3 addGestureRecognizer:tap3];
    
    
    SchoolColumnView *columnView4 = [[SchoolColumnView alloc] initWithFrame:CGRectMake(width*4 + 50*3, 10, 50, 100)];
    columnView4.columnImageView.image = [UIImage imageNamed:@"startup_icon_project"];
    columnView4.columnTitileLable.text = @"创业项目";
    columnView4.tag = 102;
    [showColumView addSubview:columnView4];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap4Action:)];
    [columnView4 addGestureRecognizer:tap4];

}

#pragma mark - 轮播图下方三个小按钮点击响应的方法
-(void) tap1Action:(UITapGestureRecognizer*) tap {
    
    //    [CommonUtils showToastWithStr:@"创业新闻"];
    
    BusinessNewsViewController *newsVC = [[BusinessNewsViewController alloc] init];
    
    [self.navigationController pushViewController:newsVC animated:YES];
    
}
-(void) tap2Action:(UITapGestureRecognizer*) tap {
    
    //    [CommonUtils showToastWithStr:@"创业大赛"];
    
    BusinessGameViewController *gameVC = [[BusinessGameViewController alloc] init];
    
    
    [self.navigationController pushViewController:gameVC animated:YES];
    
}
-(void) tap3Action:(UITapGestureRecognizer*) tap {
    
    //    [CommonUtils showToastWithStr:@"创业讲堂"];
    
    
    BusinessClassRoomViewController *classVC = [[BusinessClassRoomViewController alloc] init];
    
    
    [self.navigationController pushViewController:classVC animated:YES];
    
}

-(void) tap4Action:(UITapGestureRecognizer*) tap {
    
    //    [CommonUtils showToastWithStr:@"创业项目"];
    
    BusinessProjectViewController *projectVC = [[BusinessProjectViewController alloc] init];
    
    [self.navigationController pushViewController:projectVC animated:YES];
    
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }else  {
        return businessProjectModelListArr.count + 1;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        BusinessCenterOneStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if (indexPath.section == 0) {
            cell.titleLabel.text = @"明星导师";
 
        }else{
            
            cell.titleLabel.text = @"创业项目";

        }
        return cell;


    }else{
        
        if (indexPath.section == 0) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
            
            
            OTPageView *PScrollView = [[OTPageView alloc] initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, 170)];
            PScrollView.pageScrollView.dataSource = self;
            PScrollView.pageScrollView.delegate = self;
            //两个视图之间的间隔
            PScrollView.pageScrollView.padding = 30;
            PScrollView.pageScrollView.leftRightOffset = 0;
            //设置显示在屏幕中的位置
            PScrollView.pageScrollView.frame = CGRectMake(-10, 0, 150, 150);
            PScrollView.backgroundColor = [UIColor whiteColor];
            [PScrollView.pageScrollView reloadData];
            [cell.contentView addSubview:PScrollView];
            
            
            return cell;

            
        }else{
            
            BusinessCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            BusinessCenterProgectModel * model = [businessProjectModelListArr objectAtIndex:indexPath.row - 1];
            
            [cell.showImageView sd_setImageWithURL:[NSURL URLWithString:model.businessCenterProgectImage] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
            
            cell.titleLabel.text = model.businessCenterProgectTitle;
            cell.contentLabel.text = model.businessCenterProgectBrief;
            
            
            return cell;

            
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            if (indexPath.row == 0) {
                
                return 45;
            }else{
                return 170;

            }
            
        }
            break;
        case 1:{
            
            if (indexPath.row == 0) {
                
                return 45;
            }else{
                return 115;
                
            }

        }
            break;

            
        default:
            
            return 49;
            break;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if (indexPath.section == 0 && indexPath.row == 0){
        
        //跳转创业导师页面
        BusinessTeacherViewController *teacherVC = [[BusinessTeacherViewController alloc] init];
        
        [self.navigationController pushViewController:teacherVC animated:YES];
        
        
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        BusinessProjectViewController *projectVC = [[BusinessProjectViewController alloc] init];
        [self.navigationController pushViewController:projectVC animated:YES];

        
    }else if (indexPath.section == 1 && indexPath.row > 0) {
        
        //根据不同的身份跳转不同的详情
        if ([UserAccountManager sharedInstance].userRole == UserInfoRoleTeacher) {
            //跳转导师项目详情
            BussinessProjectTeacherDetailViewController *projectVC = [[BussinessProjectTeacherDetailViewController alloc] init];
            BusinessCenterProgectModel * businessCenterProgectModel = [businessProjectModelListArr objectAtIndex:indexPath.row -1];
            projectVC.projectId = businessCenterProgectModel.businessCenterProgectId;
            [self.navigationController pushViewController:projectVC animated:YES];
            
        }else{
            
            //跳转项目详情
            BusinessProjectDetailViewController *projectVC = [[BusinessProjectDetailViewController alloc] init];
            BusinessCenterProgectModel * businessCenterProgectModel = [businessProjectModelListArr objectAtIndex:indexPath.row -1];
            projectVC.projectId = businessCenterProgectModel.businessCenterProgectId;
            [self.navigationController pushViewController:projectVC animated:YES];
            
            
        }
        
        
    }
    

}

#pragma mark - 请求数据
///创业导师
-(void)requestToGetBusinessTeachersList
{
    int pageNo = 1;
    int pageSize = 10;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageNo] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterGetTeachersListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                BusinessCenterTutorModel * model = [[BusinessCenterTutorModel alloc]initWithDic:smallDic];
                [tutorStarModelListArr  addObject:model];
            }
            
            [self.tableView reloadData];
        }else{
            
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

///创业项目
-(void)requestToGetBusinessProgectList
{
    /*
     page        int     非必需    第几页        默认1
     size        int     非必需    每页多少条     默认10
     keyword     string  非必需    关键字
     category_id  int    非必需    分类序号      默认全部
     sort         int    非必需    排序          默认1  1最新发布 2点击最多 3申领最多 （客户端组装排序文字）
     
     */
    int pageNo = 1;
    int pageSize = 10;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageNo] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    //[dic setValue:keyword forKey:@"keyword"];
    //[dic setValue:categoryParam forKey:@"cat_id"];
    //[dic setValue:sortParam  forKey:@"sort"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterGetProgectListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            for (NSDictionary * smallDic in arr) {
                BusinessCenterProgectModel * model = [[BusinessCenterProgectModel alloc]initWithDic:smallDic];
                [businessProjectModelListArr  addObject:model];
            }
            [self.tableView reloadData];
        }else{
            
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}


#pragma mark - 导师滚动视图
- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView{
    return tutorStarModelListArr.count;
}

- (UIView*)pageScrollView:(OTPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 100, 150)];
    cell.backgroundColor = [UIColor whiteColor];
    ;
    
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [cell addSubview:headImageView];
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 102, 52, 21)];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textAlignment = NSTextAlignmentRight;
    [cell addSubview:nameLabel];
    
    
    UIImageView *makeSureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(57, 107, 12, 12)];
    makeSureImageView.image = [UIImage imageNamed:@"startup_vip"];
    [cell addSubview:makeSureImageView];
    
    
    
    UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 121, 84, 21)];
    introduceLabel.textColor = [UIColor lightGrayColor];
    introduceLabel.font = [UIFont systemFontOfSize:14];
    introduceLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:introduceLabel];
    
    
    
    BusinessCenterTutorModel * model = [tutorStarModelListArr objectAtIndex:index];

    [headImageView sd_setImageWithURL:[NSURL URLWithString:model.businessCenterTutorImage ] placeholderImage:[UIImage imageNamed:@"test.jpg"]];


    nameLabel.text = model.businessCenterTutorUserName;

   introduceLabel.text = model.businessCenterTutorJob;


    

    return cell;
    
    
    
    
}

- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView
{
    return CGSizeMake(100, 150);
}

- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
//    NSLog(@"click cell at %ld",index);
    
    //跳转导师详情
    BusinessCenterTutorModel * model = [tutorStarModelListArr objectAtIndex:index];
    BusinessTeacherDetailViewController *teacherVC = [[BusinessTeacherDetailViewController alloc] init];
    teacherVC.teacherId = model.businessCenterTutorId;
    [self.navigationController pushViewController:teacherVC animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    NSLog(@"click cell at %ld",index);
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
