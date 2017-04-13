//
//  JMHomePageViewTrainingProjectDetailController.m
//  xueyuanpai
//
//  Created by 王园园 on 17/4/11.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMHomePageViewTrainingProjectDetailController.h"

#import "HomePageDetailOneTypeTableViewCell.h"
#import "HomePageDetailTwoTypeTableViewCell.h"

#import "JMSignUpTrainingProjectViewController.h"
#import "JMHomePageModel.h"

#import "CommentInputView.h"

@interface JMHomePageViewTrainingProjectDetailController ()<UITableViewDelegate,UITableViewDataSource,CommentInputViewDelegate>
{
    JMTrainProjectDetailModel *detailModel;
    UIButton *zanBtn;
    UIButton *commentBtn;
}
@property (nonatomic,strong)UITableView *tableView;


///评论视图
@property (strong, nonatomic) CommentInputView *commentInputView;

@end

@implementation JMHomePageViewTrainingProjectDetailController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
    
    
    //添加评论视图的监听
    [_commentInputView addNotify];
    
    [_commentInputView addObserver];
    

}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //[self theTabBarHidden:YES];
    
    [_commentInputView removeNotify];
    
    [_commentInputView removeObserver];
    
}

#pragma mark - 创建评论视图
-(void) initCommentInputView
{
    if (_commentInputView == nil) {
        _commentInputView = [[CommentInputView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _commentInputView.hidden = YES;
        _commentInputView.delegate = self;
        [self.view addSubview:_commentInputView];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    ///未结束报名的实训项目详情
    
    
    //创建左侧按钮
    [self createLeftBackNavBtn];
    
    
    //创建当前列表视图
    [self createTableView];
    
    
    [self initCommentInputView];
   
    
    [self requestData];

}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[HomePageDetailOneTypeTableViewCell class] forCellReuseIdentifier:@"HomePageDetailOneTypeTableViewCell"];

    [_tableView registerClass:[HomePageDetailTwoTypeTableViewCell class] forCellReuseIdentifier:@"HomePageDetailTwoTypeTableViewCell"];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)requestData
{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.model.trainProjectId forKey:@"project_id"];
    //[dic setObject:self.model.trainProjectId  forKey:@"project_id"];
    [[HttpClient sharedInstance] getTrainProjectDetailWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        detailModel = [JMTrainProjectDetailModel yy_modelWithDictionary:listDic];
        //创建底部视图我要报名
        [self createBottomView];
        [self whetherAlreadyZan];
        [self.tableView reloadData];
    } withFaileBlock:^(NSError *error) {
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 2 || section == 3) {
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
            HomePageDetailOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageDetailOneTypeTableViewCell"];
            cell.titleLabel.text = detailModel.title;
            [cell.locationBtn setTitle:detailModel.colllege_name forState:UIControlStateNormal];
            cell.timeLabel.text = detailModel.create_time;
            return cell;
 
            
        }
            break;
        case 1:{
            HomePageDetailTwoTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageDetailTwoTypeTableViewCell"];
            cell.showNatureBottomLabel.text = detailModel.type;
            cell.showTimeBottomLabel.text  =detailModel.end_time;
            return cell;
            
            
        }
            break;


            
        case 2:{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
            if (indexPath.row == 0) {
                
                cell.textLabel.textColor = [CommonUtils colorWithHex:@"999999"];
                
                cell.textLabel.text = @"招募岗位";
                
                
            }else{
                
                cell.textLabel.textColor = [CommonUtils colorWithHex:@"333333"];
                NSString *showText = detailModel.job_name;
                cell.textLabel.text =  showText;
                cell.textLabel.numberOfLines = 0;
                
                cell.textLabel.frame =  CGRectMake(5, 5, SCREEN_WIDTH - 10, [self textHeight:showText]);
            }
            
            
            
            return cell;
            
            
            
        }
            break;
            
        case 3:{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
            if (indexPath.row == 0) {
                
                cell.textLabel.textColor = [CommonUtils colorWithHex:@"999999"];
                
                cell.textLabel.text = @"项目描述";
                
                
            }else{
                
                cell.textLabel.textColor = [CommonUtils colorWithHex:@"333333"];
                NSString *showText = detailModel.trainProjectDescription;
                cell.textLabel.text =  showText;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.frame =  CGRectMake(5, 5, SCREEN_WIDTH - 10, [self textHeight:showText]);
            }
            
            
            
            return cell;
            
            
            
        }
            break;

   
            
        default:
        {
            
            UITableViewCell *cell = nil;
            
            return cell;
            
        }
            break;
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 2:{
            
            if (indexPath.row == 0) {
                
                return 45;
                
            }else{
                
                //根据文本信息多少调整cell的高度
                NSString * string = detailModel.job_name;
                return [self textHeight:string];
                
            }
            

        }
            break;
        case 3:{
            
            if (indexPath.row == 0) {
                
                return 45;
                
            }else{
                
                //根据文本信息多少调整cell的高度
                NSString * string = detailModel.trainProjectDescription;
                return [self textHeight:string];
                
            }

            
        }
            break;

            
        default:{
           
            return 80;

            
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
    [zanBtn setTitle:self.model.count_like forState:UIControlStateNormal];
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
    UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionBtn setImage:[UIImage imageNamed:@"detail_icon_join"] forState:UIControlStateNormal];
    [collectionBtn setTitle:self.model.recruitment_number forState:UIControlStateNormal];
    collectionBtn.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    collectionBtn.layer.cornerRadius = 4;
    collectionBtn.layer.masksToBounds = YES;
    collectionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    collectionBtn.frame = CGRectMake(CGRectGetMaxX(zanBtn.frame) + interval, 10, 108, 30);
    [collectionBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:collectionBtn];
    
    
    //右侧评论按钮
    commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setImage:[UIImage imageNamed:@"detail_icon_chat"] forState:UIControlStateNormal];
    [commentBtn setTitle:self.model.count_comment forState:UIControlStateNormal];
    commentBtn.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    commentBtn.layer.cornerRadius = 4;
    commentBtn.layer.masksToBounds = YES;
    commentBtn.frame = CGRectMake(CGRectGetMaxX(collectionBtn.frame) + interval, 10, 75, 30);
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [commentBtn setTitleColor:[CommonUtils colorWithHex:@"35373a"] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:commentBtn];

    
    
    
}

