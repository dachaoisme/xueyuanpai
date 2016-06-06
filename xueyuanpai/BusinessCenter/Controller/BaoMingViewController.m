//
//  BaoMingViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/2.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaoMingViewController.h"

#import "PublishInformationOneStyleTableViewCell.h"
#import "PublishInformationTwoStyleTableViewCell.h"


#import "BaoMingSuccessViewController.h"

@interface BaoMingViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


@property (nonatomic,strong)UITableView *tableView;

///姓名
@property (nonatomic,strong)NSString *nameStr;

///专业
@property (nonatomic,strong)NSString *professionalStr;

///学校
@property (nonatomic,strong)NSString *schoolStr;

@end

@implementation BaoMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"报名";
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
    
    
    
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //设置tableView的footView
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 48);
    button.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tableView.tableFooterView = button;

    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"PublishInformationOneStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"PublishInformationTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    [tableView registerNib:[UINib nibWithNibName:@"PublishInformationOneStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"threeCell"];

}

#pragma mark - 提交按钮的响应方法
- (void)commitAction{
    
    [self requestToGetBusinessClassRoomDetail];
    
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        PublishInformationOneStyleTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        oneCell.titleLabel.text = @"你的姓名";
        oneCell.yuanLabel.hidden = YES;
        
        oneCell.inputContentTextField.tag = 100;
        
        
        oneCell.inputContentTextField.delegate = self;
        
        return oneCell;


        
    }else if(indexPath.row == 1){
        
        PublishInformationTwoStyleTableViewCell *twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
        twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        twoCell.titleLabel.text = @"学校";
        twoCell.contentLabel.text = @"吉林长春大学";
        
        self.schoolStr = twoCell.contentLabel.text;
        
        return twoCell;
        

    }else{
        

        PublishInformationOneStyleTableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        oneCell.titleLabel.text = @"专业";
        oneCell.yuanLabel.hidden = YES;
        
        
        oneCell.inputContentTextField.tag = 101;

        
        oneCell.inputContentTextField.delegate = self;

        
        return oneCell;


    }
    
    
}

#pragma mark - textField的代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 100) {
        
        self.nameStr = textField.text;

        
    }else if (textField.tag == 101){
        
        self.professionalStr = textField.text;

    }
    
    
    return YES;
}

#pragma mark - 请求创业讲堂详情数据
-(void)requestToGetBusinessClassRoomDetail
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.schoolRoomDetailModel.businessCenterSchoolRoomDetailId ?self.schoolRoomDetailModel.businessCenterSchoolRoomDetailId:@"" forKey:@"forum_id"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.nameStr forKey:@"name"];
    [dic setValue:self.schoolStr forKey:@"college"];
    [dic setValue:self.professionalStr forKey:@"major"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]businessCenterBaoMingWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            //报名成功
            [CommonUtils showToastWithStr:model.responseMsg];
            
#warning 后台缺少返回积分项
        
            //跳转成功界面
            BaoMingSuccessViewController *successVC = [[BaoMingSuccessViewController alloc] init];
            
            [self.navigationController pushViewController:successVC animated:YES];
            
            
            
            
        }else{
            
            [CommonUtils showToastWithStr:model.responseMsg];

            
            //跳转成功界面
            BaoMingSuccessViewController *successVC = [[BaoMingSuccessViewController alloc] init];
            
            [self.navigationController pushViewController:successVC animated:YES];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
