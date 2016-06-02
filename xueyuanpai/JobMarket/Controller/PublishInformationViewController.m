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

#import "PublishInformationThreeStyleTableViewCell.h"

static NSString *Identifier = @"photoCollectionViewCell";

@interface PublishInformationViewController ()<UICollectionViewDataSource,PhotoSelectorCellDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) NSMutableArray* pictureImages;
@property (nonatomic, strong) UICollectionView* photoCollectionView;


@end

@implementation PublishInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发布二手物品";
    
    
    [self createLeftBackNavBtn];
    
    //创建列表视图
    [self createTableView];
    
    

    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"PublishInformationOneStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"PublishInformationTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PublishInformationThreeStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"threeCell"];
    
    
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
    
    
    //设置tableView的footView
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [button setTitle:@"确定提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.tableView.tableFooterView = button;
    
}

#pragma mark - 确认提交按钮响应方法
- (void)commitAction{
    
    [CommonUtils showToastWithStr:@"确认提交"];
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
                return oneCell;

            }
                break;
                
            case 1:{

                PublishInformationTwoStyleTableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                twoCell.selectionStyle = UITableViewCellSelectionStyleNone;


                twoCell.titleLabel.text = @"分类";
                twoCell.contentLabel.text = @"请选择分类";
                twoCell.contentLabel.textColor = [UIColor groupTableViewBackgroundColor];
                twoCell.alertLabel.hidden = YES;
                twoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
                
                return twoCell;
            }
                break;
                
            case 2:{
                
                PublishInformationOneStyleTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                oneCell.selectionStyle = UITableViewCellSelectionStyleNone;

                
                oneCell.titleLabel.text = @"出售价格";
                
                return oneCell;
                
            }
                break;

            case 3:{
                PublishInformationOneStyleTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
                oneCell.selectionStyle = UITableViewCellSelectionStyleNone;


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
               
                PublishInformationTwoStyleTableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                twoCell.selectionStyle = UITableViewCellSelectionStyleNone;

                twoCell.titleLabel.text = @"所在学校";
                twoCell.contentLabel.text = @"吉林长春大学";
                
                return twoCell;
            }
                break;
            case 1:{
                
                PublishInformationTwoStyleTableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
                twoCell.selectionStyle = UITableViewCellSelectionStyleNone;

                twoCell.titleLabel.text = @"联系方式";
                twoCell.contentLabel.text = @"188888888888";
                twoCell.alertLabel.hidden = YES;
                
                return twoCell;
                
            }
                break;
                
            default:{
                
                return nil;
            }
                break;
        }
        
        

    }else if (indexPath.section == 2){
        
        PublishInformationThreeStyleTableViewCell *threeCell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
        threeCell.selectionStyle = UITableViewCellSelectionStyleNone;

        
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
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        [CommonUtils showToastWithStr:@"请选择分类"];
    }
}

#pragma PhotoSelectorCellDelegate
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
