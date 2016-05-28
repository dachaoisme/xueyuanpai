//
//  RequirementsViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RequirementsViewController.h"


#import "RequirementTableViewCell.h"

@interface RequirementsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation RequirementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"发布需求";
    [self createLeftBackNavBtn];
    
    //创建tableView
    [self createTableView];
    
    //创建tableView的headerView
    [self createHeaderView];
    
    
    //创建tableView的footView
    [self createFootView];
    
    
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"RequirementTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
    
   
}

- (void)createHeaderView{
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140)];
    backGroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    //头像图片
    UIImageView *showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - 50, 20, 80, 80)];
    [backGroundView addSubview:showImageView];
    showImageView.layer.masksToBounds = YES;
    showImageView.layer.cornerRadius = 40;
    showImageView.image = [UIImage imageNamed:@"avatar"];
    
    
    //lable提醒
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(showImageView.frame) - 80, CGRectGetMaxY(showImageView.frame), 320, 50)];
    alertLabel.text = @"在这里修改照片仅做时间银行使用,不会更改头像哦";
    alertLabel.font = [UIFont systemFontOfSize:12];
    [backGroundView addSubview:alertLabel];
    
    self.tableView.tableHeaderView = backGroundView;

    
}


- (void)createFootView{
    
    //发布按钮的创建
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 200, 40);
    [button setTitle:@"发布" forState:UIControlStateNormal];
    
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [button addTarget:self action:@selector(releaseAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = button;
}

#pragma mark - 发布按钮的响应方法
- (void)releaseAction{
    
    [CommonUtils showToastWithStr:@"发布"];
}
#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        default:
            return 1;
            break;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    


    RequirementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"标题";
                cell.contentLabel.text = @"明天早上八点，图书馆站位";
 
            }else{
                
                cell.titleLabel.text = @"类型";
                cell.contentLabel.text = @"占座";

            }
        }
            break;
            
        case 1:{
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"时间";
                cell.contentLabel.text = @"4月17日上午";
                
            }else if (indexPath.row == 1){
                
                cell.titleLabel.text = @"地点";
                cell.contentLabel.text = @"校园图书馆";
                
            }else{
                
                cell.titleLabel.text = @"需要人数";
                cell.contentLabel.text = @"1人";
            }
        }
            break;

        case 2:{
            
                cell.titleLabel.text = @"付款方式";
                cell.contentLabel.text = @"付小费";
            
        }
            break;
            
        case 3:{
            
            cell.titleLabel.text = @"描述详情";
            cell.contentLabel.text = @"希望找个人占座";
            
        }
            break;

            
        default:
            break;
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
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
