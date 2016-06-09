//
//  RequirementsViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "RequirementsViewController.h"


#import "RequirementTableViewCell.h"
#import "RequirementTwoTableViewCell.h"

#import "CommonTableViewCell.h"

#import "SelectedImageView.h"
#import "TimeBankModel.h"
#import "LTPickerView.h"
#import "MyPickView.h"
@interface RequirementsViewController ()<UITableViewDelegate,UITableViewDataSource,RequirementTwoTableViewCellDelegate,MyPickViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    SelectedImageView   *selectedImageView;
    NSString            *avatarImageUploaded;
    NSMutableArray      *timeBankConditionCategoryModelArr;
    NSMutableArray      *timeBankConditionCategoryTitleArr;
    NSMutableArray      *timeBankPayWayModelArr;
    NSMutableArray      *timeBankPayWayTitleArr;
    

}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)MyPickView   *myPic;
@property (nonatomic,strong)NSArray *noonArr;
@property (nonatomic,strong)NSArray *yearArr;
@property (nonatomic,strong)NSArray *monthArr;
@property (nonatomic,strong)TimeBankSubmitModel *timeBankSubmitModel;
@end

@implementation RequirementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    timeBankConditionCategoryModelArr = [NSMutableArray array];
    timeBankConditionCategoryTitleArr = [NSMutableArray array];
    timeBankPayWayModelArr            = [NSMutableArray array];
    timeBankPayWayTitleArr            = [NSMutableArray array];
    _timeBankSubmitModel = [[TimeBankSubmitModel alloc]initWithDic:nil];
    self.title = @"发布需求";
    [self createLeftBackNavBtn];
    
    //创建tableView
    [self createTableView];
    
    //创建tableView的headerView
    [self createHeaderView];
    
    
    //创建tableView的footView
    [self createFootView];
    
    ///请求发布类型
    [self requestToGetConditions];
    
}
#pragma mark - 请求数据
-(void)requestToGetConditions
{
    NSDictionary * dic = [NSDictionary dictionary];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankGetConditionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSArray * conditionsArr = [model.responseCommonDic objectForKey:@"categorys"];
            
            ///类别：看电影、吃饭
            for (NSDictionary *smallDic in conditionsArr) {
                TimeBankConditionCategoryModel * model = [[TimeBankConditionCategoryModel alloc] initWithDic: smallDic];
                [timeBankConditionCategoryModelArr addObject:model];
                [timeBankConditionCategoryTitleArr addObject:model.timeBankConditionCategoryName];
            }
            ///获取支付方式
            [self requestToGetPayWay];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
-(void)requestToGetPayWay
{
    NSDictionary * dic = [NSDictionary dictionary];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankGetPayWayWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            for (int i = 0; i<model.responseCommonDic.allKeys.count; i++) {
                NSArray * keyArr = model.responseCommonDic.allKeys;
                NSString * key = [keyArr objectAtIndex:i];
                NSArray * value = [model.responseCommonDic objectForKey:key];
                NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                [dic setValue:key forKey:@"id"];
                [dic setObject:value forKey:@"name"];
                [timeBankPayWayTitleArr addObject:value];
                TimeBankPayWayModel * payWaymodel = [[TimeBankPayWayModel alloc]initWithDic:dic];
                [timeBankPayWayModelArr addObject:payWaymodel];
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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"RequirementTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"RequirementTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    [tableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"threeCell"];
    
    
    
}
- (void)createFootView{
    
    //发布按钮的创建
    
    float space = 16;
    float btnHeight = 44;
    float footViewHeight = 48;
    float btnWidth = SCREEN_WIDTH - 30;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footViewHeight)];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"确定提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [submitBtn setFrame:CGRectMake(space, space, btnWidth,btnHeight)];
    submitBtn.layer.cornerRadius = 10.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [submitBtn addTarget:self action:@selector(releaseAction) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:submitBtn];
    
    self.tableView.tableFooterView = backGroundView;

}
- (void)createHeaderView{
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140)];
    backGroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    float space = 16;
    float headImageheight = 80;
    float headImageWidth = 80;
    ///选择头像
    _headImageSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headImageSelectedBtn setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [_headImageSelectedBtn setImage:[UIImage imageNamed:@"avatar_upload"] forState:UIControlStateNormal];
    [_headImageSelectedBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [_headImageSelectedBtn setFrame:CGRectMake((SCREEN_WIDTH-headImageWidth)/2, space, headImageWidth,headImageheight)];
    [_headImageSelectedBtn addTarget:self action:@selector(selectedImageFromPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:_headImageSelectedBtn];
    
    //lable提醒
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_headImageSelectedBtn.frame) - 80, CGRectGetMaxY(_headImageSelectedBtn.frame), 320, 50)];
    alertLabel.text = @"在这里修改照片仅做时间银行使用,不会更改头像哦";
    alertLabel.font = [UIFont systemFontOfSize:12];
    [backGroundView addSubview:alertLabel];
    
    self.tableView.tableHeaderView = backGroundView;
    
    
}
#pragma mark - 从相册中选择图片

