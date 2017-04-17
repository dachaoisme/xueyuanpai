//
//  JMCourseDetailsViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCourseDetailsViewController.h"

#import "JMCourseDetailOneTableViewCell.h"
#import "JMSignUpTrainingProjectViewController.h"
#import "JMCommentListViewController.h"
@interface JMCourseDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    JMCourseModel *detailModel;
    UIButton *zanBtn;
}

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMCourseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///创业课程详情【线上】
    self.title = @"创业课程详情";
    
    [self createLeftBackNavBtn];
    //创建当前列表视图
    [self createTableView];
    
    //创建底部视图
    [self createBottomView];
    
    [self requestData];
}
-(void)requestData
{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.model.courseItemId forKey:@"course_id"];
    [[HttpClient sharedInstance] getTrainCourseDetailWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *responseModel, NSDictionary *listDic) {
        detailModel = [JMCourseModel   yy_modelWithDictionary:listDic];
        //创建底部视图我要报名
        [self createBottomView];
        [self whetherAlreadyZan];
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
    [self.view addSubview:_tableView];
    
    
    //注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[JMCourseDetailOneTableViewCell class] forCellReuseIdentifier:@"JMCourseDetailOneTableViewCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [CommonUtils colorWithHex:@"3f4446"];

    
    
    switch (indexPath.row) {
        case 0:
        {
            
            cell.textLabel.text = detailModel.title;
            cell.textLabel.font = [UIFont systemFontOfSize:21];
            
            return cell;

        }
            break;
        case 1:
        {
            
            cell.textLabel.text =[NSString stringWithFormat:@"%@    %@",detailModel.course_time,detailModel.author];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            
            return cell;

        }
            break;
        case 2:
        {
            
            JMCourseDetailOneTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"JMCourseDetailOneTableViewCell"];
            [imageCell.showImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.thumbUrl] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
            return imageCell;
            
        }
            break;
            
        default:{
            
            cell.textLabel.text = detailModel.content;
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.numberOfLines = 0;

        }
            return cell;
            
            
            break;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            return 50;
            break;
        case 1:
            return 30;
            break;
        case 2:
            return 220;
            break;

            
        default:{
            NSString *text = detailModel.content;
            
            return [self textHeight:text] + 30;
            
        }

            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
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
    collectionBtn.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    collectionBtn.layer.cornerRadius = 4;
    [collectionBtn setTitle:[NSString stringWithFormat:@"我要参加 %@",self.model.count_mark] forState:UIControlStateNormal];
    collectionBtn.layer.masksToBounds = YES;
    collectionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    collectionBtn.frame = CGRectMake(CGRectGetMaxX(zanBtn.frame) + interval, 10, 108, 30);
    [collectionBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:collectionBtn];
    
    
    //右侧评论按钮
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setImage:[UIImage imageNamed:@"detail_icon_chat"] forState:UIControlStateNormal];
    commentBtn.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    commentBtn.layer.cornerRadius = 4;
    commentBtn.layer.masksToBounds = YES;
    [commentBtn setTitle:self.model.count_comment forState:UIControlStateNormal];
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
    [dic setObject:self.model.courseItemId forKey:@"course_id"];
    if ([UserAccountManager sharedInstance].userId) {
        [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    }
    [[HttpClient sharedInstance]whetherTrainCourseAlreadyAddFavouriteWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
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
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.courseItemId forKey:@"course_id"];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [[HttpClient sharedInstance]trainCourseAddFavouriteWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
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
    signUpAction.entity_id = self.model.courseItemId;
    signUpAction.entity_type = ENTITY_TYPE_COURSE;
    [self.navigationController pushViewController:signUpAction animated:YES];
}
#pragma mark - 评论
- (void)commentAction{
    
    //跳转评论详情界面
    JMCommentListViewController *commentListVC = [[JMCommentListViewController alloc] init];
    commentListVC.entity_id = self.model.courseItemId;
    commentListVC.entity_type = ENTITY_TYPE_COURSE;
    [self.navigationController pushViewController:commentListVC animated:YES];
    
    
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
