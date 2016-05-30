//
//  PositionInforViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "PositionInforViewController.h"

#import "PositionInforTableViewCell.h"
#import "PositionTwoTableViewCell.h"
#import "PositionInforThreeTableViewCell.h"
#import "PositionInforFourTableViewCell.h"
@interface PositionInforViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PositionInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //创建显示内容的tableView
    [self createTableView];
    
        
}


#pragma mark - 创建显示内容的tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114) style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"PositionInforTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"PositionTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    [tableView registerNib:[UINib nibWithNibName:@"PositionInforThreeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"threeCell"];
    [tableView registerNib:[UINib nibWithNibName:@"PositionInforFourTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"fourCell"];
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            PositionInforTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //设置数据
            [cell bindModel:self.model];

            return cell;
        }
            break;
        case 1:{
            PositionTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //设置数据
            [cell bindModel:self.model];

            
            return cell;
        }
            break;
            
        case 2:{
            PositionInforThreeTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            //设置工作描述数据
            [cell bindModel:self.model];
            
            
            return cell;
        }
            break;
            
            
        case 3:{
            PositionInforFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fourCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            [cell bindModel:self.model];
            
            cell.alertLabel.textColor = [CommonUtils colorWithHex:@"00beaf"];
            
            
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
            return 70;
            break;
        case 1:
            return 200;
            break;
            
        case 2:
            return 100;
            break;
        
            
        default:
            return 100;
            break;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        
        //调取拨打电话界面
        NSString *telephoneStr = [self.model.schoolRecruitmentDetailTelphone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * urlStr = [NSString stringWithFormat:@"tel:%@",telephoneStr];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
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
