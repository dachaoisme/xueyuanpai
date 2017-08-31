//
//  JMSalonDetailViewController.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSalonDetailViewController.h"

#import "JMCourseDetailTwoTableViewCell.h"
#import "JMXianXiaCourseDetailsTableViewCell.h"
#import "JMCourseDetailOneTableViewCell.h"
#import "JMSignUpTrainingProjectViewController.h"
#import "JMCommentListViewController.h"

#import "JMSignUpProcessingViewController.h"
@interface JMSalonDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

{
    JMSalonModel *detailModel;
    UIButton *zanBtn;
    UIButton *commentBtn;
    UIButton *collectionBtn;
    SignupType signupType;
    float webViewHeight;
    
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIWebView *webView;



@end

@implementation JMSalonDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //修改评论数目
    [self changeCommentCount];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///创业课程详情【线下】
    self.title = @"沙龙详情";
    signupType = UnSignup;
    [self createLeftBackNavBtn];
    //创建当前列表视图
    [self createTableView];
    
    [self requestData];
    
    [self getStarsStaus];
    
}

-(void)requestData
{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.model.salonItemId forKey:@"salon_id"];
    [[HttpClient sharedInstance] getTrainSalonDetailWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        detailModel = [JMSalonModel  yy_modelWithDictionary:listDic];
        //创建底部视图我要报名
        [self createBottomView];
        [self whetherAlreadyZan];
        [self whetherAlreadyCollection];
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
    
}
#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor=[CommonUtils colorWithHex:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[JMCourseDetailOneTableViewCell class] forCellReuseIdentifier:@"JMCourseDetailOneTableViewCell"];
    [_tableView registerClass:[JMCourseDetailTwoTableViewCell class] forCellReuseIdentifier:@"JMCourseDetailTwoTableViewCell"];
    [_tableView registerClass:[JMXianXiaCourseDetailsTableViewCell class] forCellReuseIdentifier:@"JMXianXiaCourseDetailsTableViewCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
            
            break;
            
            
        default:
            
            return 3;
            
            break;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 0:{
            JMCourseDetailTwoTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"JMCourseDetailTwoTableViewCell"];
            
            [detailCell.locationBtn setTitle:detailModel.colllege_name forState:UIControlStateNormal];
            detailCell.titleLabel.text = detailModel.title;
            detailCell.contentLabel.text = detailModel.salonDescription;
            detailCell.courseTimeLabel.text = detailModel.course_time;
            detailCell.showLocationLabel.text = detailModel.course_addr;
            
            return detailCell;
        }
            break;
            
        default:{
            
            if (indexPath.row == 0) {
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = [CommonUtils colorWithHex:@"999999"];
                cell.textLabel.text = @"活动描述";
                return cell;
                
            }else if (indexPath.row == 1){
                JMCourseDetailOneTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"JMCourseDetailOneTableViewCell"];
                
                [imageCell.showImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.thumbUrl] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
                return imageCell;
                
                
                
            }else{
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //cell.textLabel.textColor = [CommonUtils colorWithHex:@"333333"];
                //cell.textLabel.text = detailModel.content;
                //cell.textLabel.font = [UIFont systemFontOfSize:14];
                //cell.textLabel.numberOfLines = 0;
                if (detailModel.content) {
                    if (!_webView) {
                        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-10, cell.contentView.bounds.size.height)];
                        _webView.backgroundColor = [UIColor redColor];
                        _webView.scrollView.userInteractionEnabled = NO;
                        _webView.delegate = self;
                        [cell.contentView addSubview:_webView];
                        NSString *content =[NSString stringWithFormat:@"%@%@",@" <style>img{max-width: 300px;height: auto;}</style>",detailModel.content];
                        [_webView loadHTMLString:content baseURL:nil];
                    }else{
                        _webView.frame =  CGRectMake(0, 0, SCREEN_WIDTH, webViewHeight);
                    }
                    
                }
                return cell;
                
            }
            
            
            
            
        }
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 230;
            break;
        default:{
            
            if (indexPath.row == 0) {
                return 40;
                
            }else if (indexPath.row == 1){
                
                return 220;
                
            }else{
                
//                UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
//                [webView loadHTMLString:detailModel.content baseURL:nil];
//                //根据文本信息多少调整cell的高度
//                //NSString * showText = detailModel.content;
//                //float textHeight = [self hideLabelLayoutHeight:showText withTextFontSize:14];
//                NSLog(@"webView.frame.size.height=%ld",webView.frame.size.height);
//                return webView.frame.size.height;
                return  webViewHeight;
            }
        }
            
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}


