//
//  EditProfileViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "EditProfileViewController.h"

#import "EditProfileTableViewCell.h"

@interface EditProfileViewController ()<UITableViewDelegate,UITableViewDataSource>

///选择头像的按钮
@property (nonatomic,strong)UIButton *headImageSelectedBtn;


@property (nonatomic,strong)UITableView *tableView;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    
    
    self.title = @"编辑个人资料";
    
    [self createLeftBackNavBtn];
    
    [self setContentView];
    
    [self createTableView];
    
    //创建提交按钮
    [self createCommitButton];
}

#pragma mark - 创建提交按钮
- (void)createCommitButton{
    
    //确定按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, CGRectGetMaxY(self.tableView.frame) + 10, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 10.0;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button];

    
}

#pragma mark - 提交按钮
- (void)commitAction{
    
    [CommonUtils showToastWithStr:@"提交"];
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 250) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"EditProfileTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
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
    }
    

    
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        
        cell.titleLabel.text = @"昵称";
        cell.contentLabel.text = [UserAccountManager sharedInstance].userNickname;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if (indexPath.row == 1) {
        
        cell.titleLabel.text = @"性别";
        
        if ([UserAccountManager sharedInstance].userSex == UserInfoSexMan) {
          
            cell.contentLabel.text = @"男";

        }else if ([UserAccountManager sharedInstance].userSex == UserInfoSexWoman){
            
            cell.contentLabel.text = @"女";
        }else{
            
            cell.contentLabel.text = @"未知";
        }
        
    }else if (indexPath.row == 2) {
        
        cell.titleLabel.text = @"生日";
        cell.contentLabel.text = @"";
        
    }else if (indexPath.row == 3) {
        
        cell.titleLabel.text = @"学校";
        cell.contentLabel.text = [UserAccountManager sharedInstance].userCollegeName;
        
    }else if (indexPath.row == 4) {
        
        cell.titleLabel.text = @"年级";
        cell.contentLabel.text = @"";
        
    }



    
    return cell;
    
}

#pragma mark - 从相册中选择图片

-(void)selectedImageFromPhotoAlbum:(UIButton *)sender
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
