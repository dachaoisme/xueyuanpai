//
//  JMXianXiaCourseDetailsViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMXianXiaCourseDetailsViewController.h"

#import "JMCourseDetailTwoTableViewCell.h"
#import "JMXianXiaCourseDetailsTableViewCell.h"
#import "JMCourseDetailOneTableViewCell.h"

@interface JMXianXiaCourseDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView *tableView;



@end

@implementation JMXianXiaCourseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///创业课程详情【线下】
    self.title = @"创业课程详情";
    
    [self createLeftBackNavBtn];
    //创建当前列表视图
    [self createTableView];
    
    //创建底部视图
    [self createBottomView];
    

}


#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[JMCourseDetailOneTableViewCell class] forCellReuseIdentifier:@"JMCourseDetailOneTableViewCell"];
    [_tableView registerClass:[JMCourseDetailTwoTableViewCell class] forCellReuseIdentifier:@"JMCourseDetailTwoTableViewCell"];
    [_tableView registerClass:[JMXianXiaCourseDetailsTableViewCell class] forCellReuseIdentifier:@"JMXianXiaCourseDetailsTableViewCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;

            break;
        case 1:
            return 3;
            
            break;

            
        default:
            
            return 3;
            
            break;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 0:{
            JMCourseDetailTwoTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"JMCourseDetailTwoTableViewCell"];
            
            return detailCell;
        }
            break;
        case 1:{
            
            if (indexPath.row == 0) {
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = [CommonUtils colorWithHex:@"999999"];
                cell.textLabel.text = @"主讲人";
                return cell;
                
            }else{
                
                JMXianXiaCourseDetailsTableViewCell *xianXiaCell = [tableView dequeueReusableCellWithIdentifier:@"JMXianXiaCourseDetailsTableViewCell"];
                
                return xianXiaCell;
                
            }
            
        }
            break;
            
        default:{
            
            if (indexPath.row == 0) {
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = [CommonUtils colorWithHex:@"999999"];
                cell.textLabel.text = @"课程描述";
                return cell;
                
            }else if (indexPath.row == 1){
                JMCourseDetailOneTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"JMCourseDetailOneTableViewCell"];
                
                return imageCell;
                

                
            }else{
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = [CommonUtils colorWithHex:@"333333"];
                cell.textLabel.text = @"CSS 规则由两个主要的部分构成：选择器，以及一条或多条声明。selector {declaration1; declaration2; ... declarationN }选择器通常是您需要改变样式的 HTML 元素。每条声明由一个属性和一个值组成。属性（property）是您希望设置的样式属性（style attribute）。每个属性有一个值。属性和值被冒号分开。selector {property: value}下面这行代码的作用是将 h1 元素内的文字颜色定义为红色，同时将字体大小设置为 14 像素。在这个例子中，h1 是选择器，color 和 font-size 是属性，red 和 14px 是值。h1 {color:red; font-size:14px;}";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.numberOfLines = 0;
                return cell;
                
            }
            



        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 230;
            break;
        case 1:{
            
            if (indexPath.row == 0) {
                return 40;

            }else{
                
                return 55;

            }
        }
            break;
        default:{
            
            if (indexPath.row == 0) {
                return 40;
                
            }else if (indexPath.row == 1){
                
                return 220;
                
            }else{
                
                NSString *text = @"CSS 规则由两个主要的部分构成：选择器，以及一条或多条声明。selector {declaration1; declaration2; ... declarationN }选择器通常是您需要改变样式的 HTML 元素。每条声明由一个属性和一个值组成。属性（property）是您希望设置的样式属性（style attribute）。每个属性有一个值。属性和值被冒号分开。selector {property: value}下面这行代码的作用是将 h1 元素内的文字颜色定义为红色，同时将字体大小设置为 14 像素。在这个例子中，h1 是选择器，color 和 font-size 是属性，red 和 14px 是值。h1 {color:red; font-size:14px;}";
                
                return [self textHeight:text] + 30;

                
            }
        }
            
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}


//自适应撑高
//计算字符串的frame
- (CGFloat)textHeight:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 10, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    //返回计算好的高度
    return rect.size.height;
    
}




#pragma mark - 创建底部视图
- (void)createBottomView{
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    [self.view addSubview:bottomView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [CommonUtils colorWithHex:@"cccccc"];
    [bottomView addSubview:lineView];
    
    
    
    //创建左侧点赞按钮
    UIButton *zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zanBtn setImage:[UIImage imageNamed:@"detail_icon_like"] forState:UIControlStateNormal];
    [zanBtn setImage:[UIImage imageNamed:@"zan_hl"] forState:UIControlStateSelected];
    [zanBtn setTitle:@"收藏 3" forState:UIControlStateNormal];
    zanBtn.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    zanBtn.layer.cornerRadius = 4;
    zanBtn.layer.masksToBounds = YES;
    zanBtn.frame = CGRectMake(10, 10, 75, 30);
    zanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [zanBtn setTitleColor:[CommonUtils colorWithHex:@"35373a"] forState:UIControlStateNormal];
    [zanBtn addTarget:self action:@selector(zanAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:zanBtn];
    
    CGFloat interval = (SCREEN_WIDTH - 20 - 75*2 - 108)/2;
    
    //中间的报名按钮
    UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionBtn setImage:[UIImage imageNamed:@"detail_icon_join"] forState:UIControlStateNormal];
    collectionBtn.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    collectionBtn.layer.cornerRadius = 4;
    collectionBtn.layer.masksToBounds = YES;
    collectionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    collectionBtn.frame = CGRectMake(CGRectGetMaxX(zanBtn.frame) + interval, 10, 108, 30);
    [collectionBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:collectionBtn];
    
    
    //右侧评论按钮
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setImage:[UIImage imageNamed:@"detail_icon_chat"] forState:UIControlStateNormal];
    [commentBtn setTitle:@"5" forState:UIControlStateNormal];
    commentBtn.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    commentBtn.layer.cornerRadius = 4;
    commentBtn.layer.masksToBounds = YES;
    commentBtn.frame = CGRectMake(CGRectGetMaxX(collectionBtn.frame) + interval, 10, 75, 30);
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [commentBtn setTitleColor:[CommonUtils colorWithHex:@"35373a"] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:commentBtn];
    
    
    
    
}

#pragma mark - 点赞
- (void)zanAction{
    
    [CommonUtils showToastWithStr:@"点赞"];
    
}

- (void)collectionAction{
    
    //线上：此功能就为收藏功能
    [CommonUtils showToastWithStr:@"收藏"];
    
}


- (void)commentAction{
    
    [CommonUtils showToastWithStr:@"评论"];
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
