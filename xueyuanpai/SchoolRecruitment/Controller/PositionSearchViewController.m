//
//  PositionSearchViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "PositionSearchViewController.h"
#import "LTPickerView.h"
#import "SchoolRecruitmentModel.h"
#import "EmploymentRecruitmentViewController.h"
@interface PositionSearchViewController ()<UITextFieldDelegate>
{
    UIButton *submitBtn;
    UITextField * keyWordsTextField;
    UIButton * fullTimeBtn;
    UIButton * unFullTimeBtn;
    
    UIButton * schoolingEducationalBtn;
    UIButton * salaryBtn;
    
    UIButton * workAreaBtn;
    
    UIButton * sexUnlimitedBtn;
    UIButton * manBtn;
    UIButton * woManBtn;
    
}
@end

@implementation PositionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"职位搜索";
    self.view.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    [self createLeftBackNavBtn];
    [self setContentView];
}

-(void)setContentView
{
    float space = 16;
    float height = 44;
    float leftWidth = 60;
    float rightArrowWidth = 20;
    float btnWidth = 60;
    float centerWidth = SCREEN_WIDTH - 2*space - leftWidth - rightArrowWidth;
    ///关键字
    UIView * keyWordsView = [UIFactory viewWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH, height) backgroundColor:@"ffffff"];
    [self.view addSubview:keyWordsView];
    UILabel * keyWordsLable = [UIFactory label:CGRectMake(space, 0, leftWidth, height) size:14 color:@"00beaf" align:NSTextAlignmentLeft];
    keyWordsLable.text = @"关键字";
    [keyWordsView addSubview:keyWordsLable];
    keyWordsTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(keyWordsLable.frame), 0, centerWidth, height)];
    keyWordsTextField.backgroundColor = [UIColor whiteColor];
    keyWordsTextField.font = [UIFont systemFontOfSize:14];
    keyWordsTextField.textAlignment = NSTextAlignmentRight;
    keyWordsTextField.delegate = self;
    keyWordsTextField.tag = 10001;
    keyWordsTextField.placeholder = @"请输入职位名称或者公司名称)";
    [keyWordsView addSubview:keyWordsTextField];
    ///工作性质
    UIView * jobPropertyView = [UIFactory viewWithFrame:CGRectMake(0, CGRectGetMaxY(keyWordsView.frame), SCREEN_WIDTH, height) backgroundColor:@"ffffff"];
    [self.view addSubview:jobPropertyView];
    UILabel * jobPropertyLable = [UIFactory label:CGRectMake(space, 0, leftWidth, height) size:14 color:@"00beaf" align:NSTextAlignmentLeft];
    jobPropertyLable.text = @"工作性质";
    [jobPropertyView addSubview:jobPropertyLable];
    //全职
    fullTimeBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"全职" fontSize:14 frame:CGRectMake(CGRectGetWidth(jobPropertyView.frame)-space-btnWidth-btnWidth, 0, btnWidth, height)];
    [fullTimeBtn setImage:[UIImage imageNamed:@"hire_search_checkbox_empty"] forState:UIControlStateNormal];
    [fullTimeBtn setImage:[UIImage imageNamed:@"hire_search_checkbox"] forState:UIControlStateSelected];
    fullTimeBtn.tag = 20001;
    fullTimeBtn.selected = YES;
    [fullTimeBtn addTarget:self action:@selector(workProperty:) forControlEvents:UIControlEventTouchUpInside];
    [jobPropertyView addSubview:fullTimeBtn];
    //兼职
    unFullTimeBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"兼职" fontSize:14 frame:CGRectMake(CGRectGetWidth(jobPropertyView.frame)-space-btnWidth, 0, btnWidth, height)];
    [unFullTimeBtn setImage:[UIImage imageNamed:@"hire_search_checkbox_empty"] forState:UIControlStateNormal];
    [unFullTimeBtn setImage:[UIImage imageNamed:@"hire_search_checkbox"] forState:UIControlStateSelected];
    unFullTimeBtn.tag = 20002;
    unFullTimeBtn.highlighted = NO;
    [unFullTimeBtn addTarget:self action:@selector(workProperty:) forControlEvents:UIControlEventTouchUpInside];
    [jobPropertyView addSubview:unFullTimeBtn];
    
    ///学历要求
    UIView * schoolingEducationalView = [UIFactory viewWithFrame:CGRectMake(0, CGRectGetMaxY(jobPropertyView.frame), SCREEN_WIDTH, height) backgroundColor:@"ffffff"];
    [self.view addSubview:schoolingEducationalView];
    UILabel * schoolingEducationalLable = [UIFactory label:CGRectMake(space, 0, leftWidth, height) size:14 color:@"00beaf" align:NSTextAlignmentLeft];
    schoolingEducationalLable.text = @"学历要求";
    [schoolingEducationalView addSubview:schoolingEducationalLable];
    schoolingEducationalBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"" fontSize:14 frame:CGRectMake(CGRectGetMaxX(schoolingEducationalLable.frame), 0, centerWidth-rightArrowWidth, height)];
    [schoolingEducationalBtn addTarget:self action:@selector(schoolEducation:) forControlEvents:UIControlEventTouchUpInside];
    [schoolingEducationalBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [schoolingEducationalView addSubview:schoolingEducationalBtn];
    UIButton * schoolingEducationalArrowBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"" fontSize:14 frame:CGRectMake(CGRectGetWidth(schoolingEducationalView.frame)-space-rightArrowWidth, height/4, rightArrowWidth, height/2)];
    [schoolingEducationalArrowBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [schoolingEducationalView addSubview:schoolingEducationalArrowBtn];
    ///薪资待遇
    UIView * salaryView = [UIFactory viewWithFrame:CGRectMake(0, CGRectGetMaxY(schoolingEducationalView.frame), SCREEN_WIDTH, height) backgroundColor:@"ffffff"];
    [self.view addSubview:salaryView];
    UILabel * salaryLable = [UIFactory label:CGRectMake(space, 0, leftWidth, height) size:14 color:@"00beaf" align:NSTextAlignmentLeft];
    salaryLable.text = @"薪资待遇";
    [salaryView addSubview:salaryLable];
    salaryBtn = [UIFactory button:@"" sel:@"" titleColor:@"333333" title:@"" fontSize:14 frame:CGRectMake(CGRectGetMaxX(salaryLable.frame), 0, centerWidth-rightArrowWidth, height)];
    [salaryBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [salaryBtn addTarget:self action:@selector(salary:) forControlEvents:UIControlEventTouchUpInside];
    [salaryView addSubview:salaryBtn];
    UIButton * salaryArrowBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"" fontSize:14 frame:CGRectMake(CGRectGetWidth(salaryView.frame)-space-rightArrowWidth, height/4, rightArrowWidth, height/2)];
    [salaryArrowBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [salaryView addSubview:salaryArrowBtn];
    ///工作区域
    UIView * workAreaView = [UIFactory viewWithFrame:CGRectMake(0, CGRectGetMaxY(salaryView.frame), SCREEN_WIDTH, height) backgroundColor:@"ffffff"];
    [self.view addSubview:workAreaView];
    UILabel * workAreaLable = [UIFactory label:CGRectMake(space, 0, leftWidth, height) size:14 color:@"00beaf" align:NSTextAlignmentLeft];
    workAreaLable.text = @"工作区域";
    [workAreaView addSubview:workAreaLable];
    workAreaBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"" fontSize:14 frame:CGRectMake(CGRectGetMaxX(workAreaLable.frame), 0, centerWidth-rightArrowWidth, height)];
    [workAreaBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [workAreaView addSubview:workAreaBtn];
    UIButton * workAreaArrowBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"" fontSize:14 frame:CGRectMake(CGRectGetWidth(workAreaView.frame)-space-rightArrowWidth, height/4, rightArrowWidth, height/2)];
    [workAreaArrowBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [workAreaBtn addTarget:self action:@selector(workArea:) forControlEvents:UIControlEventTouchUpInside];
    [workAreaView addSubview:workAreaArrowBtn];
    ///性别要求
    UIView * sexView = [UIFactory viewWithFrame:CGRectMake(0, CGRectGetMaxY(workAreaView.frame), SCREEN_WIDTH, height) backgroundColor:@"ffffff"];
    [self.view addSubview:sexView];
    UILabel * sexLable = [UIFactory label:CGRectMake(space, 0, leftWidth, height) size:14 color:@"00beaf" align:NSTextAlignmentLeft];
    sexLable.text = @"性别要求";
    [sexView addSubview:sexLable];
    //不限制
    sexUnlimitedBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"不限" fontSize:14 frame:CGRectMake(CGRectGetWidth(sexView.frame)-space-btnWidth-btnWidth-btnWidth, 0, btnWidth, height)];
    sexUnlimitedBtn.selected = YES;
    sexUnlimitedBtn.tag = 10001;
    [sexUnlimitedBtn setImage:[UIImage imageNamed:@"hire_search_checkbox_empty"] forState:UIControlStateNormal];
    [sexUnlimitedBtn setImage:[UIImage imageNamed:@"hire_search_checkbox"] forState:UIControlStateSelected];
    [sexUnlimitedBtn addTarget:self action:@selector(sex:) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:sexUnlimitedBtn];
    //男
    manBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"男" fontSize:14 frame:CGRectMake(CGRectGetWidth(sexView.frame)-space-btnWidth-btnWidth, 0, btnWidth, height)];
    manBtn.tag = 10002;
    [manBtn setImage:[UIImage imageNamed:@"hire_search_checkbox_empty"] forState:UIControlStateNormal];
    [manBtn setImage:[UIImage imageNamed:@"hire_search_checkbox"] forState:UIControlStateSelected];
    [manBtn addTarget:self action:@selector(sex:) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:manBtn];
    //女
    woManBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"女" fontSize:14 frame:CGRectMake(CGRectGetWidth(sexView.frame)-space-btnWidth, 0, btnWidth, height)];
    woManBtn.tag = 10003;
    [woManBtn setImage:[UIImage imageNamed:@"hire_search_checkbox_empty"] forState:UIControlStateNormal];
    [woManBtn setImage:[UIImage imageNamed:@"hire_search_checkbox"] forState:UIControlStateSelected];
    [woManBtn addTarget:self action:@selector(sex:) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:woManBtn];
    
    [UIFactory showLineInView:self.view color:@"c7c6cb" rect:CGRectMake(16, CGRectGetMaxY(keyWordsView.frame), SCREEN_WIDTH-space, 0.5)];
    [UIFactory showLineInView:self.view color:@"c7c6cb" rect:CGRectMake(16, CGRectGetMaxY(jobPropertyView.frame), SCREEN_WIDTH-space, 0.5)];
    [UIFactory showLineInView:self.view color:@"c7c6cb" rect:CGRectMake(16, CGRectGetMaxY(schoolingEducationalView.frame), SCREEN_WIDTH-space, 0.5)];
    [UIFactory showLineInView:self.view color:@"c7c6cb" rect:CGRectMake(16, CGRectGetMaxY(salaryView.frame), SCREEN_WIDTH-space, 0.5)];
    [UIFactory showLineInView:self.view color:@"c7c6cb" rect:CGRectMake(16, CGRectGetMaxY(workAreaView.frame), SCREEN_WIDTH-space, 0.5)];
    
    //提交并注册
    submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    submitBtn.tag = 10002;
    submitBtn.layer.cornerRadius = 5.0;
    [submitBtn setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [submitBtn setFrame:CGRectMake(space, CGRectGetMaxY(sexView.frame)+space, SCREEN_WIDTH-2*space, height)];
    [submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"提交并注册" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:submitBtn];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag ==10001) {
        //关键字
        
    }
}
#pragma mark - 工作性质
-(void)workProperty:(UIButton *)sender
{
    if (sender.tag ==20001) {
        if (fullTimeBtn.selected==YES) {
            
        }else{
            fullTimeBtn.selected = YES;
            unFullTimeBtn.selected = NO;
        }
    }else{
        if (unFullTimeBtn.selected == YES) {
            
        }else{
            unFullTimeBtn.selected = YES;
            fullTimeBtn.selected = NO;
        }
    }
}

