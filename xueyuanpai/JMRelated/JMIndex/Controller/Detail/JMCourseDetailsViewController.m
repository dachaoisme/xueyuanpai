//
//  JMCourseDetailsViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCourseDetailsViewController.h"

#import "JMCourseDetailOneTableViewCell.h"

@interface JMCourseDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMCourseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///创业课程详情【线上】
    self.title = @"创业课程详情";
    
    [self createLeftBackNavBtn];
    //创建当前列表视图
    [self createTableView];
    
    
}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[JMCourseDetailOneTableViewCell class] forCellReuseIdentifier:@"JMCourseDetailOneTableViewCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [CommonUtils colorWithHex:@"3f4446"];

    
    
    switch (indexPath.row) {
        case 0:
        {
            
            cell.textLabel.text = @"CSS基础";
            cell.textLabel.font = [UIFont systemFontOfSize:21];
            
            return cell;

        }
            break;
        case 1:
        {
            
            cell.textLabel.text = @"2017-1-23 李林";
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            
            return cell;

        }
            break;
        case 2:
        {
            
            JMCourseDetailOneTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"JMCourseDetailOneTableViewCell"];
            
            return imageCell;
            
        }
            break;
            
        default:{
            
            cell.textLabel.text = @"CSS 规则由两个主要的部分构成：选择器，以及一条或多条声明。selector {declaration1; declaration2; ... declarationN }选择器通常是您需要改变样式的 HTML 元素。每条声明由一个属性和一个值组成。属性（property）是您希望设置的样式属性（style attribute）。每个属性有一个值。属性和值被冒号分开。selector {property: value}下面这行代码的作用是将 h1 元素内的文字颜色定义为红色，同时将字体大小设置为 14 像素。在这个例子中，h1 是选择器，color 和 font-size 是属性，red 和 14px 是值。h1 {color:red; font-size:14px;}";
            cell.textLabel.font = [UIFont systemFontOfSize:12];

        }
            return cell;
            
            
            break;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            return 50;
            break;
        case 1:
            return 30;
            break;
        case 2:
            return 220;
            break;

            
        default:{
            NSString *text = @"CSS 规则由两个主要的部分构成：选择器，以及一条或多条声明。selector {declaration1; declaration2; ... declarationN }选择器通常是您需要改变样式的 HTML 元素。每条声明由一个属性和一个值组成。属性（property）是您希望设置的样式属性（style attribute）。每个属性有一个值。属性和值被冒号分开。selector {property: value}下面这行代码的作用是将 h1 元素内的文字颜色定义为红色，同时将字体大小设置为 14 像素。在这个例子中，h1 是选择器，color 和 font-size 是属性，red 和 14px 是值。h1 {color:red; font-size:14px;}";
            
            return [self textHeight:text] + 30;
            
        }

            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}


//自适应撑高
//计算字符串的frame
- (CGFloat)textHeight:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 10, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    //返回计算好的高度
    return rect.size.height;
    
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
