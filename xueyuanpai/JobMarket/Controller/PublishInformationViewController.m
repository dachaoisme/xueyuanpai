//
//  PublishInformationViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/1.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "PublishInformationViewController.h"

#import "PhotoSelectorCell.h"
#import "UIImage+Extension.h"
#import "PublishInformationOneStyleTableViewCell.h"
#import "PublishInformationTwoStyleTableViewCell.h"

#import "CommonTableViewCell.h"

static NSString *Identifier = @"photoCollectionViewCell";

@interface PublishInformationViewController ()<UICollectionViewDataSource,PhotoSelectorCellDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NSMutableArray * jobMarketConditionCategoryTitleArr;
    NSMutableArray * jobMarketConditionModelArr;
    NSString * uploadImageStr;
    PublishJobMarketModel * publishJobMarketModel ;
}
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) NSMutableArray* pictureImages;
@property (nonatomic, strong) UICollectionView* photoCollectionView;


@end

@implementation PublishInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发布二手物品";
    jobMarketConditionCategoryTitleArr = [NSMutableArray array];
    jobMarketConditionModelArr         = [NSMutableArray array];
    publishJobMarketModel = [[PublishJobMarketModel alloc]initWithDic:nil];
    [self createLeftBackNavBtn];
    
    //创建列表视图
    [self createTableView];
    
    

    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"PublishInformationOneStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"PublishInformationOneStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell2"];
     [self.tableView registerNib:[UINib nibWithNibName:@"PublishInformationOneStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell3"];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"PublishInformationTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    
    [self.tableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"threeCell"];
    
    [self requestToGetConditionsCategory];
}

#pragma mark - 创建列表视图
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //添加子控件
    UICollectionViewFlowLayout *photoFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    photoFlowLayout.itemSize = CGSizeMake(80, 80);
    photoFlowLayout.minimumInteritemSpacing = 10;
    photoFlowLayout.minimumLineSpacing = 10;
    
    //设置尾部视图的高度
    photoFlowLayout.footerReferenceSize = CGSizeMake(100, 180);
    
    
    //设置与photoCollectionView的间距
    photoFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView* photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) collectionViewLayout:photoFlowLayout];
    [photoCollectionView registerClass:[PhotoSelectorCell class] forCellWithReuseIdentifier:Identifier];
    photoCollectionView.dataSource = self;
    photoCollectionView.backgroundColor = [UIColor whiteColor];