#pragma mark - 学历要求
-(void)schoolEducation:(UIButton *)sender
{
    /*
     "0" =>"不限",
     "1" =>"大专",
     "2" =>"本科",
     "3" =>"硕士",
     "4" =>"博士",
     "5" =>"博士后",
     "6" =>"其它"
     */
    LTPickerView* pickerView = [LTPickerView new];
    pickerView.dataSource = @[@"不限",@"大专",@"本科",@"硕士",@"博士",@"博士后",@"其他"];//设置要显示的数据
    //pickerView.defaultStr = @"1";//默认选择的数据
    [pickerView show];//显示
    //回调block
    pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        NSLog(@"选择了第%d行的%@",num,str);
        [sender setTitle:str forState:UIControlStateNormal];
        
        [sender setTitle:str forState:UIControlStateNormal];
        
    };
}
#pragma mark - 薪资待遇
-(void)salary:(UIButton *)sender
{
    /*
     薪资 salary
     "0" =>"面议",
     "1" =>"1000元/月以下",
     "2" =>"1000-1500元/月",
     "3" =>"1500-2000元/月",
     "4" =>"2000-3000元/月",
     "5" =>"3000-5000元/月",
     "6" =>"5000-10000元/月",
     "7" =>"10000-20000万元/月",
     "8" =>"2万元/月以上",
     
     */
    LTPickerView* pickerView = [LTPickerView new];
    pickerView.dataSource = @[@"面议",@"1000元/月以下",@"1000-1500元/月",@"1500-2000元/月",@"2000-3000元/月",@"3000-5000元/月",@"5000-10000元/月",@"10000-20000万元/月",@"2万元/月以上"];//设置要显示的数据
    //pickerView.defaultStr = @"1";//默认选择的数据
    [pickerView show];//显示
    //回调block
    pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
        //obj:LTPickerView对象
        //str:选中的字符串
        //num:选中了第几行
        NSLog(@"选择了第%d行的%@",num,str);
        [sender setTitle:str forState:UIControlStateNormal];
        
    };
}
#pragma mark - 工作区域
-(void)workArea:(UIButton *)sender
{
    [CommonUtils showToastWithStr:@"工作区域"];
}
#pragma mark - 性别要求
-(void)sex:(UIButton *)sender
{
    if (sender.tag ==10001) {
        //不限制
        if (sexUnlimitedBtn.selected) {
            
        }else{
            sexUnlimitedBtn.selected = YES;
            manBtn.selected = NO;
            woManBtn.selected = NO;
        }
    }else if (sender.tag ==10002){
        if (manBtn.selected ==YES) {
            
        }else{
            sexUnlimitedBtn.selected = NO;
            manBtn.selected = YES;
            woManBtn.selected = NO;
        }
    }else{
        if (woManBtn.selected == YES) {
            
        }else{
            sexUnlimitedBtn.selected = NO;
            manBtn.selected = NO;
            woManBtn.selected = YES;
        }
    }
    
}