//自适应撑高
//计算字符串的frame
- (CGFloat)textHeight:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 10, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    //返回计算好的高度
    return rect.size.height;
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取高度：
    CGFloat height = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    NSLog(@"height:%f",height);
    webViewHeight  =height+60;
    NSLog(@"webViewHeight:%f",webViewHeight);
    //刷新界面：
    [self.tableView reloadData];
}

#pragma mark - 创建底部视图
- (void)createBottomView{
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    [self.view addSubview:bottomView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [CommonUtils colorWithHex:@"cccccc"];
    [bottomView addSubview:lineView];
    
    
    
    //创建左侧点赞按钮
    zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zanBtn setImage:[UIImage imageNamed:@"detail_icon_like"] forState:UIControlStateNormal];
    [zanBtn setImage:[UIImage imageNamed:@"zan_hl"] forState:UIControlStateSelected];
    [zanBtn setTitle:[NSString stringWithFormat:@" %@",self.model.count_like] forState:UIControlStateNormal];
    zanBtn.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    zanBtn.layer.cornerRadius = 4;
    zanBtn.layer.masksToBounds = YES;
    zanBtn.frame = CGRectMake(10, 10, 75, 30);
    zanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [zanBtn setTitleColor:[CommonUtils colorWithHex:@"35373a"] forState:UIControlStateNormal];
    [zanBtn addTarget:self action:@selector(zanAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:zanBtn];
    
    CGFloat interval = (SCREEN_WIDTH - 20 - 75*2 - 108)/2;
    
    //中间的报名按钮
    collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionBtn setImage:[UIImage imageNamed:@"detail_icon_join"] forState:UIControlStateNormal];
    collectionBtn.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    collectionBtn.layer.cornerRadius = 4;
    collectionBtn.layer.masksToBounds = YES;
    [collectionBtn setTitle:[NSString stringWithFormat:@" 我要参加 %@",self.model.count_partin] forState:UIControlStateNormal];
    collectionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    collectionBtn.frame = CGRectMake(CGRectGetMaxX(zanBtn.frame) + interval, 10, 108, 30);
    [collectionBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:collectionBtn];
    
    
    //右侧评论按钮
    commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setImage:[UIImage imageNamed:@"detail_icon_chat"] forState:UIControlStateNormal];
    [commentBtn setTitle:[NSString stringWithFormat:@" %@",self.model.count_comment] forState:UIControlStateNormal];
    commentBtn.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    commentBtn.layer.cornerRadius = 4;
    commentBtn.layer.masksToBounds = YES;
    commentBtn.frame = CGRectMake(CGRectGetMaxX(collectionBtn.frame) + interval, 10, 75, 30);
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [commentBtn setTitleColor:[CommonUtils colorWithHex:@"35373a"] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:commentBtn];
    
    
    
    
}

