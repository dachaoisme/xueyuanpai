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

#import "CommonTableViewCell.h"

#import "AddProjectLeaderViewController.h"

@interface BusinessPublishProjectViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    BusinessCenterPublicProgectModel * publicProgectModel;
    NSMutableArray *businessCenterProgectCategoryModelArr;
    NSMutableArray *businessCenterProgectCategoryTitleArr;
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
    
    businessCenterProgectCategoryModelArr = [NSMutableArray array];
    businessCenterProgectCategoryTitleArr = [NSMutableArray array];
    publicProgectModel = [[BusinessCenterPublicProgectModel alloc]initWithDic:nil];
    [self createLeftBackNavBtn];
 
    //创建tableView
    [self createTableView];
    [self requestToGetConditionsCategory];
}
///获取筛选分类列表
-(void)requestToGetConditionsCategory
{
    NSDictionary * dic = [NSDictionary dictionary];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance]getbusinessCenterConditionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSDictionary * conditionsDic = model.responseCommonDic ;
            ///"id":"8","name":"\u5403\u996d","ord":"1"
            ///类别：农业，轻工业
            for (NSString *key in [conditionsDic allKeys]) {
                BusinessCenterProgectCategoryModel * model = [[BusinessCenterProgectCategoryModel alloc] initWithDic: [conditionsDic objectForKey:key]];
                [businessCenterProgectCategoryModelArr  addObject:model];
                [businessCenterProgectCategoryTitleArr addObject:model.BusinessCenterProgectName];
            }
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //发布按钮的创建
    
    float space = 16;
    float btnHeight = 44;
    float footViewHeight = 48;
    float btnWidth = SCREEN_WIDTH - 30;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footViewHeight)];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"发布" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [submitBtn setFrame:CGRectMake(space, space, btnWidth,btnHeight)];
    submitBtn.layer.cornerRadius = 10.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(publishAction) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:submitBtn];
    
    self.tableView.tableFooterView = backGroundView;

    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"BusinessPublishProjectOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"BusinessPublishProjectTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    [tableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"threeCell"];
    
}

#pragma mark - 发布按钮
- (void)publishAction{
    
    [self.tableView reloadData];
    
     if (publicProgectModel.businessCenterPublicProgectTitle.length<=0) {
         [CommonUtils showToastWithStr:@"请输入标题"];
         return;
     }
    else if (publicProgectModel.businessCenterPublicProgectImage.length<=0){
             [CommonUtils showToastWithStr:@"请添加照片"];
             return;
         }
     else if (publicProgectModel.businessCenterPublicProgectDetailBudge.length<=0){
         [CommonUtils showToastWithStr:@"请添加预算"];
         return;
     }
     else if (publicProgectModel.businessCenterPublicProgectDetailFieldId.length<=0){
         [CommonUtils showToastWithStr:@"请输入擅长领域"];
         return;
     }
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
     else if (publicProgectModel.businessCenterPublicProgectRealName.length<=0){
         [CommonUtils showToastWithStr:@"请输入真实名字"];
         return;
     }else if (publicProgectModel.businessCenterPublicProgectIdentityCard.length<=0){
         [CommonUtils showToastWithStr:@"请输入身份证号"];
         return;
     }else if (publicProgectModel.businessCenterPublicProgectTelephone.length<=0){
         [CommonUtils showToastWithStr:@"请输入电话"];
         return;
     }else if (publicProgectModel.businessCenterPublicProgectCollegeId.length<=0){
         [CommonUtils showToastWithStr:@"请输入学校"];
         return;
     }else if (publicProgectModel.businessCenterPublicProgectMajor.length<=0){
         [CommonUtils showToastWithStr:@"请输入专业"];
         return;
     }else if (publicProgectModel.businessCenterPublicProgectJobId.length<=0){
         [CommonUtils showToastWithStr:@"请输入学历"];
         return;
     }else if (publicProgectModel.businessCenterPublicProgectGraduationtime.length<=0){
         [CommonUtils showToastWithStr:@"请输入毕业时间"];
         return;
     }
    
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"owner_id"];
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
            [self.navigationController popViewControllerAnimated:YES];
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
            CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            if (indexPath.section == 3) {
                
            
                cell.textView.tag = 1000;
                cell.textView.delegate = self;
                
                cell.titleLabel.text = @"项目简介";
                cell.rightLabel.text = @"50-500字";
                cell.textView.placehoderText = @"请简单介绍项目";

                
            }else if (indexPath.section == 4) {
                
                cell.textView.tag = 1001;

                cell.titleLabel.text = @"项目成员介绍";
                cell.textView.delegate = self;

                
                cell.rightLabel.text = @"50-500字";
                cell.textView.placehoderText = @"请简单描述项目成员";
                

            }else if (indexPath.section == 5) {
                
                cell.textView.tag = 1002;

                
                cell.titleLabel.text = @"项目背景面临问题及需求";
                cell.textView.delegate = self;
                cell.rightLabel.text = @"50-500字";

                cell.textView.placehoderText = @"请填写";



            }else if (indexPath.section == 6) {
                
                cell.textView.tag = 1003;

                
                cell.titleLabel.text = @"项目实施计划和预期进展";
                cell.textView.delegate = self;
                cell.rightLabel.text = @"50-500字";

                
                cell.textView.placehoderText = @"请填写";



                
            }

            return cell;

        }
            
            break;
    }
}


