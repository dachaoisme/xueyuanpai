//
//  JMHomePageEndProjectDetailViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/12.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMHomePageEndProjectDetailViewController.h"

#import "HomePageDetailOneTypeTableViewCell.h"
#import "HomePageDetailTwoTypeTableViewCell.h"
#import "HomePageEndProjectTableViewCell.h"


@interface JMHomePageEndProjectDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView *tableView;

@end



@implementation JMHomePageEndProjectDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"实训项目";
    
    [self createLeftBackNavBtn];
    
    //创建当前列表视图
    [self createTableView];

    
}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[HomePageDetailOneTypeTableViewCell class] forCellReuseIdentifier:@"HomePageDetailOneTypeTableViewCell"];
    
    [_tableView registerClass:[HomePageDetailTwoTypeTableViewCell class] forCellReuseIdentifier:@"HomePageDetailTwoTypeTableViewCell"];
    
    [_tableView registerClass:[HomePageEndProjectTableViewCell class] forCellReuseIdentifier:@"HomePageEndProjectTableViewCell"];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2) {
        return 3;
        
    }else{
        
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            HomePageDetailOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageDetailOneTypeTableViewCell"];
            
            
            return cell;
            
            
        }
            break;
        case 1:{
            HomePageDetailTwoTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageDetailTwoTypeTableViewCell"];
            
            return cell;
            
            
        }
            break;
        case 2:{
            
            if (indexPath.row == 0) {
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = [CommonUtils colorWithHex:@"999999"];
                cell.textLabel.text = @"项目成员";

                return cell;

            }else{
                
                HomePageEndProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageEndProjectTableViewCell"];
                
                return cell;

            }
            
        }
            break;

            
        default:
        {
            
            UITableViewCell *cell = nil;
            
            return cell;
            
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            return 45;
            
        }else{
           
            return 76;
        }
    }else{
        
        return 80;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
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