//    photoCollectionView.userInteractionEnabled = NO;
    
    tableView.tableHeaderView = photoCollectionView;

    self.photoCollectionView = photoCollectionView;
    
    
    
    //注册尾部视图
    [photoCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
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
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:submitBtn];
    
    self.tableView.tableFooterView = backGroundView;

    
}
#pragma mark - 获取分类列表,家电什么的
-(void)requestToGetConditionsCategory
{
    NSDictionary * dic = [NSDictionary dictionary];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance]getJobMarketConditionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSDictionary * conditionsDic = model.responseCommonDic ;
            ///"id":"8","name":"\u5403\u996d","ord":"1"
            ///类别：看电影、吃饭
            for (NSString *key in [conditionsDic allKeys]) {
                
                JobMarketConditionCategoryModel * model = [[JobMarketConditionCategoryModel alloc] initWithDic: [conditionsDic objectForKey:key]];
                [jobMarketConditionModelArr addObject:model];
                [jobMarketConditionCategoryTitleArr addObject:model.jobMarketConditionCategoryName];
            }
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 4;
            break;
            
        case 1:
            return 2;
            break;
            
        default:
            
            return 1;
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 10;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:{
                
                PublishInformationOneStyleTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                oneCell.titleLabel.text = @"标题";
                oneCell.yuanLabel.hidden = YES;
                oneCell.inputContentTextField.tag = 100;
                
                oneCell.inputContentTextField.delegate = self;
                
                
                
               
                return oneCell;

            }
                break;
                
            case 1:{

                PublishInformationTwoStyleTableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                twoCell.selectionStyle = UITableViewCellSelectionStyleNone;


                twoCell.titleLabel.text = @"分类";
                twoCell.contentLabel.text = publishJobMarketModel.publicJobMarketCategoryName.length>0?publishJobMarketModel.publicJobMarketCategoryName:@"请选择分类";
                twoCell.contentLabel.textColor = [CommonUtils colorWithHex:@"c7c6cb"];
                twoCell.alertLabel.hidden = YES;
                twoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
                
                
                
                return twoCell;
            }
                break;
                
            case 2:{
                
                PublishInformationOneStyleTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell2" forIndexPath:indexPath];
                oneCell.selectionStyle = UITableViewCellSelectionStyleNone;

                
                oneCell.titleLabel.text = @"出售价格";
                 oneCell.inputContentTextField.tag = 101;
                
                oneCell.inputContentTextField.delegate = self;

                
                
                return oneCell;
                
            }
                break;

            case 3:{
                PublishInformationOneStyleTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell3" forIndexPath:indexPath];
                oneCell.selectionStyle = UITableViewCellSelectionStyleNone;

                oneCell.inputContentTextField.tag = 102;
                
                oneCell.inputContentTextField.delegate = self;



                oneCell.titleLabel.text = @"原价";
                oneCell.yuanLabel.hidden = YES;
                
                return oneCell;

            }
                break;
                
            default:{
                
                return nil;
            }
                break;
        }
        
        
        
    }else if(indexPath.section == 1){
        
        switch (indexPath.row) {
            case 0:{
                
#warning 数据没从接口显示
               
                PublishInformationTwoStyleTableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                twoCell.selectionStyle = UITableViewCellSelectionStyleNone;

                twoCell.titleLabel.text = @"所在学校";
                twoCell.contentLabel.text = [UserAccountManager sharedInstance].userCollegeName;
                twoCell.contentLabel.textColor = [CommonUtils colorWithHex:@"333333"];
                
                
                publishJobMarketModel.publicJobMarketCollegeId = twoCell.contentLabel.text;
                
                
                return twoCell;
            }
                break;
            case 1:{
                
                PublishInformationTwoStyleTableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                twoCell.selectionStyle = UITableViewCellSelectionStyleNone;

                twoCell.titleLabel.text = @"联系方式";
                twoCell.contentLabel.text = [UserAccountManager sharedInstance].userMobile;
                twoCell.contentLabel.textColor = [CommonUtils colorWithHex:@"333333"];

                twoCell.alertLabel.hidden = YES;
                
                publishJobMarketModel.publicJobMarketTelephone = twoCell.contentLabel.text;
                
                return twoCell;
                
            }
                break;
                
            default:{
                
                return nil;
            }
                break;
        }
        
        

    }else if (indexPath.section == 2){
        
        CommonTableViewCell *threeCell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
        threeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        threeCell.titleLabel.text = @"宝贝描述";
        threeCell.titleLabel.textColor = [UIColor lightGrayColor];
        
        threeCell.rightLabel.hidden = YES;
        threeCell.textView.delegate = self;
        
        threeCell.textView.placehoderText = @"请输入";
        
        
        
        return threeCell;
        
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        return cell;

    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 2) {
        
        return 180;
    }else{
        return 48;
    }
}

#pragma mark - 设置图片选择器如下所示

//懒加载
- (NSMutableArray*)pictureImages {
    
    if (!_pictureImages) {
        _pictureImages = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _pictureImages;
}


#pragma UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.pictureImages.count + 1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取cell
    PhotoSelectorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    cell.PhotoCelldelegate = self;
    
    //给属性赋值
    if (self.pictureImages.count == indexPath.item) {
        
        cell.image = nil;
    }else {
        
        cell.image = self.pictureImages[indexPath.item];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        return nil;

    }else{
        
        //初始化footerView
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        
        //添加提醒视图的提醒框
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 130/2,80, 130, 20)];
        alertLabel.text = @"已选0张，可选5张";
        alertLabel.font = [UIFont systemFontOfSize:14];
        alertLabel.textColor = [CommonUtils colorWithHex:@"3f4446"];
        
        
        [footView addSubview:alertLabel];
        
        //返回footView
        return footView;


        
    }
    
}

#pragma mark -  请选择分类
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        LTPickerView* pickerView = [LTPickerView new];
        pickerView.dataSource = jobMarketConditionCategoryTitleArr;//@[@"1",@"2",@"3",@"4",@"5"];//设置要显示的数据
        //pickerView.defaultStr = @"1";//默认选择的数据
        [pickerView show];//显示
        //回调block
        weakSelf(weakSelf);
        pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
            //obj:LTPickerView对象
            //str:选中的字符串
            //num:选中了第几行
            NSLog(@"选择了第%d行的%@",num,str);
            JobMarketConditionCategoryModel * model = [jobMarketConditionModelArr objectAtIndex:num];
            publishJobMarketModel.publicJobMarketCategoryId = model.jobMarketConditionCategoryId;
            publishJobMarketModel.publicJobMarketCategoryName = str;
            [weakSelf.tableView reloadData];
        };
    }
}

