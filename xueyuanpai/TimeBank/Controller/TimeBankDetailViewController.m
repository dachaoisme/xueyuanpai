//
//  TimeBankDetailViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "TimeBankDetailViewController.h"
#import "TimeBankDetailOneStyleTableViewCell.h"
#import "TimeBankDetailTwoStyleTableViewCell.h"
#import "TimeBankDetailThreeTableViewCell.h"

@interface TimeBankDetailViewController ()<UITableViewDataSource,UITableViewDelegate,TimeBankDetailOneStyleTableViewCellDelegate,TimeBankDetailTwoStyleTableViewCellDelegate>
{
    TimeBankDetailModel * detailModel;
    ///时间银行浏览次数
    NSString * timeBankDetailScanViewNum;
    ///申请项目的时候，捎句话
    NSString * applyProjectWord;
    NSMutableArray * timeBankCommentListArr;
    
    BOOL yesIsCollection ;
    NSInteger pageSize;
    NSInteger pageNum;
}
@property (nonatomic,strong)UITableView * tableView;

///申请输入框
@property (nonatomic,strong)UITextField *commentTextField ;

///评论视图
@property (nonatomic,strong)UIView *commentView;
@property(nonatomic,strong)UIBarButtonItem * favoriteButtonItem;

@end

@implementation TimeBankDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setTitle:@"时间银行详情"];
    yesIsCollection = NO;
    pageSize=10;
    pageNum=1;
    [self createLeftBackNavBtn];
    

    [self p_setupShareButtonItem];
    timeBankCommentListArr = [NSMutableArray array];
    
    //创建tableView
    [self createTableView];
    
    //创建发送评论视图
    [self createSendCommentView];
    //请求数据
    [self requestToGetTimeBankDetail];
    [self requestToCommentList];
    [self requestToaddScanViewNum];
    [self checkoutIsCollectionOrNot];
}


#pragma mark - 创建发送评论视图
- (void)createSendCommentView{
    
    
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
    [self.view addSubview:commentView];
    
    self.commentView = commentView;
    
    UITextField *commentTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH - 100, 32)];
    commentTextField.borderStyle = UITextBorderStyleRoundedRect;
    [commentView addSubview:commentTextField];
    self.commentTextField = commentTextField;
    
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(CGRectGetMaxX(commentTextField.frame), 5, 100, 32);
    [sendButton setTitle:@"发送评论" forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendButton setTitleColor:[CommonUtils colorWithHex:@"00beaf"] forState:UIControlStateNormal];
    
    [sendButton addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:sendButton];
    
    
    commentView.hidden = YES;
    
}

#pragma mark - 发送评论
- (void)sendComment{
    
    [self requestToAddCommentWithCommentContent:self.commentTextField.text];

}

#pragma mark - tableview UITableViewDataSource,UITableViewDelegate
-(void)createTableView
{
    
    UITableView * tableView    = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40) style:UITableViewStylePlain];
    tableView.backgroundColor  = [CommonUtils colorWithHex:@"f3f3f3"];
    tableView.separatorInset   = UIEdgeInsetsZero;
    tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    tableView.dataSource       = self;
    tableView.delegate         = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"TimeBankDetailOneStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"TimeBankDetailTwoStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];
    
    
    [tableView registerNib:[UINib nibWithNibName:@"TimeBankDetailThreeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"threeCell"];
    
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreCommentList)];
}

#pragma mark - 设置分享按钮
- (void)p_setupShareButtonItem{
    
    //分享按钮
    UIBarButtonItem *shareButtonItem =[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickSharButtonItemAction:)];
    //收藏按钮
    _favoriteButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickFavoriteButtonItemAction:)];
    self.navigationItem.rightBarButtonItems = @[_favoriteButtonItem,shareButtonItem];
    
    
}

#pragma mark - 分享按钮
- (void)didClickSharButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [CommonUtils showToastWithStr:@"分享"];
}

#pragma mark - 收藏按钮
- (void)didClickFavoriteButtonItemAction:(UIBarButtonItem *)buttonItem
{
    if (yesIsCollection==YES) {
        [self cancelCollection];
    }else{
        [self addCollection];
    }
    
}