-(void)selectedImageFromPhotoAlbum:(UIButton *)sender
{
    float height = 200;
    
    selectedImageView = [[SelectedImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height) withSuperController:self];
    weakSelf(wSelf)
    selectedImageView.callBackBlock = ^(UIImage * selectedImage){
        ///压缩图片，不能过大
        UIImage * scaleImg = [CommonUtils imageByScalingAndCroppingForSize:CGSizeMake(400, 400) withImage:selectedImage];
        [wSelf.headImageSelectedBtn setBackgroundImage:selectedImage forState:UIControlStateNormal];
        [wSelf.headImageSelectedBtn setImage:[UIImage imageNamed:@"avatar_change"] forState:UIControlStateNormal];
        //需要把图片上传到服务器
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        NSMutableDictionary * imageDic = [NSMutableDictionary dictionary];
        NSData * imageData = UIImagePNGRepresentation(scaleImg);
        [imageDic setObject:imageData forKey:@"Timebank[file]"];
        [[HttpClient sharedInstance]uploadTimeBankIconWithParams:dic withUploadDic:imageDic withSuccessBlock:^(HttpResponseCodeModel *model) {
            avatarImageUploaded = [model.responseCommonDic objectForKey:@"picUrl"];
        } withFaileBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    };
    [[UIApplication sharedApplication].delegate.window addSubview:selectedImageView];
}


#pragma mark - 发布按钮的响应方法
- (void)releaseAction{
    /*
     user_id          int     必需  用户序号
     title            string  必需  标题
     category_id      int     必需 分类序号
     appointment_time string  必需  日期  年月日 周几
     noon             int     必需  时间 1上午 2中午 3下午
     area             string  必需   地点
     number           number  必需  人数
     payway           number  必需   支付方式
     price            int     必需   价格
     brief            string  必需   简介
     icon             string  非必需   头像地址
     */
    if (avatarImageUploaded.length<=0) {
        [CommonUtils showToastWithStr:@"请重新上传图片"];
    }
    if (_timeBankSubmitModel.timeBankSubmitTitle.length<=0) {
        [CommonUtils showToastWithStr:@"请输入标题"];
        return;
    }
    else if (_timeBankSubmitModel.timeBankSubmitType.length<=0){
        [CommonUtils showToastWithStr:@"请选择类型"];
        return;
    }
    else if (_timeBankSubmitModel.timeBankSubmitTime.length<=0){
        [CommonUtils showToastWithStr:@"请选择时间"];
        return;
    }
    else if (_timeBankSubmitModel.timeBankSubmitNoon.length<=0){
        [CommonUtils showToastWithStr:@"请选择时间"];
        return;
    }
    else if (_timeBankSubmitModel.timeBankSubmitAdress.length<=0){
        [CommonUtils showToastWithStr:@"请输入地址"];
        return;
    }
    else if (_timeBankSubmitModel.timeBankSubmitPerson.length<=0){
        [CommonUtils showToastWithStr:@"请选择人数"];
        return;
    }else if (_timeBankSubmitModel.timeBankSubmitPayWay.length<=0){
        [CommonUtils showToastWithStr:@"请选择支付方式"];
        return;
    }else if ([_timeBankSubmitModel.timeBankSubmitPayWay integerValue]==2&& _timeBankSubmitModel.timeBankSubmitPrice.length<=0){
        [CommonUtils showToastWithStr:@"请选择价格"];
        return;
    }else if (_timeBankSubmitModel.timeBankSubmitDescription.length<=0){
        [CommonUtils showToastWithStr:@"请填写描述"];
        return;
    }
    
    [CommonUtils showToastWithStr:@"发布"];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setObject:_timeBankSubmitModel.timeBankSubmitTitle forKey:@"title"];
    [dic setObject:_timeBankSubmitModel.timeBankSubmitType forKey:@"category_id"];
    [dic setObject:_timeBankSubmitModel.timeBankSubmitTime forKey:@"appointment_time"];
    if ([_timeBankSubmitModel.timeBankSubmitNoon isEqualToString:@""]) {
        [dic setObject:@"1"  forKey:@"noon"];
    }else if ([_timeBankSubmitModel.timeBankSubmitNoon isEqualToString:@""]){
        [dic setObject:@"2"  forKey:@"noon"];
    }else{
        [dic setObject:@"3"  forKey:@"noon"];
    }
    
    [dic setObject:_timeBankSubmitModel.timeBankSubmitAdress forKey:@"area"];
    [dic setObject:_timeBankSubmitModel.timeBankSubmitPerson forKey:@"number"];
    [dic setObject:_timeBankSubmitModel.timeBankSubmitPayWay forKey:@"payway"];
    [dic setObject:_timeBankSubmitModel.timeBankSubmitPrice.length>0?_timeBankSubmitModel.timeBankSubmitPrice:@"0" forKey:@"price"];
    [dic setObject:_timeBankSubmitModel.timeBankSubmitDescription forKey:@"brief"];
    if (avatarImageUploaded && avatarImageUploaded.length>0) {
        [dic setObject:avatarImageUploaded forKey:@"icon"];
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankSubmitWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"发布时间银行成功"];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        return 120;
    }else{
        return 48;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                RequirementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLabel.text = @"标题";
                
                cell.inputTextField.delegate = self;
                cell.inputTextField.tag = 1000;
                return cell;
 
            }else{
                
                RequirementTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                cell.showTextLabel.text = @"类型";
                cell.tag = TimeBankSubmitTypeTag;
                cell.delegate = self;
                return cell;

            }
        }
            break;
            
        case 1:{
            if (indexPath.row == 0) {
                
                RequirementTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                cell.showTextLabel.text = @"时间";
                cell.tag = TimeBankSubmitTimeTag;
                cell.delegate = self;
                return cell;
                
            }else if (indexPath.row == 1){
                
                RequirementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                cell.titleLabel.text = @"地点";
                cell.inputTextField.tag = 1001;
                cell.inputTextField.delegate = self;
                return cell;
                
            }else{
                
                RequirementTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                cell.showTextLabel.text = @"需要人数";
                cell.tag = TimeBankSubmitPersonNumTag;
                cell.delegate = self;
                return cell;
   
            }
        }
            break;

        case 2:{
            
            RequirementTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.showTextLabel.text = @"付款方式";
            cell.tag = TimeBankSubmitPayWayTag;
            cell.delegate = self;
            return cell;

        }
            break;
            
        case 3:{
            
           CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleLabel.text = @"宝贝描述";
            cell.rightLabel.hidden = YES;
            cell.textView.placehoderText = @"请输入";
            cell.textView.delegate = self;

            return cell;
        }
            break;
            

        default:{
            
            RequirementTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            //                cell.titleLable.text = @"类型";
            
            
            return cell;
        }
            
            break;
    }
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
#pragma mark - 输入框代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 1000) {
        ///标题
        _timeBankSubmitModel.timeBankSubmitTitle = textField.text;
    }else{
        
        ///地址
        _timeBankSubmitModel.timeBankSubmitAdress = textField.text;

    }
    
    return YES;
}

