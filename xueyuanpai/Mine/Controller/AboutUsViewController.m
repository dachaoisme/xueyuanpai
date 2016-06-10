//
//  AboutUsViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AboutUsViewController.h"

#import "AboutUsTableViewCell.h"

@interface AboutUsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;


@property (nonatomic,strong)NSDictionary *dataDic;


@property (nonatomic,strong)UIButton *callButton;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataDic = [NSDictionary dictionary];
    
    self.title = @"关于我们";
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
    [self requestCallInformation];

    
}

#pragma mark - 请求关于我们详情信息
- (void)requestCallInformation{
    
    
    /*
     
     关于我们
     接口地址 ：v1/aboutus/index
     参数: 无
     返回结果:
     {
     "stat":1,
     "msg":"succ",
     "data":{
     "title":"\u5173\u4e8e\u6211\u4eec\u4e0a\u5e02",
     "telphone":"400-123-123-123",
     "content":" 2015\u5e744\u670828\u65e5\uff0c\u4e60\u8fd1\u"}
     }
     
     
     */
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]aboutUsWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model.responseCode ==ResponseCodeSuccess) {
            ///请求成功
            
            self.dataDic = model.responseCommonDic;
        
            NSString *phoneNumber = [self.dataDic objectForKey:@"telphone"];

            [self.callButton setTitle:[NSString stringWithFormat:@"联系我们%@",phoneNumber] forState:UIControlStateNormal];

            
            [self.tableView reloadData];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        }else{
            ///反馈失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    


    
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.tableHeaderView.hidden = YES;
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"AboutUsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    
    
    
    //拨打电话按钮
    
    float space = 16;
    float btnHeight = 44;
    float footViewHeight = 48;
    float btnWidth = SCREEN_WIDTH - 30;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footViewHeight)];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [submitBtn setTitle:@"确定提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [submitBtn setFrame:CGRectMake(space, space, btnWidth,btnHeight)];
    submitBtn.layer.cornerRadius = 10.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(contactAction) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:submitBtn];
    
    self.callButton = submitBtn;
    
    self.tableView.tableFooterView = backGroundView;

}

#pragma mark - 联系我们按钮
- (void)contactAction{
    
    NSString *phoneNumber = [self.dataDic objectForKey:@"telphone"];
    
    [CommonUtils callServiceWithTelephoneNum:phoneNumber];
    
}


#pragma mark - tableView代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  50+[self textHeight:[self.dataDic objectForKey:@"content"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    AboutUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = [self.dataDic objectForKey:@"title"];
    

    
    cell.contentLabel.text = [self.dataDic objectForKey:@"content"];
    
    cell.contentLabel.frame = CGRectMake(10, 100, SCREEN_WIDTH - 20, [self textHeight:[self.dataDic objectForKey:@"content"]]);
    
    
    return cell;
    
}


//自适应撑高
//计算字符串的frame
- (CGFloat)textHeight:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    //返回计算好的高度
    return rect.size.height;
    
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
