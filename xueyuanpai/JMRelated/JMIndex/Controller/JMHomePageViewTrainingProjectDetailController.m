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
    
    
    //创建左侧按钮
    [self createLeftBackNavBtn];
    
    
    //创建当前列表视图
    [self createTableView];

}

#pragma mark - 创建tableView列表视图
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_TOP_HEIGHT) style:UITableViewStyleGrouped];
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
