
//
//  AddTeacherViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AddTeacherViewController.h"
#import "SelectedImageView.h"
@interface AddTeacherViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * dataArr ;
    SelectedImageView * selectedImageView;
    NSString      *avatarImageUploaded;
}
@property(nonatomic,strong)UIButton      *headImageSelectedBtn;
@property(nonatomic,strong)UITableView    *tableView;
@end

@implementation AddTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray * sectionOneTitleArr = [NSMutableArray arrayWithObjects:@"真实姓名",@"身份证号",@"工作单位",@"职务",@"联系电话",@"邮箱",@"",@"",@"", nil];
    NSMutableArray * sectionTwoTitleArr = [NSMutableArray arrayWithObjects:@"擅长辅导领域", nil];
    NSMutableArray * sectionThreeTitleArr = [NSMutableArray arrayWithObjects:@"导师背景",nil];
    dataArr = [NSMutableArray arrayWithObjects:sectionOneTitleArr,sectionTwoTitleArr,sectionThreeTitleArr, nil];
    
    
}
-(void)initContentView
{
    float space = 16;
    //初始化tableView
    CGRect rc = self.view.bounds;
    rc.origin.y = 0;
    rc.size.height = SCREEN_HEIGHT-NAV_TOP_HEIGHT;
    
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
}
-(UIView *)headView
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
    
    return _headImageSelectedBtn;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //目的地
    NSString * cellResuable = @"cell";//[NSString stringWithFormat:@"cell%d",indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellResuable];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellResuable];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CollegeModel  *model = [dataArr objectAtIndex:indexPath.row];
    cell.textLabel.text = model.collegeName;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
