//
//  JMAddOrEditViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMAddOrEditViewController.h"

#import "JMSignUpTwoTypeTableViewCell.h"
#import "JMSignUpOneTypeTableViewCell.h"
#import "JMAreaModel.h"
#import "JMAreaListViewController.h"
@interface JMAddOrEditViewController ()<UITableViewDelegate,UITableViewDataSource,JMSignUpTwoTypeTableViewCellDelegate>
{
    JMAreaModel *areaModel;
    JMSubAreaModel *subAreaModel;
    NSString *telephone;
    NSString *detailedAddress;
    NSString *name;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMAddOrEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createLeftBackNavBtn];
    if (self.addressModel) {
        telephone = self.addressModel.telphone;
        detailedAddress = self.addressModel.addr;
        name = self.addressModel.user_name;
    }
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
//    [tableView registerNib:[UINib nibWithNibName:@"AddOrEditOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AddOrEditOneTableViewCell"];
    [tableView registerClass:[JMSignUpTwoTypeTableViewCell class] forCellReuseIdentifier:@"JMSignUpTwoTypeTableViewCell"];
    
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
        
        JMSignUpTwoTypeTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSignUpTwoTypeTableViewCell"];
        cell.delegate = self;
        if (indexPath.row == 0) {
            
            cell.leftTitleLabel.text = @"姓名";
            if (name.length>0) {
                cell.rightTextFeild.text = name;
            }
            
            cell.tag = 0;
            
        }else{
            
            cell.leftTitleLabel.text = @"手机号";
            if (telephone.length>0) {
                cell.rightTextFeild.text = telephone;
            }
            cell.tag = 1;
        }
        
        return cell;

    }else{
        
        if (indexPath.row == 0) {
            
            JMSignUpOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSignUpOneTypeTableViewCell"];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.leftTitleLabel.text = @"省市";
            if (areaModel) {
                if (subAreaModel) {
                    [cell.rightContentBtn setTitle:[NSString stringWithFormat:@"%@ %@",areaModel.name,subAreaModel.name] forState:UIControlStateNormal];
                    [cell.rightContentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }else{
                    [cell.rightContentBtn setTitle:areaModel.name forState:UIControlStateNormal];
                    [cell.rightContentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
               
            }else{
                [cell.rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];
            }
            
            
            return cell;
            
        }else{
            
            JMSignUpTwoTypeTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSignUpTwoTypeTableViewCell"];
            cell.delegate = self;
            cell.leftTitleLabel.text = @"详细地址";
            if (detailedAddress.length>0) {
                cell.rightTextFeild.text = detailedAddress;
            }
            cell.tag = 2;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    weakSelf(weakSelf);
    if (indexPath.section==1 &&indexPath.row==0) {
        JMAreaListViewController *areaListVC = [[JMAreaListViewController alloc]init];
        areaListVC.returnBlock = ^(JMAreaModel *returnAreaModel,NSInteger childrenIndex ) {
            areaModel = returnAreaModel;
            subAreaModel = [returnAreaModel.children objectAtIndex:childrenIndex];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:areaListVC animated:YES];
    }
    
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
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:telephone forKey:@"telphone"];
    [dic setValue:areaModel.areaId forKey:@"province"];
    [dic setValue:subAreaModel.areaId forKey:@"city"];
    [dic setValue:detailedAddress forKey:@"addr"];
    [dic setValue:name forKey:@"user_name"];
    if (self.addressModel && self.addressModel.address_id.length>0) {
        [dic setValue:self.addressModel.address_id forKey:@"address_id"];
    }
    [[HttpClient sharedInstance] addAdressWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        if (responseModel.responseCode ==ResponseCodeSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
        
    } withFaileBlock:^(NSError *error) {
        
    }];
}

-(void)inputEndWithText:(NSString *)text withRow:(NSInteger)row
{
    if (row==0) {
        //姓名
        name=text;
    }else if (row==1){
        ///手机号
        telephone = text;
    }else if (row==2){
        ///详细地址
        detailedAddress = text;
    }else{
        
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