-(void)submit:(UIButton *)sender
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"page"];
    [dic setObject:@"10" forKey:@"size"];
    //关键字
    if (keyWordsTextField.text.length>0) {
        [dic setObject:keyWordsTextField.text forKey:@"keyword"];
    }
    //性别
    if (sexUnlimitedBtn.selected==YES) {
        [dic setObject:@"0" forKey:@"sex"];
    }else if (manBtn.selected == YES){
        [dic setObject:@"1" forKey:@"sex"];
    }else{
        [dic setObject:@"2" forKey:@"sex"];
    }
    //学历
    NSString *schoolingEducationalBtnTitle = [schoolingEducationalBtn titleForState:UIControlStateNormal];
    if ( schoolingEducationalBtnTitle && schoolingEducationalBtnTitle.length>0 ) {
        if ([schoolingEducationalBtnTitle isEqualToString:@"不限"]) {
            [dic setObject:@"0" forKey:@"education"];
        }else if ([schoolingEducationalBtnTitle isEqualToString:@"大专"]){
            [dic setObject:@"1" forKey:@"education"];
        }else if ([schoolingEducationalBtnTitle isEqualToString:@"本科"]){
            [dic setObject:@"2" forKey:@"education"];
        }else if ([schoolingEducationalBtnTitle isEqualToString:@"硕士"]){
            [dic setObject:@"3" forKey:@"education"];
        }else if ([schoolingEducationalBtnTitle isEqualToString:@"博士"]){
            [dic setObject:@"4" forKey:@"education"];
        }else if ([schoolingEducationalBtnTitle isEqualToString:@"博士后"]){
            [dic setObject:@"5" forKey:@"education"];
        }else{
            [dic setObject:@"6" forKey:@"education"];
        }
        
    }
   //月薪
    NSString *salaryBtnTitle = [salaryBtn titleForState:UIControlStateNormal];
    if ( salaryBtnTitle && salaryBtnTitle.length>0 ) {
        if ([salaryBtnTitle isEqualToString:@"面议"]) {
            [dic setObject:@"0" forKey:@"salary"];
        }else if ([salaryBtnTitle isEqualToString:@"1000元/月以下"]){
            [dic setObject:@"1" forKey:@"salary"];
        }else if ([salaryBtnTitle isEqualToString:@"1000-1500元/月"]){
            [dic setObject:@"2" forKey:@"salary"];
        }else if ([salaryBtnTitle isEqualToString:@"1500-2000元/月"]){
            [dic setObject:@"3" forKey:@"salary"];
        }else if ([salaryBtnTitle isEqualToString:@"2000-3000元/月"]){
            [dic setObject:@"4" forKey:@"salary"];
        }else if ([salaryBtnTitle isEqualToString:@"3000-5000元/月"]){
            [dic setObject:@"5" forKey:@"salary"];
        }else if ([salaryBtnTitle isEqualToString:@"5000-10000元/月"]){
            [dic setObject:@"6" forKey:@"salary"];
        }else if ([salaryBtnTitle isEqualToString:@"10000-20000万元/月"]){
            [dic setObject:@"7" forKey:@"salary"];
        }else{
            [dic setObject:@"8" forKey:@"salary"];
        }
        
    }
    ///工作性质
    if (fullTimeBtn.selected==YES) {
        [dic setObject:@"1" forKey:@"nature"];
    }else{
        [dic setObject:@"2" forKey:@"nature"];
    }

    EmploymentRecruitmentViewController *employmentVC = [[EmploymentRecruitmentViewController alloc] init];
    employmentVC.type = SchoolRecruitmentTypeCompanySearch;
    employmentVC.companySearchDic = dic;
    employmentVC.title = @"就业招聘";
    [self.navigationController pushViewController:employmentVC animated:YES];
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
