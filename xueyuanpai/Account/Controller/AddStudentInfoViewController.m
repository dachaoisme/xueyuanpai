//
//  AddStudentInfoViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AddStudentInfoViewController.h"
#import "SelectedSexView.h"
#import "SelectedImageView.h"
#import "SelectedSchollViewController.h"
@interface AddStudentInfoViewController ()
{
    //UIButton      *headImageSelectedBtn;
    UIView        *nickNameView;
    UITextField   *nickNameTextField;
    UIView        *sexView;
    UIImageView   *arrowImageView;
    UIView        *schoolView;
    UIImageView   *schoolArrowImageView;
    UIButton      *submitBtn;
    UIButton      *unperfectBtn;
    UIButton      *sexBtn;
    UIButton      *schoolBtn;
    SelectedImageView * selectedImageView;
    CollegeModel  *theCollegeModel;
    NSString      *avatarImageUploaded;
}
@property(nonatomic,strong)UIButton      *headImageSelectedBtn;
@end

@implementation AddStudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"设置资料"];
    self.view.backgroundColor = [CommonUtils colorWithHex:@"e5e5e5"];
    
    [self setContentView];
    
    if([[[UIDevice
          currentDevice] systemVersion] floatValue]>=8.0) {
        
        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }
}
-(void)setContentView
{
    float space = 16;
    float headImageheight = 60;
    float headImageWidth = 60;
    float height = 44;
    float width = SCREEN_WIDTH-2*space;
    float arrowWidth = 20;
    ///选择头像
    _headImageSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headImageSelectedBtn setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [_headImageSelectedBtn setImage:[UIImage imageNamed:@"avatar_upload"] forState:UIControlStateNormal];
    [_headImageSelectedBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [_headImageSelectedBtn setFrame:CGRectMake((SCREEN_WIDTH-headImageWidth)/2, space+NAV_TOP_HEIGHT, headImageWidth,headImageheight)];
    [_headImageSelectedBtn addTarget:self action:@selector(selectedImageFromPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headImageSelectedBtn];
    ///输入昵称
    nickNameView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headImageSelectedBtn.frame)+space, SCREEN_WIDTH, height)];
    nickNameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nickNameView];
    nickNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, 0, width, height)];
    nickNameTextField.backgroundColor = [UIColor whiteColor];
    nickNameTextField.delegate = self;
    nickNameTextField.placeholder = @"设置昵称(4-10个字符)";
    [nickNameView addSubview:nickNameTextField];
    
    ///选择性别
    sexView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nickNameView.frame), SCREEN_WIDTH, height)];
    sexView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sexView];
    sexBtn = [UIFactory button:nil sel:nil titleColor:@"c2c3c4" title:@"选择性别" fontSize:15 frame:CGRectMake(space,0 , width-arrowWidth, CGRectGetHeight(sexView.frame))];
    [sexBtn setBackgroundColor:[UIColor whiteColor]];
    sexBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [sexBtn addTarget:self action:@selector(selectedSxe:) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:sexBtn];
    
    arrowImageView = [UIFactory imageView:CGRectMake(CGRectGetMaxX(sexBtn.frame), 0, arrowWidth, height) viewMode:UIViewContentModeCenter image:@"arrow"];
    [arrowImageView setBackgroundColor:[UIColor whiteColor]];
    [sexView addSubview:arrowImageView];

    ///选择学校
    schoolView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sexView.frame), SCREEN_WIDTH, height)];
    [schoolView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:schoolView];
    schoolBtn = [UIFactory button:nil sel:nil titleColor:@"c2c3c4" title:@"选择学校" fontSize:15 frame:CGRectMake(space, 0, width-arrowWidth, height)];
    [schoolBtn setBackgroundColor:[UIColor whiteColor]];
    schoolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [schoolBtn addTarget:self action:@selector(selectedSchool:) forControlEvents:UIControlEventTouchUpInside];
    [schoolView addSubview:schoolBtn];
    
    schoolArrowImageView = [UIFactory imageView:CGRectMake(CGRectGetMaxX(schoolBtn.frame), 0, arrowWidth, height) viewMode:UIViewContentModeCenter image:@"arrow"];
    [schoolArrowImageView setBackgroundColor:[UIColor whiteColor]];
    [schoolView addSubview:schoolArrowImageView];
    ///提交
    submitBtn = [UIFactory button:nil sel:nil titleColor:@"f5f5f5" title:@"提交" fontSize:15 frame:CGRectMake(space, CGRectGetMaxY(schoolView.frame)+space, width, height)];
    [submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [self.view addSubview:submitBtn];
    ///稍后完善
    unperfectBtn = [UIFactory button:nil sel:nil titleColor:@"00beaf" title:@"稍后完善" fontSize:15 frame:CGRectMake(space, CGRectGetMaxY(submitBtn.frame)+space, width, height)];
    [unperfectBtn addTarget:self action:@selector(unperfect:) forControlEvents:UIControlEventTouchUpInside];
    [unperfectBtn setBackgroundColor:[CommonUtils colorWithHex:@"f5f5f5"]];
    unperfectBtn.layer.borderColor = [CommonUtils colorWithHex:@"00beaf"].CGColor;
    unperfectBtn.layer.borderWidth = 0.5;
    [self.view addSubview:unperfectBtn];
    
    float linHeight = 0.5;
    [UIFactory showLineInView:nickNameView color:@"e5e5e5" rect:CGRectMake(space, CGRectGetHeight(nickNameView.frame)-linHeight, CGRectGetWidth(nickNameView.frame)-space, linHeight)];
    [UIFactory showLineInView:sexView color:@"e5e5e5" rect:CGRectMake(space, CGRectGetHeight(sexView.frame)-linHeight, CGRectGetWidth(sexView.frame)-space, linHeight)];
    [UIFactory showLineInView:schoolView color:@"e5e5e5" rect:CGRectMake(space, CGRectGetHeight(schoolView.frame)-linHeight, CGRectGetWidth(schoolView.frame)-space, linHeight)];

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
            avatarImageUploaded = [CommonUtils getEffectiveUrlWithUrl:[dic objectForKey:@"picUrl"]];
        } withFaileBlock:^(NSError *error) {
            
        }];
        
    };
    [[UIApplication sharedApplication].delegate.window addSubview:selectedImageView];
}


