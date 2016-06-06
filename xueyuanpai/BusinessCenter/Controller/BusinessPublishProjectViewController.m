//
//  BusinessPublishProjectViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BusinessPublishProjectViewController.h"

#import "BusinessPublishProjectOneTableViewCell.h"
#import "BusinessPublishProjectTwoTableViewCell.h"
#import "BusinessPublishProjectThreeTableViewCell.h"

@interface BusinessPublishProjectViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    BusinessCenterPublicProgectModel * publicProgectModel;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation BusinessPublishProjectViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self theTabBarHidden:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发布项目";
    publicProgectModel = [[BusinessCenterPublicProgectModel alloc]initWithDic:nil];
    [self createLeftBackNavBtn];
    
    
    
    //创建tableView
    [self createTableView];

}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //设置tableView的footView
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(publishAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.tableView.tableFooterView = button;

    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"BusinessPublishProjectOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"BusinessPublishProjectTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    [tableView registerNib:[UINib nibWithNibName:@"BusinessPublishProjectThreeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"threeCell"];
    

}

#pragma mark - 发布按钮
- (void)publishAction{
    
    [self.tableView reloadData];
    
    [CommonUtils showToastWithStr:@"确认提交"];
     if (publicProgectModel.businessCenterPublicProgectTitle.length<=0) {
         [CommonUtils showToastWithStr:@"请输入标题"];
         return;
     }
     #warning 添加照片逻辑没处理
//         else if (publicProgectModel.businessCenterPublicProgectImage.length<=0){
//             [CommonUtils showToastWithStr:@"请添加照片"];
//             return;
//         }
     else if (publicProgectModel.businessCenterPublicProgectDetailBudge.length<=0){
         [CommonUtils showToastWithStr:@"请添加预算"];
         return;
     }
//     else if (publicProgectModel.businessCenterPublicProgectDetailField.length<=0){
//         [CommonUtils showToastWithStr:@"请输入擅长领域"];
//         return;
//     }
     else if (publicProgectModel.businessCenterPublicProgectDetailDescription.length<=0){
         [CommonUtils showToastWithStr:@"请输入项目简介"];
         return;
     }
     else if (publicProgectModel.businessCenterPublicProgectDetailMember.length<=0){
         [CommonUtils showToastWithStr:@"请输入项目成员"];
         return;
     }else if (publicProgectModel.businessCenterPublicProgectDetailBackground.length<=0){
         [CommonUtils showToastWithStr:@"请输入项目背景"];
         return;
     }else if (publicProgectModel.businessCenterPublicProgectDetailPlan.length<=0){
         [CommonUtils showToastWithStr:@"请实施计划"];
         return;
     }
//     else if (publicProgectModel.businessCenterPublicProgectRealName.length<=0){
//         [CommonUtils showToastWithStr:@"请输入真实名字"];
//         return;
//     }else if (publicProgectModel.businessCenterPublicProgectIdentityCard.length<=0){
//         [CommonUtils showToastWithStr:@"请输入身份证号"];
//         return;
//     }else if (publicProgectModel.businessCenterPublicProgectTelephone.length<=0){
//         [CommonUtils showToastWithStr:@"请输入电话"];
//         return;
//     }else if (publicProgectModel.businessCenterPublicProgectCollege.length<=0){
//         [CommonUtils showToastWithStr:@"请输入学校"];
//         return;
//     }else if (publicProgectModel.businessCenterPublicProgectMajor.length<=0){
//         [CommonUtils showToastWithStr:@"请输入专业"];
//         return;
//     }else if (publicProgectModel.businessCenterPublicProgectJob.length<=0){
//         [CommonUtils showToastWithStr:@"请输入学历"];
//         return;
//     }else if (publicProgectModel.businessCenterPublicProgectGraduationtime.length<=0){
//         [CommonUtils showToastWithStr:@"请输入毕业时间"];
//         return;
//     }
    
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectTitle forKey:@"title"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectImage forKey:@"thumbUrl"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailBudge forKey:@"budget"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailField  forKey:@"field"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailDescription forKey:@"description"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailMember forKey:@"member"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailBackground forKey:@"background"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectDetailPlan forKey:@"plan"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectRealName forKey:@"master_name"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectIdentityCard forKey:@"idcard"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectTelephone forKey:@"telphone"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectCollege forKey:@"college"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectMajor forKey:@"major"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectJob forKey:@"education"];
    [dic setValue:publicProgectModel.businessCenterPublicProgectGraduationtime forKey:@"graduationtime"];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterSubmitWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"发布项目成功"];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            
            return 2;
            break;
            
        case 2:
            return 2;
            break;
            
        default:
            
            return 1;
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 45;
            break;
        case 1:
            return 45;
            break;
        case 2:
            return 45;
            break;
            
        default:
            
            return 150;
            
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            
            if (indexPath.row == 0) {
                BusinessPublishProjectOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.yuanLabel.hidden = YES;
                
                cell.inputContentTextField.tag = 100;
                cell.inputContentTextField.delegate = self;
                
              
                
                return cell;
            }else{
                
                BusinessPublishProjectTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                return cell;
                
                
            }
        }
            break;
        case 1:{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.textLabel.text = @"添加负责人信息";
            
            return cell;
            
        }
            break;
        case 2:{
            
            if (indexPath.row == 0) {
                BusinessPublishProjectOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                cell.titleLabel.text = @"经费预算";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.inputContentTextField.tag = 101;
                cell.inputContentTextField.delegate = self;


                
                return cell;

            }else{
                
                BusinessPublishProjectTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.titleLabel.text = @"项目领域";
                cell.contentLabel.text = @"请选择分类";
                
                return cell;
                

                
            }
            
        }
            break;
            
        default:{
            BusinessPublishProjectThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            if (indexPath.section == 3) {
                
            
                cell.inputContentTextView.tag = 1000;
                cell.inputContentTextView.delegate = self;

                
            }else if (indexPath.section == 4) {
                
                cell.inputContentTextView.tag = 1001;

                cell.titleLabel.text = @"项目成员介绍";
                cell.inputContentTextView.delegate = self;

                

            }else if (indexPath.section == 5) {
                
                cell.inputContentTextView.tag = 1002;

                
                cell.titleLabel.text = @"项目背景面临问题及需求";
                cell.inputContentTextView.delegate = self;



            }else if (indexPath.section == 6) {
                
                cell.inputContentTextView.tag = 1003;

                
                cell.titleLabel.text = @"项目实施计划和预期进展";
                cell.inputContentTextView.delegate = self;


                
            }

            return cell;

        }
            
            break;
    }
}


#pragma mark - textField的代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 100) {
        
       publicProgectModel.businessCenterPublicProgectTitle = textField.text;
        
    }else if (textField.tag == 101){
        
       publicProgectModel.businessCenterPublicProgectDetailBudge = textField.text;
    }
    
    
    return YES;
}


#pragma mark - textView的代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    if (textView.tag == 1000) {
        
       publicProgectModel.businessCenterPublicProgectDetailDescription = textView.text;
        
    }else if (textView.tag == 1001){
        
        publicProgectModel.businessCenterPublicProgectDetailMember = textView.text;
        
    }else if (textView.tag == 1002){
        
        publicProgectModel.businessCenterPublicProgectDetailBackground = textView.text;
        
    }else if (textView.tag == 1003){
        
        publicProgectModel.businessCenterPublicProgectDetailPlan = textView.text;
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
