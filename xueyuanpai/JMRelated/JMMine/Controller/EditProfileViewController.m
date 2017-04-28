//
//  EditProfileViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "EditProfileViewController.h"

#import "EditProfileTableViewCell.h"
#import "EditProfileTwoTableViewCell.h"

#import "SelectedImageView.h"
#import "SelectedSexView.h"

#import "SelectedSchollViewController.h"
#import "ZHPickView.h"
@interface EditProfileViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ZHPickViewDelegate>

{
    SelectedImageView *selectedImageView;
    NSString          *avatarImageUploaded;
    
    CollegeModel *theCollegeModel;
    ZHPickView *pickview;
    
}

///选择头像的按钮
@property (nonatomic,strong)UIButton *headImageSelectedBtn;


@property (nonatomic,strong)UITableView *tableView;

///昵称
@property (nonatomic,strong)NSString *nickName;

///性别
@property (nonatomic,strong)NSString *sexStr;

///生日
@property (nonatomic,strong)NSString *birthdayStr;

///学校
@property (nonatomic,strong)NSString *school;

///年级
@property (nonatomic,strong)NSString *grade;

@end

@implementation EditProfileViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    self.title = @"编辑个人资料";
    
    _nickName = [UserAccountManager sharedInstance].userNickname;
    _grade = [UserAccountManager sharedInstance].userGrade;
    _birthdayStr =[UserAccountManager sharedInstance].birthday;
    [self createLeftBackNavBtn];
    
    [self setInitNickName];
    
    [self setContentView];
    
    [self createTableView];
    
    //创建提交按钮
    [self createCommitButton];
}
-(void)setInitNickName
{
    if ([UserAccountManager sharedInstance].userSex == UserInfoSexMan) {
        
        self.sexStr = @"男";
        
    }else if ([UserAccountManager sharedInstance].userSex == UserInfoSexWoman){
        
        self.sexStr = @"女";
    }else{
        
        self.sexStr = @"未知";
    }

}
#pragma mark - 创建提交按钮
- (void)createCommitButton{
    
    //确定按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, CGRectGetMaxY(self.tableView.frame) + 10, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];

    
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 250) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"EditProfileTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
    [tableView registerNib:[UINib nibWithNibName:@"EditProfileTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
}

#pragma mark - 设置修改头像视图
-(void)setContentView
{
    float space = 16;
    float headImageheight = 60;
    float headImageWidth = 60;
    ///选择头像
    _headImageSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headImageSelectedBtn setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [_headImageSelectedBtn setImage:[UIImage imageNamed:@"avatar_change"] forState:UIControlStateNormal];
    [_headImageSelectedBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [_headImageSelectedBtn setFrame:CGRectMake((SCREEN_WIDTH-headImageWidth)/2, space+NAV_TOP_HEIGHT, headImageWidth,headImageheight)];
    
    _headImageSelectedBtn.layer.cornerRadius = 30;
    _headImageSelectedBtn.layer.masksToBounds = YES;
    
    [_headImageSelectedBtn addTarget:self action:@selector(selectedImageFromPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_headImageSelectedBtn];
    
    
    if ([UserAccountManager sharedInstance].userIcon.length > 0) {
        NSURL *imageUrl = [NSURL URLWithString:[UserAccountManager sharedInstance].userIcon];
        
        [_headImageSelectedBtn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]] forState:UIControlStateNormal];
        avatarImageUploaded =[UserAccountManager sharedInstance].userIcon;
    }
    

    
}

#pragma mark - textField的代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 10000) {
        
        self.nickName = textField.text;

    }else{
        
        self.grade = textField.text;
    }
    
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        EditProfileTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.inputTextField.delegate = self;
        cell.inputTextField.tag = 10000;
        
        cell.inputTextField.text = _nickName;
                
        return cell;
        
    }else if (indexPath.row == 4){
        EditProfileTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.inputTextField.delegate = self;
        cell.inputTextField.tag = 10001;

        cell.titleLabel.text = @"年级";
        cell.inputTextField.placeholder = @"请输入";
        cell.inputTextField.text =_grade;
        return cell;
    }else{
        
        EditProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 1) {
            
            cell.titleLabel.text = @"性别";
            cell.contentLabel.text = self.sexStr;
            
            
        }else if (indexPath.row == 2) {
            
            cell.titleLabel.text = @"生日";
            cell.contentLabel.text = self.birthdayStr;
            
        }else if (indexPath.row == 3) {
            
            cell.titleLabel.text = @"学校";
            cell.contentLabel.text = theCollegeModel.collegeName.length>0?theCollegeModel.collegeName: [UserAccountManager sharedInstance].userCollegeName;
            
        }
        return cell;
        

    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self)weakSelf = self;
    
    if (indexPath.row == 1) {
        
        EditProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        //选择性别
        float height = 200;
        
        SelectedSexView * selectedView = [[SelectedSexView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height)];
        selectedView.callBackBlock = ^(NSString * sex){
            [CommonUtils showToastWithStr:sex];
            cell.contentLabel.text = sex;
            self.sexStr = sex;
            
        };
        [[UIApplication sharedApplication].delegate.window addSubview:selectedView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else if (indexPath.row == 2){
        
        //选择生日
        [CommonUtils showToastWithStr:@"选择生日"];
        NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
        pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        pickview.delegate=self;
        
        [pickview show];
    }else if (indexPath.row == 3){
        
        EditProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        //选择学校
        SelectedSchollViewController * schollVC = [[SelectedSchollViewController alloc]init];
        schollVC.callBackBlock = ^(CollegeModel *collegeModel) {
            cell.titleLabel.text = @"学校";

            
            cell.contentLabel.text = collegeModel.collegeName;
            
            
            weakSelf.school = collegeModel.collegeName;
            
            theCollegeModel = collegeModel;
            
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [self.navigationController pushViewController:schollVC animated:YES];
        
    }
    
}
#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString withDate:(NSDate *)resultDate{
    
    
    self.birthdayStr=resultString;
    [self.tableView reloadData];
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
        UIImage * scaleImg = [CommonUtils imageByScalingAndCroppingForSize:CGSizeMake(400, 400) withImage:selectedImage];
        //需要把图片上传到服务器
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        NSMutableDictionary * imageDic = [NSMutableDictionary dictionary];
        NSData * imageData = UIImagePNGRepresentation(scaleImg);
        [imageDic setObject:imageData forKey:@"JmStudent[file]"];
        [[HttpClient sharedInstance]uploadIconWithParams:dic withUploadDic:imageDic withSuccessBlock:^(HttpResponseCodeModel *model) {
            avatarImageUploaded = [model.responseCommonDic objectForKey:@"picUrl"];
            
        } withFaileBlock:^(NSError *error) {
            [CommonUtils showToastWithStr:@"图片上传失败"];
        }];
        
    };
    [[UIApplication sharedApplication].delegate.window addSubview:selectedImageView];
    
}
#pragma mark - 提交按钮
- (void)commitAction{
    
    
//    UIImage  *oldImage = [UIImage imageNamed:@"avatar"];
//    NSData   *oldImageData = UIImagePNGRepresentation(oldImage);
//    UIImage  *newImage = [_headImageSelectedBtn imageForState:UIControlStateNormal];
//    NSData   *newImageData = UIImagePNGRepresentation(newImage);
//    if ([oldImageData isEqualToData:newImageData]) {
//        [CommonUtils showToastWithStr:@"请选择头像"];
//        return;
//    }
//    if (avatarImageUploaded.length<=0) {
//        [CommonUtils showToastWithStr:@"请选择头像"];
//        return;
//    }
//    if (_nickName.length>10 || _nickName.length<4) {
//        [CommonUtils showToastWithStr:@"请输入4-10个字符"];
//        return;
//    }
//    if (_sexStr.length<=0 ) {
//        [CommonUtils showToastWithStr:@"请选择性别"];
//        return;
//    }
//    if (_school.length<=0) {
//        [CommonUtils showToastWithStr:@"请选择大学"];
//        return;
//    }
    if (![UserAccountManager sharedInstance].userId) {
        [CommonUtils showToastWithStr:@"用户注册未成功"];
        return;
    }
    /*
     user_id int    必需    用户序号
     nickname   string    非必需    昵称
     college_id int    非必需     学校序号
     sex        int    非必需    性别 1男  0 女
     icon string       非必需     头像
     */
    
    NSMutableDictionary  *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setObject:avatarImageUploaded?avatarImageUploaded:@"" forKey:@"icon"];
    [dic setObject:self.nickName?self.nickName:[UserAccountManager sharedInstance].userNickname forKey:@"nickname"];
    [dic setObject:[_sexStr isEqualToString:@"男"]?@"1":@"0" forKey:@"sex"];
    [dic setObject:theCollegeModel.collegeID?theCollegeModel.collegeID:[UserAccountManager sharedInstance].userCollegeId forKey:@"college_id"];
    [dic setObject:self.grade?self.grade: [UserAccountManager sharedInstance].userGrade forKey:@"grade"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]updateStudentInfoWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"用户资料修改成功"];
            [[UserAccountManager sharedInstance]getUserInfoWithUserId:[UserAccountManager sharedInstance].userId];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
        [CommonUtils showToastWithStr:@"用户资料更新失败"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
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
