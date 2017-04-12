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

@interface JMHomePageViewTrainingProjectDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation JMHomePageViewTrainingProjectDetailController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self theTabBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    ///未结束报名的实训项目详情
    
    
    //创建左侧按钮
    [self createLeftBackNavBtn];
    
    
    //创建当前列表视图
    [self createTableView];
    
    
    //创建底部视图我要报名
    [self createBottomView];

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
            
            
            return cell;
 
            
        }
            break;
        case 1:{
            HomePageDetailTwoTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageDetailTwoTypeTableViewCell"];
            
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
                NSString *showText = @"市场营销人员、铲平景丽";
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
                NSString *showText = @"随着大学校园内掀起倡导的低碳环保热潮，高校学生教材及其他书籍的目前的处理方式已被大多人所关注。为了积极响应构建资源节约型、环境友好型社会的时代要求，减轻学生的经济负担，提高教材及其他书籍的循环利用，倡导绿色校园建设，建立一个高校二手书市场显得尤为重要。";
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
                NSString * string = @"市场营销人员、铲平景丽";
                return [self textHeight:string];
                
            }
            

        }
            break;
        case 3:{
            
            if (indexPath.row == 0) {
                
                return 45;
                
            }else{
                
                //根据文本信息多少调整cell的高度
                NSString * string = @"随着大学校园内掀起倡导的低碳环保热潮，高校学生教材及其他书籍的目前的处理方式已被大多人所关注。为了积极响应构建资源节约型、环境友好型社会的时代要求，减轻学生的经济负担，提高教材及其他书籍的循环利用，倡导绿色校园建设，建立一个高校二手书市场显得尤为重要。";
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
    UIButton *zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zanBtn setImage:[UIImage imageNamed:@"detail_icon_like"] forState:UIControlStateNormal];
    [zanBtn setTitle:@"4" forState:UIControlStateNormal];
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
    [collectionBtn setTitle:@" 我要报名 34" forState:UIControlStateNormal];
    collectionBtn.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    collectionBtn.layer.cornerRadius = 4;
    collectionBtn.layer.masksToBounds = YES;
    collectionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    collectionBtn.frame = CGRectMake(CGRectGetMaxX(zanBtn.frame) + interval, 10, 108, 30);
    [collectionBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:collectionBtn];
    
    
    //右侧评论按钮
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setImage:[UIImage imageNamed:@"detail_icon_chat"] forState:UIControlStateNormal];
    [commentBtn setTitle:@"4" forState:UIControlStateNormal];
    commentBtn.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    commentBtn.layer.cornerRadius = 4;
    commentBtn.layer.masksToBounds = YES;
    commentBtn.frame = CGRectMake(CGRectGetMaxX(collectionBtn.frame) + interval, 10, 75, 30);
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [commentBtn setTitleColor:[CommonUtils colorWithHex:@"35373a"] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:commentBtn];

    
    
    
}

#pragma mark - 点赞事件
- (void)zanAction{
    
    [CommonUtils showToastWithStr:@"点赞"];
}

- (void)collectionAction{
    
//    [CommonUtils showToastWithStr:@"报名"];
    
    JMSignUpTrainingProjectViewController *signUpAction = [[JMSignUpTrainingProjectViewController alloc] init];
    [self.navigationController pushViewController:signUpAction animated:YES];
}

- (void)commentAction{
    
    [CommonUtils showToastWithStr:@"评论"];
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