#pragma mark - 选择性别
-(void)selectedSxe:(UIButton *)sender
{
    float height = 200;
    
    SelectedSexView * selectedView = [[SelectedSexView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height)];
    selectedView.callBackBlock = ^(NSString * sex){
        [CommonUtils showToastWithStr:sex];
        [sexBtn setTitle:sex forState:UIControlStateNormal];
    };
    [[UIApplication sharedApplication].delegate.window addSubview:selectedView];
}
#pragma mark - 选择学校
-(void)selectedSchool:(UIButton *)sender
{
    SelectedSchollViewController * schollVC = [[SelectedSchollViewController alloc]init];
    schollVC.callBackBlock = ^(CollegeModel *collegeModel) {
        [schoolBtn setTitle:collegeModel.collegeName forState:UIControlStateNormal];
        theCollegeModel = collegeModel;
    };
    [self.navigationController pushViewController:schollVC animated:YES];
}
#pragma mark - 提交
-(void)submit:(UIButton *)sender
{
    UIImage  *oldImage = [UIImage imageNamed:@"avatar"];
    NSData   *oldImageData = UIImagePNGRepresentation(oldImage);
    UIImage  *newImage = [_headImageSelectedBtn imageForState:UIControlStateNormal];
    NSData   *newImageData = UIImagePNGRepresentation(newImage);
    if ([oldImageData isEqualToData:newImageData]) {
        [CommonUtils showToastWithStr:@"请选择头像"];
        return;
    }
    
    if (nickNameTextField.text.length>10 || nickNameTextField.text.length<4) {
        [CommonUtils showToastWithStr:@"请输入4-10个字符"];
        return;
    }
    if ([sexBtn titleForState:UIControlStateNormal].length<=0 ) {
        [CommonUtils showToastWithStr:@"请选择性别"];
        return;
    }
    if ([schoolBtn titleForState:UIControlStateNormal].length<=0) {
        [CommonUtils showToastWithStr:@"请选择大学"];
        return;
    }
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
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setObject:nickNameTextField.text forKey:@"nickname"];
    [dic setObject:theCollegeModel.collegeID forKey:@"college_id"];
    [dic setObject:[[sexBtn titleForState:UIControlStateNormal] isEqualToString:@"男"]?@"1":@"0" forKey:@"sex"];
    [dic setObject:avatarImageUploaded forKey:@"icon"];
    
    [[HttpClient sharedInstance]updateStudentInfoWithParams:nil withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"用户资料更新成功"];
        }else{
            [CommonUtils showToastWithStr:@"用户资料更新失败"];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
    
}
#pragma mark - 稍后完善
-(void)unperfect:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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