-(void)addCollection
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.timeBankId forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfTimeBank] forKey:@"type"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance] addCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (model.responseCode == ResponseCodeSuccess) {
            [_favoriteButtonItem setImage:[[UIImage imageNamed:@"nav_icon_fav_full"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            yesIsCollection = YES;
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
-(void)cancelCollection
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.timeBankId forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfTimeBank] forKey:@"type"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HttpClient sharedInstance] cancelCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (model.responseCode == ResponseCodeSuccess) {
            [_favoriteButtonItem setImage:[[UIImage imageNamed:@"nav_icon_fav"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            yesIsCollection = NO;
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}


-(void)checkoutIsCollectionOrNot
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.timeBankId forKey:@"obj_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)MineTypeOfTimeBank] forKey:@"type"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]checkCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if (model.responseCode == ResponseCodeSuccess) {
            NSInteger status = [[model.responseCommonDic objectForKey:@"stat"] integerValue];
            if (status==1) {
                ///已收藏
                [_favoriteButtonItem setImage:[[UIImage imageNamed:@"nav_icon_fav_full"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                yesIsCollection = YES;
            }else{
                ///未收藏
            }
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}

#pragma mark - tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        

        return timeBankCommentListArr.count + 1;
        
    }else{
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        TimeBankDetailOneStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.delegate = self;

        
        [cell bindModel:detailModel];
        

        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    } else {
        
        if (indexPath.row == 0) {
            
            TimeBankDetailTwoStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            cell.delegate = self;
            
            
            return cell;

        }else{
            
            
            TimeBankDetailThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            TimeBankCommentModel *model = [timeBankCommentListArr objectAtIndex:indexPath.row - 1];
            
            [cell bindModel:model];

            
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
           
            return 45;
        }else{
           
            return 100;
        }
    }else{
        
        return 300;
    }
    
    
}

#pragma mark - 获取申领状态按钮的响应事件
- (void)getActivityContentButtonStatus{
    
    if ([detailModel.timeBankDetailStat intValue] == 0) {
        
        //未申领
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你确定申请邀约吗？" message:@"\n\n" preferredStyle:UIAlertControllerStyleAlert];
        //这里就可以设置子控件的frame,但是alert的frame不可以设置
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 64, 240, 30)];//wight = 270;
        textField.placeholder = @"捎句话";
        textField.borderStyle = UITextBorderStyleRoundedRect;//设置边框的样式
        //添加子控件也是直接add
        [alert.view addSubview:textField];
        
        
        __weak typeof(self)weakSelf = self;
        
        //这跟 actionSheet有点类似了,因为都是UIAlertController里面的嘛
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"%@",textField.text);//控制台中打印出输入的内容
            
            
            applyProjectWord = textField.text;

            [weakSelf requestToApply];
            
            
            //修改状态
            detailModel.timeBankDetailStat = @"1";
            
            [weakSelf.tableView reloadData];
        
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        //添加按钮
        [alert addAction:ok];
        [alert addAction:cancel];

       
        //以modal的方式来弹出
        [self presentViewController:alert animated:YES completion:^{ }];
    }
}


#pragma mark - 添加评论按钮响应方法
- (void)addComment{
    
    _commentView.hidden = NO;
    [self.commentTextField becomeFirstResponder];
    
}


#pragma mark - 请求时间银行详情数据
-(void)requestToGetTimeBankDetail
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.timeBankId?self.timeBankId:@"" forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankDetailWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSDictionary * dataDic = model.responseCommonDic ;
            detailModel = [[TimeBankDetailModel alloc]initWithDic:dataDic];
            
            [self.tableView reloadData];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

#pragma mark - 申领项目
-(void)requestToApply
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setValue:self.timeBankId forKey:@"tb_id"];
    [dic setValue:applyProjectWord forKey:@"msg"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankProjectWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            
            [CommonUtils showToastWithStr:@"申领状态成功"];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}
#pragma mark - 增加浏览次数
-(void)requestToaddScanViewNum
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.timeBankId forKey:@"id"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankAddScanNumWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            NSDictionary * dataDic = model.responseCommonDic ;
            timeBankDetailScanViewNum = [dataDic stringForKey:@"views"];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
#pragma mark - 增加评论
-(void)requestToAddCommentWithCommentContent:(NSString *)commentContent
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [dic setObject:self.timeBankId forKey:@"bank_id"];
    [dic setObject:commentContent forKey:@"content"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankAddCommentWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ///获取查询条件
        if (model.responseCode == ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"评论成功"];
            
            
            self.commentTextField.text = @"";
            [self.commentTextField resignFirstResponder];
            
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

#pragma mark - 评论列表
-(void)requestToCommentList
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.timeBankId forKey:@"bank_id"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:@"page"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)pageSize] forKey:@"size"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]timeBankCommentListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
        ///获取查询条件
        if (responseModel.responseCode == ResponseCodeSuccess) {
            NSArray * arr = [responseModel.responseCommonDic objectForKey:@"lists"];
            
            for (NSDictionary * dic in arr) {
                TimeBankCommentModel * commentModel = [[TimeBankCommentModel alloc]initWithDic:dic];
                
                [timeBankCommentListArr addObject:commentModel];
            }
            ///处理上拉加载更多逻辑
            if (pageNum>=[pageModel.responsePageTotalCount integerValue]) {
                //说明是最后一张
                self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
            }
            
            [self.tableView reloadData];
            
        }else{
            [CommonUtils showToastWithStr:responseModel.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView.footer endRefreshing];
    }];
    
}
-(void)requestMoreCommentList
{
    pageNum = pageNum+1;
    [self requestToCommentList];
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
