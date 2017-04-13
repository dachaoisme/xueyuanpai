//
//  JMAddOrEditViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMAddOrEditViewController.h"

#import "AddOrEditOneTableViewCell.h"
#import "JMSignUpOneTypeTableViewCell.h"

@interface JMAddOrEditViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMAddOrEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
    [self createBottomView];
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"AddOrEditOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddOrEditOneTableViewCell"];
    
    
    //注册cell
    [tableView registerClass:[JMSignUpOneTypeTableViewCell class] forCellReuseIdentifier:@"JMSignUpOneTypeTableViewCell"];
    
}


#pragma mark - UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        AddOrEditOneTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"AddOrEditOneTableViewCell"];
        if (indexPath.row == 0) {
            
            cell.leftTitleLabel.text = @"姓名";
            
        }else{
            
            cell.leftTitleLabel.text = @"手机号";

        }
        
        return cell;

    }else{
        
        if (indexPath.row == 0) {
            
            JMSignUpOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSignUpOneTypeTableViewCell"];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.leftTitleLabel.text = @"省市";
            [cell.rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];
            
            return cell;
            
        }else{
            
            AddOrEditOneTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"AddOrEditOneTableViewCell"];
            
            cell.leftTitleLabel.text = @"详细地址";
            
            return cell;
        }
        
       

    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}



#pragma mark - 创建底部视图
- (void)createBottomView{
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 65, SCREEN_WIDTH, 65)];
    bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:bottomView];
    
    
    UIButton *makeSureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    makeSureButton.frame = CGRectMake(15, 5, SCREEN_WIDTH - 30, 48);
    makeSureButton.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    makeSureButton.layer.cornerRadius = 4;
    makeSureButton.layer.masksToBounds = YES;
    [makeSureButton setTitle:@"确定" forState:UIControlStateNormal];
    [makeSureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureButton addTarget:self action:@selector(makeSureAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:makeSureButton];
    
}

#pragma mark - 确定按钮的响应事件
- (void)makeSureAction{
    
    [CommonUtils showToastWithStr:@"确定"];
    
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