#pragma mark - textView代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    _timeBankSubmitModel.timeBankSubmitDescription = textView.text;
    
    return YES;
}

#pragma mark - RequirementTwoTableViewCellDelegate
-(void)selectedContentWithwithTag:(NSInteger)tag withBtn:(UIButton *)sender
{
    switch (tag) {
        case TimeBankSubmitTypeTag:{
            
            LTPickerView* pickerView = [LTPickerView new];
            pickerView.dataSource = timeBankConditionCategoryTitleArr;//@[@"1",@"2",@"3",@"4",@"5"];//设置要显示的数据
            //pickerView.defaultStr = @"1";//默认选择的数据
            [pickerView show];//显示
            //回调block
            pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
                //obj:LTPickerView对象
                //str:选中的字符串
                //num:选中了第几行
                NSLog(@"选择了第%d行的%@",num,str);
                [sender setTitle:str forState:UIControlStateNormal];
                TimeBankConditionCategoryModel * model = [timeBankConditionCategoryModelArr objectAtIndex:num];
                _timeBankSubmitModel.timeBankSubmitType = model.timeBankConditionCategoryId;
                
            };
            break;
        }
        case TimeBankSubmitTimeTag:{
            [CommonUtils showToastWithStr:@"选择时间"];
            [self presentSelectedTimeViewWithBtn:sender];
        }
            
            break;
        case TimeBankSubmitPersonNumTag:{
            
            LTPickerView* pickerView = [LTPickerView new];
            pickerView.dataSource = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];//设置要显示的数据
            //pickerView.defaultStr = @"1";//默认选择的数据
            [pickerView show];//显示
            //回调block
            pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
                //obj:LTPickerView对象
                //str:选中的字符串
                //num:选中了第几行
                NSLog(@"选择了第%d行的%@",num,str);
                [sender setTitle:str forState:UIControlStateNormal];
               
                _timeBankSubmitModel.timeBankSubmitPerson = str;
                
            };
            break;
        }
        case TimeBankSubmitPayWayTag:{
            
            LTPickerView* pickerView = [LTPickerView new];
            pickerView.dataSource = timeBankPayWayTitleArr;//设置要显示的数据
            //pickerView.defaultStr = @"1";//默认选择的数据
            [pickerView show];//显示
            //回调block
            pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
                //obj:LTPickerView对象
                //str:选中的字符串
                //num:选中了第几行
                NSLog(@"选择了第%d行的%@",num,str);
                [sender setTitle:str forState:UIControlStateNormal];
                TimeBankPayWayModel  *model = [timeBankPayWayModelArr objectAtIndex:num];
                _timeBankSubmitModel.timeBankSubmitPayWay = model.timeBankPayWayId;
                
            };
            break;
        }
        default:
            break;
    }
}
-(void)presentSelectedTimeViewWithBtn:(UIButton *)sender
{
    _myPic=[[MyPickView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-250, SCREEN_WIDTH, 250)];
    _myPic.delegate = self;
    _myPic.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myPic];
    
    _yearArr = @[@"2016",@"2017"];
    _monthArr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    _noonArr=@[@"上午",@"中午",@"下午"];
    
    weakSelf(weakSelf);
    [_myPic myPickView:nil yearArray:_yearArr monthArray:_monthArr hourArray:_noonArr minuArr:nil];
    _myPic.selectedBlock = ^(BOOL yesIsSure,NSString * selectedDate,NSInteger noonIndex){
        if (yesIsSure==YES) {
            //NSString * selectedTime = weakSelf.myPic.selectedDate;
            NSString * noonDate = [weakSelf.noonArr objectAtIndex:weakSelf.myPic.selectedNoonIndex];
            weakSelf.timeBankSubmitModel.timeBankSubmitTime = selectedDate;
            weakSelf.timeBankSubmitModel.timeBankSubmitNoon = noonDate;
            NSString * time = [NSString stringWithFormat:@"%@%@",selectedDate,noonDate];
            [sender setTitle:time forState:UIControlStateNormal];
            NSLog(@"selectedTime:%@;;noonDate:%@",selectedDate,noonDate);
        }
    };
    
}


-(void)selectedTime
{
    
    
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