-(void)whetherAlreadyZan
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.trainProjectId forKey:@"project_id"];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [[HttpClient sharedInstance]whetherAlreadyAddFavouriteWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
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
            [zanBtn setTitle:[NSString stringWithFormat:@"%d",zanCount] forState:UIControlStateNormal];
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
}
#pragma mark - 点赞事件
- (void)zanAction{
    
    [CommonUtils showToastWithStr:@"点赞"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.trainProjectId forKey:@"project_id"];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance]trainProjectAddFavouriteWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode ==ResponseCodeSuccess) {
            if (zanBtn.isSelected==YES) {
                zanBtn.selected =NO;
                NSInteger zanCount = [zanBtn.titleLabel.text integerValue]-1;
                if (zanCount<0) {
                    zanCount=0;
                }
                [zanBtn setTitle:[NSString stringWithFormat:@"%ld",zanCount] forState:UIControlStateNormal];
            }else{
                zanBtn.selected = YES;
                NSInteger zanCount = [zanBtn.titleLabel.text integerValue]+1;
                [zanBtn setTitle:[NSString stringWithFormat:@"%ld",zanCount] forState:UIControlStateNormal];
            }
        }
    } withFaileBlock:^(NSError *error) {
        
    }];
    
}
#pragma mark - 报名
- (void)collectionAction{
    
//    [CommonUtils showToastWithStr:@"报名"];
    
    JMSignUpTrainingProjectViewController *signUpAction = [[JMSignUpTrainingProjectViewController alloc] init];
    signUpAction.trainProjectId = self.model.trainProjectId;
    [self.navigationController pushViewController:signUpAction animated:YES];
}
#pragma mark - 评论
- (void)commentAction{
    
    _commentInputView.hidden = NO;

    [_commentInputView show];

}

#pragma mark - 点击发送请求的评论接口
-(void) onCommentCreate:(long long ) commentId text:(NSString *) text{
    
    //请求评论接口
    [self requestCommentWithContentText:text];
    
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
    [dic setObject:self.model.trainProjectId forKey:@"entity_id"];
    [dic setObject:@"project" forKey:@"entity_type"];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    
    [dic setObject:text forKey:@"content"];
    
    
    [[HttpClient sharedInstance]trainProjectAddCommentWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"评论成功"];
        }
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