#pragma mark -  请选择图片  PhotoSelectorCellDelegate
- (void)photoDidAddSelector:(PhotoSelectorCell *)cell {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ) {
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)photoDidRemoveSelector:(PhotoSelectorCell *)cell {
    
    //拿到对应的item
    NSIndexPath *index = [self.photoCollectionView indexPathForCell:cell];
    [self.pictureImages removeObjectAtIndex:index.item];
    
    [self.photoCollectionView reloadData];
}

#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    UIImage *newImage = [image imageWithScale:[UIScreen mainScreen].bounds.size.width];
    
    [self.pictureImages addObject:newImage];
    [self.photoCollectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 确认提交按钮响应方法
- (void)commitAction{
    
    [CommonUtils showToastWithStr:@"确认提交"];
    NSMutableDictionary * imageDic = [NSMutableDictionary dictionary];
    for (int i = 0; i<self.pictureImages.count; i++) {
        UIImage *img = [self.pictureImages objectAtIndex:i];
        ///上传图片,压缩图片，不能过大
        UIImage * scaleImg = [CommonUtils imageByScalingAndCroppingForSize:CGSizeMake(300, 300) withImage:img];
        NSData * imageData = UIImagePNGRepresentation(scaleImg);
        NSString * key = [NSString stringWithFormat:@"UploadForm[file][%d]",i];
        [imageDic setObject:imageData forKey:key];
    }
    
    [[HttpClient sharedInstance]uploadJobMarketIconWithParams:imageDic withUploadDic:imageDic withSuccessBlock:^(HttpResponseCodeModel *model) {
        
        if (model.responseCode==ResponseCodeSuccess) {
            NSArray  *imageArr =(NSArray *)model.responseCommonDic;
            uploadImageStr = [imageArr componentsJoinedByString:@";"];
            publishJobMarketModel.publicJobMarketImages = uploadImageStr;
            [self requestToPublish];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)requestToPublish
{
    /*
     title             string     必需    标题
     images            string     必需    照片 多个以;号分隔
     cat_id            int        必需    分类序号
     sale_price        int        必需    销售价格
     origin_price      int        必需    原价
     college_id        int        必需    学校序号
     telphone          string     必需    联系方式
     description       string     必需    描述
     */
    if (publishJobMarketModel.publicJobMarketTitle.length<=0) {
        [CommonUtils showToastWithStr:@"请输入标题"];
        return;
    }
    
    else if (publishJobMarketModel.publicJobMarketImages.length<=0){
        [CommonUtils showToastWithStr:@"请添加照片"];
        return;
    }
    else if (publishJobMarketModel.publicJobMarketCategoryId.length<=0){
        [CommonUtils showToastWithStr:@"请选择分类"];
        return;
    }
    else if (publishJobMarketModel.publicJobMarketSalePrice.length<=0){
        [CommonUtils showToastWithStr:@"请输入价格"];
        return;
    }
    else if (publishJobMarketModel.publicJobMarketOriginPrice.length<=0){
        [CommonUtils showToastWithStr:@"请输入原价"];
        return;
    }
    else if ([UserAccountManager sharedInstance].userCollegeId.length<=0){
        [CommonUtils showToastWithStr:@"请选择学校"];
        return;
    }else if ([UserAccountManager sharedInstance].userMobile.length<=0){
        [CommonUtils showToastWithStr:@"请输入联系方式"];
        return;
    }else if (publishJobMarketModel.publicJobMarketDescription.length<=0){
        [CommonUtils showToastWithStr:@"请添加描述"];
        return;
    }
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:publishJobMarketModel.publicJobMarketTitle forKey:@"title"];
    [dic setValue:publishJobMarketModel.publicJobMarketImages forKey:@"images"];
    [dic setValue:publishJobMarketModel.publicJobMarketCategoryId forKey:@"cat_id"];
    [dic setValue:publishJobMarketModel.publicJobMarketSalePrice  forKey:@"sale_price"];
    [dic setValue:publishJobMarketModel.publicJobMarketOriginPrice forKey:@"origin_price"];
    [dic setValue:[UserAccountManager sharedInstance].userCollegeId forKey:@"college_id"];
    [dic setValue:publishJobMarketModel.publicJobMarketTelephone forKey:@"telphone"];
    [dic setValue:publishJobMarketModel.publicJobMarketDescription forKey:@"description"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]jobMarketSubmitWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"发布跳蚤市场成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
#pragma mark - textField的代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 100) {
        //标题
        publishJobMarketModel.publicJobMarketTitle = textField.text;
    }else if (textField.tag == 101){
        
        publishJobMarketModel.publicJobMarketSalePrice = textField.text;
        
        
    }else if (textField.tag == 102){
        
        publishJobMarketModel.publicJobMarketOriginPrice = textField.text;
        
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    publishJobMarketModel.publicJobMarketDescription = textView.text;
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
