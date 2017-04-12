//
//  JMSignUpTrainingProjectViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/12.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSignUpTrainingProjectViewController.h"

#import "JMSignUpOneTypeTableViewCell.h"
#import "JMSignUpTwoTypeTableViewCell.h"
#import "CommonTableViewCell.h"

@interface JMSignUpTrainingProjectViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMSignUpTrainingProjectViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"报名实训项目";
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //创建左侧按钮
    [self createLeftBackNavBtn];
    
    
    //创建当前列表视图
    [self createTableView];
    
    
    //创建底部确定按钮
    [self createBottomView];
    

    
    
}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[JMSignUpOneTypeTableViewCell class] forCellReuseIdentifier:@"JMSignUpOneTypeTableViewCell"];
    
    [_tableView registerClass:[JMSignUpTwoTypeTableViewCell class] forCellReuseIdentifier:@"JMSignUpTwoTypeTableViewCell"];
    
    [_tableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"CommonTableViewCell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 2;
        
    }else{
        
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            JMSignUpOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSignUpOneTypeTableViewCell"];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.leftTitleLabel.text = @"岗位";
            cell.rightContentLabel.text = @"请选择";
            return cell;
            
        }
            break;
        case 1:{
            
            JMSignUpTwoTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSignUpTwoTypeTableViewCell"];
            return cell;
            
        }
            break;
        case 2:{
            
            JMSignUpOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSignUpOneTypeTableViewCell"];
            
            cell.leftTitleLabel.text = @"个人形象照";
            cell.rightContentLabel.text = @"请上传";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
            
        }
            break;

            

            
        default:{
            
            CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"为什么要选你？";
            cell.rightLabel.text = @"50-500字";
            cell.textView.placehoderText = @"请陈诉入选的理由";
            cell.textView.delegate = self;
            cell.textView.returnKeyType = UIReturnKeyDone;

            
            return cell;
            
            

        }
            break;
    }
    
   
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        return 145;
    }else{
        
        return 48;
    }
    
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



#pragma mark - textView的代理方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
