//
//  JMCommentListViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCommentListViewController.h"

#import "JMCommentListTableViewCell.h"
#import "JMCommentModel.h"
@interface JMCommentListViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    NSMutableArray *dataArray;
    int currentPage;
    int nextPage;
    int pageSize;
}
@property (nonatomic,strong)UITableView *tableView;

///评论视图
@property (strong, nonatomic) UIView *commentInputView;

///评论的textField
@property (strong,nonatomic)UITextField *commentTextField;

@end

@implementation JMCommentListViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - 创建评论视图
-(void) initCommentInputView
{
    
    _commentInputView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    _commentInputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_commentInputView];
    
    //创建评论的textField
    UITextField *commentTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 30 - 75, 30)];
    commentTextField.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    commentTextField.layer.cornerRadius = 4;
    commentTextField.layer.masksToBounds = YES;
    commentTextField.returnKeyType = UIReturnKeyDone;
    commentTextField.delegate = self;
    [self.commentInputView addSubview:commentTextField];
    self.commentTextField = commentTextField;
    
    //创建发布按钮
    UIButton *sendCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendCommentBtn.frame = CGRectMake(CGRectGetMaxX(commentTextField.frame) + 10, 10, 75, 30);
    [sendCommentBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendCommentBtn.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    sendCommentBtn.layer.cornerRadius = 4;
    sendCommentBtn.layer.masksToBounds = YES;
    [sendCommentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [self.commentInputView addSubview:sendCommentBtn];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"评论";
    currentPage=nextPage=1;
    pageSize=10;
    dataArray = [NSMutableArray array];
    
    
    [self createLeftBackNavBtn];
    
    [self createTableView];
    
    [self initCommentInputView];
    [self requestData];

}
-(void)requestData
{
    /*
     entity_id   string 序号      必需
     entity_type string 类型     必需   可选项: project 创业项目  salon创业沙龙 course 创业课程
     user_id      int   用户序号
     content     string 评论内容
     
     */
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.trainProjectId forKey:@"entity_id"];
    [dic setObject:ENTITY_TYPE_PROJECT forKey:@"entity_type"];
    [dic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:@"page"];
    [dic setObject:[NSString stringWithFormat:@"%d",pageSize] forKey:@"size"];
    
    [[HttpClient sharedInstance]getCommentListWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, HttpResponsePageModel *pageModel, NSDictionary *ListDic) {
        
        [self.tableView.footer endRefreshing];
        
        NSArray * listArray = [ListDic objectForKey:@"lists"];
        
        if (listArray.count == 0) {
            //说明是最后一张
            self.tableView.footer.state= MJRefreshFooterStateNoMoreData;
        }
        
        for (int i=0; i<listArray.count; i++) {
            NSDictionary *tempDic = [listArray objectAtIndex:i];
            JMCommentModel *model = [JMCommentModel yy_modelWithDictionary:tempDic];
            [dataArray addObject:model];
            [self.tableView reloadData];
        }
    } withFaileBlock:^(NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
}
-(void)requestMoreData
{
    nextPage=currentPage+1;
    [self requestData];
}
-(void)refreshData
{
    nextPage=currentPage=1;
    [self requestData];
}
#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[JMCommentListTableViewCell class] forCellReuseIdentifier:@"JMCommentListTableViewCell"];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JMCommentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JMCommentListTableViewCell"];
    JMCommentModel *model = [dataArray objectAtIndex:indexPath.row];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.user.icon] placeholderImage:[UIImage imageNamed: @"placeHoder"]];
    cell.nickNameLabel.text = model.user.nickname;
    cell.contentLabel.text = model.content;
    cell.timeLabel.text = model.create_time;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 82;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self.commentTextField becomeFirstResponder];
}


#pragma mark - 点击发送请求的评论接口
- (void)commentAction{
    
    //请求评论接口
    [self requestCommentWithContentText:self.commentTextField.text];
}

-(void)requestCommentWithContentText:(NSString *)text
{
    /*
     entity_id   string 序号      必需
     entity_type string 类型     必需   可选项: project 创业项目  salon创业沙龙 course 创业课程
     user_id      int   用户序号
     content     string 评论内容
     
     */
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.trainProjectId forKey:@"entity_id"];
    [dic setObject:@"project" forKey:@"entity_type"];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    
    [dic setObject:text forKey:@"content"];
    
    
    [[HttpClient sharedInstance]trainProjectAddCommentWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"评论成功"];
            
            self.commentTextField.text = @"";
            
            [self.commentTextField resignFirstResponder];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
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
