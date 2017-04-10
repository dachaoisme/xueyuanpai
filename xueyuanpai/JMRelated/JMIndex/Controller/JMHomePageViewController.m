//
//  JMHomePageViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/9.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMHomePageViewController.h"

#import "BulkGoodsLunBoView.h"
#import "JMHomePageOneTypeCellTableViewCell.h"
#import "JMHomePageTwoTypeTableViewCell.h"
#import "JMHomePageThreeTypeTableViewCell.h"

@interface JMHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,JMHomePageOneTypeCellTableViewCellDelegate,JMHomePageTwoTypeTableViewCellDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    
    
    //创建当前列表视图
    [self createTableView];
    
    [self requestBanner];
}
-(void)requestBanner
{
    [[HttpClient sharedInstance]getBannerOfIndexWithParams:[NSDictionary dictionary] withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        
    } withFaileBlock:^(NSError *error) {
        
    }];
}


#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_TOP_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    

    //注册cell
    [_tableView registerClass:[JMHomePageOneTypeCellTableViewCell class] forCellReuseIdentifier:@"JMHomePageOneTypeCellTableViewCell"];
    
    [_tableView registerClass:[JMHomePageTwoTypeTableViewCell class] forCellReuseIdentifier:@"JMHomePageTwoTypeTableViewCell"];
    
    [_tableView registerClass:[JMHomePageThreeTypeTableViewCell class] forCellReuseIdentifier:@"JMHomePageThreeTypeTableViewCell"];
}


#pragma mark - 配置顶部的轮播视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        //获取轮播图片数组
        NSArray *imageUrlArray = @[[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"2.jpg"]];
        
        BulkGoodsLunBoView *bulkGoodsLunBoView = [[BulkGoodsLunBoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) animationDuration:0];
        bulkGoodsLunBoView.fetchContentViewAtIndex = ^NSURL *(NSInteger pageIndex){
            return imageUrlArray[pageIndex];
        };
        
        bulkGoodsLunBoView.totalPagesCount = ^NSInteger(void){
            return imageUrlArray.count;
        };
        
        
        return bulkGoodsLunBoView;

    }else{
        
        return nil;
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        
        return 3;

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        JMHomePageOneTypeCellTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"JMHomePageOneTypeCellTableViewCell"];
        oneCell.delegate = self;
        
        return oneCell;
    }else{
        
        if (indexPath.row == 0) {
            JMHomePageTwoTypeTableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"JMHomePageTwoTypeTableViewCell"];
            twoCell.delegate = self;
            return twoCell;
        }else{
            
            JMHomePageThreeTypeTableViewCell *threeCell = [tableView dequeueReusableCellWithIdentifier:@"JMHomePageThreeTypeTableViewCell"];
            
            return threeCell;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        return 120;
    }else{
        
        if (indexPath.row == 0) {
           
            return 45;

        }else{
            
            return 100;
        }
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 10;
    }else{
        
        return 0.01;

    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 160;

    }else{
        
        return 0.01;
    }
    
}


#pragma mark - 集梦空间
- (void)tapDreamSpaceAction{
    
    [CommonUtils showToastWithStr:@"集梦空间"];
    
}


#pragma mark - 集梦创客
- (void)tapDreamGuestAction{
    
    [CommonUtils showToastWithStr:@"集梦创客"];

}


#pragma mark - 查看更多
- (void)seeMoreProjectAction{
    
    [CommonUtils showToastWithStr:@"查看更多"];
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
