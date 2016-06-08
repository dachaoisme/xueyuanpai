
//
//  AddTeacherViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AddTeacherViewController.h"
#import "SelectedImageView.h"
#import "AddTeacherInfoTableViewCell.h"

#import "CommonTableViewCell.h"
@interface AddTeacherViewController ()<UITableViewDataSource,UITableViewDelegate,AddTeacherInfoTableViewCellDelegate,UITextViewDelegate>
{
    NSMutableArray    *dataArr ;
    SelectedImageView *selectedImageView;
    NSString          *avatarImageUploaded;
    
    NSString *name;
    NSString *identityNum;
    NSString *workUnit;
    NSString *job;
    NSString *telephoneNum;
    NSString *email;
    NSString *goodAtField;
    NSString *teacherBackground;
    
    
}
@property(nonatomic,strong)UIButton      *headImageSelectedBtn;
@property(nonatomic,strong)UIButton      *submitBtn;
@property(nonatomic,strong)UITableView   *tableView;
@end

@implementation AddTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"认证导师资料";
    
    [self createLeftBackNavBtn];
    NSMutableArray * sectionOneTitleArr = [NSMutableArray arrayWithObjects:@"真实姓名",@"身份证号",@"工作单位",@"职务",@"联系电话",@"邮箱", nil];
    NSMutableArray * sectionTwoTitleArr = [NSMutableArray arrayWithObjects:@"擅长辅导领域", nil];
    NSMutableArray * sectionThreeTitleArr = [NSMutableArray arrayWithObjects:@"导师背景",nil];
    dataArr = [NSMutableArray arrayWithObjects:sectionOneTitleArr,sectionTwoTitleArr,sectionThreeTitleArr, nil];
    
    [self initContentView];
}
-(void)initContentView
{
    //初始化tableView
    CGRect rc = self.view.bounds;
    rc.origin.y = 0;
    rc.size.height = SCREEN_HEIGHT;
    
    UITableView * tableView    = [[UITableView alloc]initWithFrame:rc style:UITableViewStylePlain];
    tableView.separatorColor  = [CommonUtils colorWithHex:@"eeeeee"];
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource       = self;
    tableView.delegate         = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIView * headView = [self headView];
    //设置头视图
    self.tableView.tableHeaderView = headView;
    
    
    UIView *footView = [self footView];
    
    self.tableView.tableFooterView = footView;
    
    
}
-(UIView *)headView
{
    
    float space = 16;
    float headImageheight = 60;
    float headImageWidth = 60;
    UIView * theHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headImageheight+2*space)];
    
//    float height = 44;
//    float width = SCREEN_WIDTH-2*space;
//    float arrowWidth = 20;
    ///选择头像
    _headImageSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headImageSelectedBtn setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [_headImageSelectedBtn setImage:[UIImage imageNamed:@"avatar_upload"] forState:UIControlStateNormal];
    [_headImageSelectedBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [_headImageSelectedBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_headImageSelectedBtn setFrame:CGRectMake((SCREEN_WIDTH-headImageWidth)/2, space, headImageWidth,headImageheight)];
    [_headImageSelectedBtn addTarget:self action:@selector(selectedImageFromPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [theHeadView addSubview:_headImageSelectedBtn];
    
    return theHeadView;
}


-(UIView *)footView
{
    float space = 16;
    float btnHeight = 44;
    float footViewHeight = 48;
    float btnWidth = SCREEN_WIDTH - 30;
    UIView * theFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footViewHeight)];
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:theFootView.bounds];
    [theFootView addSubview:backGroundView];
    
    //    float height = 44;
    //    float width = SCREEN_WIDTH-2*space;
    //    float arrowWidth = 20;
    ///选择头像
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submitBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [_submitBtn setFrame:CGRectMake(space, space, btnWidth,btnHeight)];
    _submitBtn.layer.cornerRadius = 10.0;

    [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:_submitBtn];
    
    return theFootView;
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 44;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [[dataArr objectAtIndex:section] count];
    }else{
        
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //基本信息
        NSString * cellResuable = @"cell";//[NSString stringWithFormat:@"cell%d",indexPath.row];
        AddTeacherInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellResuable];
        if (!cell) {
            cell = [[AddTeacherInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellResuable];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        cell.titleLable.text = [[dataArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return cell;
    }else if (indexPath.section==1){
        //擅长领域
        NSString * cellResuable = @"cell1";
        CommonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellResuable];
        if (!cell) {
            cell = [[CommonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellResuable];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.titleLabel.text = @"擅长辅导领域";
        cell.textView.placehoderText = @"2-40个字符，多个领域以顿号隔开";
        
        cell.tag = 123;
        
        cell.textView.delegate = self;
      
        return cell;
    }else{
        //导师背景
        //擅长领域
        NSString * cellResuable = @"cell2";
        CommonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellResuable];
        if (!cell) {
            cell = [[CommonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellResuable];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.titleLabel.text = @"导师背景";
        cell.textView.placehoderText = @"2-300个字符";
        
        cell.tag = 456;
        
        cell.textView.delegate = self;

        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 文本输入框的代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (textView.tag == 123) {
        //擅长领域
        goodAtField = text;
    }else{
        
        //导师背景
        teacherBackground = text;

    }
    
    return YES;
}

#pragma mark - AddTeacherInfoTableViewCellDelegate,AddTeacherInfoTypeTwoTableViewCellDelegate
-(void)updateInputInfoWithIndex:(NSInteger)index withTextFieldText:(NSString *)text
{
    switch (index) {
        case 0:
            //真实姓名
            name = text;
            break;
        case 1:
            //身份证
            identityNum = text;
            break;
        case 2:
            //工作单位
            workUnit = text;
            break;
        case 3:
            //职务
            job = text;
            break;
        case 4:
            //联系电话
            telephoneNum = text;
            break;
        case 5:
            //邮箱
            email = text;
            break;
        default:
            break;
    }
}

#pragma mark - 提交审核
-(void)submit
{
    /*
     user_id int    必需    用户序号
     realname   string    非必需    真实姓名
     idcard string   非必需     身份证号
     company string   非必需     工作单位
     job string   非必需         职务
     telphone string   非必需     联系电话
     email string   非必需      邮箱
     skillful sting   非必需     擅长辅导领域
     tutorbackground string   非必需     导师背景
     icon string   非必需     头像
     */
    
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    if (name&&name.length>0) {
        [dic setObject:name forKey:@"realname"];
    }
    if (identityNum&&identityNum.length>0) {
        [dic setObject:identityNum forKey:@"idcard"];
    }
    if (workUnit&&workUnit.length>0) {
        [dic setObject:workUnit forKey:@"company"];
    }
    if (job&&job.length>0) {
        [dic setObject:job forKey:@"job"];
    }
    if (telephoneNum&&telephoneNum.length>0) {
        [dic setObject:telephoneNum forKey:@"telphone"];
    }
    if (goodAtField&&goodAtField.length>0) {
        [dic setObject:goodAtField forKey:@"skillful"];
    }
    if (teacherBackground&&teacherBackground.length>0) {
        [dic setObject:teacherBackground forKey:@"tutorbackground"];
    }
    if (avatarImageUploaded&&avatarImageUploaded.length>0) {
        [dic setObject:avatarImageUploaded forKey:@"icon"];
    }
    
    [[HttpClient sharedInstance]updateTeacherInfoWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        //更新导师资料
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"提交审核成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        
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