#pragma mark - 点赞
-(void)whetherAlreadyZan
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.salonItemId forKey:@"salon_id"];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [[HttpClient sharedInstance]whetherTrainSalonAlreadyAddFavouriteWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSDictionary *dic = model.responseCommonDic;
        NSString *isLiked =[dic objectForKey:@"is_liked"];
        if (isLiked &&[isLiked integerValue]==1) {
            ///1点赞过 0 没有
            zanBtn.selected = YES;
        }else{
            zanBtn.selected = NO;
        }
        if ([dic valueForKey:@"count"]){
            int zanCount = [[dic valueForKey:@"count"] intValue];
            [zanBtn setTitle:[NSString stringWithFormat:@" %d",zanCount] forState:UIControlStateNormal];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
#pragma mark - 点赞事件
- (void)zanAction{
    if ([UserAccountManager sharedInstance].isLogin==NO) {
        [self judgeLoginStatus];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.salonItemId forKey:@"salon_id"];
    [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance]trainSalonAddFavouriteWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode ==ResponseCodeSuccess) {
            if (zanBtn.isSelected==YES) {
                zanBtn.selected =NO;
                NSInteger zanCount = [zanBtn.titleLabel.text integerValue]-1;
                if (zanCount<0) {
                    zanCount=0;
                }
                [zanBtn setTitle:[NSString stringWithFormat:@" %ld",zanCount] forState:UIControlStateNormal];
            }else{
                zanBtn.selected = YES;
                NSInteger zanCount = [zanBtn.titleLabel.text integerValue]+1;
                [zanBtn setTitle:[NSString stringWithFormat:@" %ld",zanCount] forState:UIControlStateNormal];
            }
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
    
}
#pragma mark - 报名
-(void)whetherAlreadyCollection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.salonItemId forKey:@"entity_id"];
    [dic setObject:ENTITY_TYPE_SALON forKey:@"entity_type"];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [[HttpClient sharedInstance]whetherAlreadyCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        
        if (model.responseCode==ResponseCodeSuccess) {
            int status =[model.status intValue];
            signupType = status;
            if (status==UnSignup) {
                [collectionBtn setTitle:[NSString stringWithFormat:@" 我要报名 %d",[detailModel.count_partin intValue]+1] forState:UIControlStateNormal];
            }else if (status==Processing){
                [collectionBtn setTitle:[NSString stringWithFormat:@" 审核中 %d",[detailModel.count_partin intValue]+1] forState:UIControlStateNormal];
            }else if (status==Pass){
                [collectionBtn setTitle:[NSString stringWithFormat:@" 已报名 %d",[detailModel.count_partin intValue]+1] forState:UIControlStateNormal];
            }else{
                [collectionBtn setTitle:[NSString stringWithFormat:@" 已驳回 %d",[detailModel.count_partin intValue]+1] forState:UIControlStateNormal];
            }
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
- (void)collectionAction{
    
    if (signupType ==UnSignup) {
        JMSignUpTrainingProjectViewController *signUpAction = [[JMSignUpTrainingProjectViewController alloc] init];
        signUpAction.entity_id = self.model.salonItemId;
        signUpAction.entity_type = ENTITY_TYPE_SALON;
        signUpAction.returnBlock = ^{
            signupType = Processing;
            [collectionBtn setTitle:[NSString stringWithFormat:@" 审核中 %d",[detailModel.count_partin intValue]+1] forState:UIControlStateNormal];
        };
        [self.navigationController pushViewController:signUpAction animated:YES];
    }else{
        JMSignUpProcessingViewController *signUpProcessingVC =[[JMSignUpProcessingViewController alloc] init];
        signUpProcessingVC.entity_type = ENTITY_TYPE_SALON;
        signUpProcessingVC.entity_id =self.model.salonItemId;
        signUpProcessingVC.image = detailModel.thumbUrl;
        signUpProcessingVC.theTitle = detailModel.title;
        signUpProcessingVC.subTitle = detailModel.salonDescription;
        signUpProcessingVC.colledge_name = detailModel.colllege_name;
        signUpProcessingVC.status = signupType;
        [self.navigationController pushViewController:signUpProcessingVC animated:YES];
    }
}
#pragma mark - 评论
- (void)commentAction{
    
    //跳转评论详情界面
    JMCommentListViewController *commentListVC = [[JMCommentListViewController alloc] init];
    commentListVC.entity_id = self.model.salonItemId;
    commentListVC.entity_type = ENTITY_TYPE_SALON;
    [self.navigationController pushViewController:commentListVC animated:YES];
    
    
}

#pragma mark - 是否已经收藏
-(void)getStarsStaus
{
    ///网络请求获取是否已经收藏的状态
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [dic setObject:ENTITY_TYPE_SALON forKey:@"entity_type"];
    [dic setObject:self.model.salonItemId forKey:@"entity_id"];
    
    [[HttpClient sharedInstance]whetherAlreadyAddCollectionWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSDictionary *dic = model.responseCommonDic;
        NSString *isLiked =[dic objectForKey:@"ismarked"];
        [self judgeWhtherHaveAddStarWithStatus:[isLiked integerValue]];
        
    } withFaileBlock:^(NSError *error) {
        
    }];
    
}
-(void)judgeWhtherHaveAddStarWithStatus:(BOOL)yesHaveAddStar
{
    [self creatRightNavWithNormalImageName:@"detail_icon_star" selectedImageName:@"detail_icon_star_hl"];
    self.userDefineLeftBtn.selected = yesHaveAddStar;
}
-(void)rightItemActionWithBtn:(UIButton *)sender
{
    if (sender.selected==YES) {
        [self cancelCollection];
    }else{
        [self addCollection];
    }
    self.userDefineLeftBtn.selected=!sender.isSelected;
    
}
-(void)addCollection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [dic setObject:ENTITY_TYPE_SALON forKey:@"entity_type"];
    [dic setObject:self.model.salonItemId forKey:@"entity_id"];
    
    [[HttpClient sharedInstance]collectWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSDictionary *dic = model.responseCommonDic;
        
    } withFaileBlock:^(NSError *error) {
        
    }];
}

-(void)cancelCollection
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setValue:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [dic setObject:ENTITY_TYPE_SALON forKey:@"entity_type"];
    [dic setObject:self.model.salonItemId forKey:@"entity_id"];
    
    [[HttpClient sharedInstance]deleteCollectWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        NSDictionary *dic = model.responseCommonDic;
        
    } withFaileBlock:^(NSError *error) {
        
    }];
}

- (void)changeCommentCount{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.model.salonItemId forKey:@"salon_id"];
    [[HttpClient sharedInstance] getTrainSalonDetailWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        detailModel = [JMSalonModel  yy_modelWithDictionary:listDic];
        
        
        [commentBtn setTitle:[NSString stringWithFormat:@" %@",detailModel.count_comment] forState:UIControlStateNormal];

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
