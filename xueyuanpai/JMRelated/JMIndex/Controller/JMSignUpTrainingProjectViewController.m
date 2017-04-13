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
#import "JMJobListViewController.h"
#import "SelectedImageView.h"
@interface JMSignUpTrainingProjectViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,JMSignUpTwoTypeTableViewCellDelegate>
{
    NSString *job;
    NSString *name;
    NSString *telephone;
    NSString *reason;
    NSString *imageUrl;
    SelectedImageView *selectedImageView;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIImage *selectedImageFromPhoto;
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
    _dataArr = [NSMutableArray array];
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
            if (job &&job.length>0) {
                
                [cell.rightContentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [cell.rightContentBtn setTitle:job forState:UIControlStateNormal];
            }else{
                [cell.rightContentBtn setTitle:@"请选择" forState:UIControlStateNormal];
            }
            
            return cell;
            
        }
            break;
        case 1:{
            
            JMSignUpTwoTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSignUpTwoTypeTableViewCell"];
            cell.delegate = self;
            cell.tag = indexPath.row;
            if (indexPath.row==0) {
                ////姓名
                cell.leftTitleLabel.text = @"姓名";
                if (name &&name.length>0) {
                    cell.rightTextFeild.text = name;
                }else{
                    cell.rightTextFeild.text = @"";
                }
            }else{
                ///手机号
                cell.leftTitleLabel.text = @"手机号";
                if (telephone &&telephone.length>0) {
                    cell.rightTextFeild.text = telephone;
                }else{
                    cell.rightTextFeild.text = @"";
                }
            }
            return cell;
            
        }
            break;
        case 2:{
            
            JMSignUpOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMSignUpOneTypeTableViewCell"];
            
            cell.leftTitleLabel.text = @"个人形象照";
            if (self.selectedImageFromPhoto) {
                [cell.rightContentBtn setImage:self.selectedImageFromPhoto forState:UIControlStateNormal];
                [cell.rightContentBtn setTitle:@"" forState:UIControlStateNormal];
            }else{
                [cell.rightContentBtn setImage:nil forState:UIControlStateNormal];
                [cell.rightContentBtn setTitle:@"请上传" forState:UIControlStateNormal];
            }
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
            cell.textView.text = reason;
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

//点击跳转详情视图
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        ///选择职位
        JMJobListViewController *listVC = [[JMJobListViewController alloc]init];
        listVC.trainProjectId = self.trainProjectId;
        listVC.returnBlock = ^(NSString *returnBlock) {
            job = returnBlock;
            [self.tableView reloadData];
        } ;
        [self.navigationController pushViewController:listVC animated:YES];
    }
    if (indexPath.section==2) {
        ///选择照片
        [self selectedImageFromPhotoAlbum];
    }
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
    /*
     user_id     用户序号   必须
     entity_id   实体序号   必须
     entity_type 实体类型   必须  project 创业项目  salon 创业沙龙
     job         岗位      必须
     name        姓名      必须
     telphone    手机号     必须
     icon        形象照      非必须（链接地址，调用头像上传接口返回）
     reason      入选理由    非必须

     
     */
    [CommonUtils showToastWithStr:@"确定"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.trainProjectId forKey:@"entity_id"];
    [dic setValue:@"project" forKey:@"entity_type"];
    [dic setValue:job forKey:@"job"];
    [dic setValue:name forKey:@"name"];
    [dic setValue:telephone forKey:@"telphone"];
    [dic setValue:imageUrl forKey:@"icon"];
    [dic setValue:reason forKey:@"reason"];
    [[HttpClient sharedInstance] signUpWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode ==ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
        
    } withFaileBlock:^(NSError *error) {
        
    }];
    
}

-(void)inputEndWithText:(NSString *)text withRow:(NSInteger)row
{
    if (row==0) {
        name = text;
    }else if (row==1){
        telephone = text;
    }else{
        
    }
    [self.tableView reloadData];
}

#pragma mark - textView的代理方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    reason = text;
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    reason = textView.text;
    
}
#pragma mark - 从相册中选择图片

-(void)selectedImageFromPhotoAlbum
{
    float height = 200;
    weakSelf(weakSelf);
    selectedImageView = [[SelectedImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-height, SCREEN_WIDTH, height) withSuperController:self];
    selectedImageView.callBackBlock = ^(UIImage * selectedImage){
        ///压缩图片，不能过大
        selectedImage = [CommonUtils imageByScalingAndCroppingForSize:CGSizeMake(200, 200) withImage:selectedImage];
        weakSelf.selectedImageFromPhoto = selectedImage;
        //需要把图片上传到服务器
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        NSMutableDictionary * imageDic = [NSMutableDictionary dictionary];
        NSData * imageData = UIImagePNGRepresentation(weakSelf.selectedImageFromPhoto);
        [imageDic setValue:imageData forKey:@"JmStudent[file]"];
        [[HttpClient sharedInstance] uploadIconWithParams:dic withUploadDic:imageDic withSuccessBlock:^(HttpResponseCodeModel *model) {
            imageUrl = [model.responseCommonDic objectForKey:@"picUrl"];
            [weakSelf.tableView reloadData];
        } withFaileBlock:^(NSError *error) {
            
        }];
        
    };
    [[UIApplication sharedApplication].delegate.window addSubview:selectedImageView];
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
