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
#import "SelectedImageView.h"
#import "TimeBankModel.h"
#import "LTPickerView.h"
@interface RequirementsViewController ()<UITableViewDelegate,UITableViewDataSource,RequirementTableViewCellDelegate,RequirementTwoTableViewCellDelegate>
{
    SelectedImageView *selectedImageView;
    NSString          *avatarImageUploaded;
    NSMutableArray    *timeBankConditionCategoryModelArr;
    NSMutableArray    *timeBankConditionCategoryTitleArr;
    NSMutableArray    *timeBankPayWayModelArr;
    NSMutableArray    *timeBankPayWayTitleArr;
    TimeBankSubmitModel * timeBankSubmitModel;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation RequirementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    timeBankConditionCategoryModelArr = [NSMutableArray array];
    timeBankConditionCategoryTitleArr = [NSMutableArray array];
    timeBankPayWayModelArr            = [NSMutableArray array];
    timeBankPayWayTitleArr            = [NSMutableArray array];
    timeBankSubmitModel = [[TimeBankSubmitModel alloc]initWithDic:nil];
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
                [dic setObject:value forKey:key];
                [timeBankPayWayTitleArr addObject:value];
                TimeBankPayWayModel * model = [[TimeBankPayWayModel alloc]initWithDic:dic];
                [timeBankPayWayModelArr addObject:model];
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
    
    
    
}
- (void)createFootView{
    
    //发布按钮的创建
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 200, 40);
    [button setTitle:@"发布" forState:UIControlStateNormal];
    
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [button addTarget:self action:@selector(releaseAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = button;
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
        
        [wSelf.headImageSelectedBtn setBackgroundImage:selectedImage forState:UIControlStateNormal];
        [wSelf.headImageSelectedBtn setImage:[UIImage imageNamed:@"avatar_change"] forState:UIControlStateNormal];
        //需要把图片上传到服务器
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        NSMutableDictionary * imageDic = [NSMutableDictionary dictionary];
        NSData * imageData = UIImagePNGRepresentation(selectedImage);
        [imageDic setObject:imageData forKey:@"Users[file]"];
        [[HttpClient sharedInstance]uploadImageWithParams:dic withUploadDic:imageDic withSuccessBlock:^(HttpResponseCodeModel *model) {
            avatarImageUploaded = [CommonUtils getEffectiveUrlWithUrl:[dic objectForKey:@"picUrl"]withType:2];
        } withFaileBlock:^(NSError *error) {
            
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
    if (timeBankSubmitModel.timeBankSubmitTitle.length<=0) {
        [CommonUtils showToastWithStr:@"请输入标题"];
        return;
    }
    else if (timeBankSubmitModel.timeBankSubmitType.length<=0){
        [CommonUtils showToastWithStr:@"请选择类型"];
        return;
    }
    else if (timeBankSubmitModel.timeBankSubmitTime.length<=0){
        [CommonUtils showToastWithStr:@"请选择时间"];
        return;
    }
    else if (timeBankSubmitModel.timeBankSubmitNoon.length<=0){
        [CommonUtils showToastWithStr:@"请选择时间"];
        return;
    }
    else if (timeBankSubmitModel.timeBankSubmitAdress.length<=0){
        [CommonUtils showToastWithStr:@"请输入地址"];
        return;
    }
    else if (timeBankSubmitModel.timeBankSubmitPerson.length<=0){
        [CommonUtils showToastWithStr:@"请选择人数"];
        return;
    }else if (timeBankSubmitModel.timeBankSubmitPayWay.length<=0){
        [CommonUtils showToastWithStr:@"强选择支付方式"];
        return;
    }else if (timeBankSubmitModel.timeBankSubmitPrice.length<=0){
        [CommonUtils showToastWithStr:@"请选择价格"];
        return;
    }else if (timeBankSubmitModel.timeBankSubmitDescription.length<=0){
        [CommonUtils showToastWithStr:@"请填写描述"];
        return;
    }
    
    [CommonUtils showToastWithStr:@"发布"];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setObject:timeBankSubmitModel.timeBankSubmitTitle forKey:@"title"];
    [dic setObject:timeBankSubmitModel.timeBankSubmitType forKey:@"category_id"];
    [dic setObject:timeBankSubmitModel.timeBankSubmitTime forKey:@"appointment_time"];
    [dic setObject:timeBankSubmitModel.timeBankSubmitNoon  forKey:@"noon"];
    [dic setObject:timeBankSubmitModel.timeBankSubmitAdress forKey:@"area"];
    [dic setObject:timeBankSubmitModel.timeBankSubmitPerson forKey:@"number"];
    [dic setObject:timeBankSubmitModel.timeBankSubmitPayWay forKey:@"payway"];
    [dic setObject:timeBankSubmitModel.timeBankSubmitPrice forKey:@"price"];
    [dic setObject:timeBankSubmitModel.timeBankSubmitDescription forKey:@"brief"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                RequirementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                cell.titleLabel.text = @"标题";
                cell.tag = TimeBankSubmitTitleTag;
                cell.delegate = self;
                return cell;
 
            }else{
                
                RequirementTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                
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
                cell.showTextLabel.text = @"时间";
                cell.tag = TimeBankSubmitTimeTag;
                cell.delegate = self;
                return cell;
                
            }else if (indexPath.row == 1){
                
                RequirementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                cell.titleLabel.text = @"地点";
                cell.tag = TimeBankSubmitAdressTag;
                cell.delegate = self;
                return cell;
                
            }else{
                
                RequirementTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                cell.showTextLabel.text = @"需要人数";
                cell.tag = TimeBankSubmitPersonNumTag;
                cell.delegate = self;
                return cell;
   
            }
        }
            break;

        case 2:{
            
            RequirementTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.showTextLabel.text = @"付款方式";
            cell.tag = TimeBankSubmitPayWayTag;
            cell.delegate = self;
            return cell;

        }
            break;
            
        case 3:{
            
            RequirementTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.showTextLabel.text = @"描述内容";
            cell.tag = TimeBankSubmitDescriptionTag;
            cell.delegate = self;
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
#pragma mark - RequirementTableViewCellDelegate
-(void)setInputContentWithContent:(NSString *)content withTag:(NSInteger)tag
{
    if (tag == TimeBankSubmitTitleTag) {
        ///标题
        timeBankSubmitModel.timeBankSubmitTitle = content;
    }else if (tag == TimeBankSubmitAdressTag){
        ///地址
        timeBankSubmitModel.timeBankSubmitAdress = content;
    }else{
        
    }
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
                timeBankSubmitModel.timeBankSubmitType = model.timeBankConditionCategoryId;
                
            };
            break;
        }
        case TimeBankSubmitTimeTag:
            
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
               
                timeBankSubmitModel.timeBankSubmitPerson = str;
                
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
                timeBankSubmitModel.timeBankSubmitPayWay = model.timeBankPayWayId;
                
            };
            break;
        }
        default:
            break;
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