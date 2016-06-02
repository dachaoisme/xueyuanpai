//
//  BaoMingViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/2.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaoMingViewController.h"

#import "PublishInformationOneStyleTableViewCell.h"
#import "PublishInformationTwoStyleTableViewCell.h"

@interface BaoMingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaoMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"报名";
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    //设置tableView的footView
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tableView.tableFooterView = button;

    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"PublishInformationOneStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"PublishInformationTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
}

#pragma mark - 提交按钮的响应方法
- (void)commitAction{
    
    [CommonUtils showToastWithStr:@"提交"];
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        PublishInformationOneStyleTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        oneCell.titleLabel.text = @"你的姓名";
        oneCell.yuanLabel.hidden = YES;
        
        return oneCell;


        
    }else if(indexPath.row == 1){
        
        PublishInformationTwoStyleTableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        twoCell.titleLabel.text = @"学校";
        twoCell.contentLabel.text = @"吉林长春大学";
        
        return twoCell;
        

    }else{
        

        PublishInformationOneStyleTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        oneCell.titleLabel.text = @"专业";
        oneCell.yuanLabel.hidden = YES;
        
        return oneCell;


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