#pragma mark - textField的代理方法
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 100) {
        
        publicProgectModel.businessCenterPublicProgectTitle = textField.text;
        
    }else if (textField.tag == 101){
        
        publicProgectModel.businessCenterPublicProgectDetailBudge = textField.text;
    }
}
#pragma mark - textView的代理方法
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 1000) {
        
        publicProgectModel.businessCenterPublicProgectDetailDescription = textView.text;
        
    }else if (textView.tag == 1001){
        
        publicProgectModel.businessCenterPublicProgectDetailMember = textView.text;
        
    }else if (textView.tag == 1002){
        
        publicProgectModel.businessCenterPublicProgectDetailBackground = textView.text;
        
    }else if (textView.tag == 1003){
        
        publicProgectModel.businessCenterPublicProgectDetailPlan = textView.text;
    }
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    ///跳转到选择照片页面
    if (indexPath.section==0&&indexPath.row==1) {
        
        float height = 200;
        
        selectedImageView = [[SelectedImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height) withSuperController:self];
        //weakSelf(wSelf)
        selectedImageView.callBackBlock = ^(UIImage * selectedImage){
            ///压缩图片，不能过大
            UIImage * scaleImg = [CommonUtils imageByScalingAndCroppingForSize:CGSizeMake(400, 400) withImage:selectedImage];
            
            //需要把图片上传到服务器
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            NSMutableDictionary * imageDic = [NSMutableDictionary dictionary];
            NSData * imageData = UIImagePNGRepresentation(scaleImg);
            [imageDic setObject:imageData forKey:@"UploadForm[file][]"];
            [[HttpClient sharedInstance]uploadJobMarketIconWithParams:dic withUploadDic:imageDic withSuccessBlock:^(HttpResponseCodeModel *model) {
                NSArray * imageArr = (NSArray *)model.responseCommonDic;
                if (imageArr &&imageArr.count>0) {
                    publicProgectModel.businessCenterPublicProgectImage = [imageArr firstObject];
                }
            } withFaileBlock:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
        };
        [[UIApplication sharedApplication].delegate.window addSubview:selectedImageView];
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1) {
        //跳转项目负责人页面
        AddProjectLeaderViewController *addProjectLeaderVC = [[AddProjectLeaderViewController alloc] init];
        addProjectLeaderVC.publicProgectModel = publicProgectModel;
        [self.navigationController pushViewController:addProjectLeaderVC animated:YES];
    }
    
    if (indexPath.section==2) {

        LTPickerView* pickerView = [LTPickerView new];
        pickerView.dataSource = businessCenterProgectCategoryTitleArr;//设置要显示的数据
        //pickerView.defaultStr = @"1";//默认选择的数据
        [pickerView show];//显示
        weakSelf(weakSelf);
        //回调block
        pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
            //obj:LTPickerView对象
            //str:选中的字符串
            //num:选中了第几行
            BusinessPublishProjectTwoTableViewCell * smallCell = (BusinessPublishProjectTwoTableViewCell*)cell;
            NSLog(@"选择了第%d行的%@",num,str);
            publicProgectModel.businessCenterPublicProgectDetailField = [businessCenterProgectCategoryTitleArr objectAtIndex:num];
            publicProgectModel.businessCenterPublicProgectDetailFieldId = [[businessCenterProgectCategoryModelArr objectAtIndex:num] BusinessCenterProgectId ];
            smallCell.contentLabel.text = str;
            
        };
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
