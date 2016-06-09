//
//  AddProjectLeaderViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/9.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AddProjectLeaderViewController.h"

#import "AddProjectLeaderOneTableViewCell.h"
#import "AddProjectLeaderTwoTableViewCell.h"


#import "SelectedSchollViewController.h"

@interface AddProjectLeaderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * educationArr;
    NSArray * educationIdArr;
    NSArray * graduationtimeArr;
}

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation AddProjectLeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    educationArr = [NSArray arrayWithObjects:@"大学",@"本科",@"硕士",@"博士",@"博士后",@"其它", nil];
    educationIdArr = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    graduationtimeArr = [NSArray arrayWithObjects:@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029",@"2030",@"2031",@"2032",@"2033",@"2034",@"2035",@"2036", nil];
    self.title = @"项目负责人";
    [self createLeftBackNavBtn];
    
    
    [self createTableView];
    
    
}

#pragma mark - 创建tableView
- (void)createTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    

    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"AddProjectLeaderOneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"oneCell"];
    [tableView registerNib:[UINib nibWithNibName:@"AddProjectLeaderTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"twoCell"];

    
    //发布按钮的创建
    
    float space = 16;
    float btnHeight = 44;
    float footViewHeight = 48;
    float btnWidth = SCREEN_WIDTH - 30;
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, footViewHeight)];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [submitBtn setFrame:CGRectMake(space, space, btnWidth,btnHeight)];
    submitBtn.layer.cornerRadius = 10.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:submitBtn];
    
    self.tableView.tableFooterView = backGroundView;

    
}

#pragma mark - 确定按钮的响应方法
- (void)saveAction{
    
    if (self.publicProgectModel.businessCenterPublicProgectRealName.length<=0) {
        [CommonUtils showToastWithStr:@"请输入负责人姓名"];
        return;
    }else if (self.publicProgectModel.businessCenterPublicProgectIdentityCard.length<=0){
        [CommonUtils showToastWithStr:@"请输入负责人身份证"];
        return;
    }else if (self.publicProgectModel.businessCenterPublicProgectTelephone.length<=0){
        [CommonUtils showToastWithStr:@"请输入负责人手机号"];
        return;
    }else if (self.publicProgectModel.businessCenterPublicProgectMajor.length<=0){
        [CommonUtils showToastWithStr:@"请输入负责人专业"];
        return;
    }else if (self.publicProgectModel.businessCenterPublicProgectCollege.length<=0){
        [CommonUtils showToastWithStr:@"请输入负责人大学"];
        return;
    }else if (self.publicProgectModel.businessCenterPublicProgectJob.length<=0){
        [CommonUtils showToastWithStr:@"请输入负责人学历"];
        return;
    }else if (self.publicProgectModel.businessCenterPublicProgectGraduationtime.length<=0){
        [CommonUtils showToastWithStr:@"请输入负责人毕业时间"];
        return;
    }else{
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tabbleView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }else{
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.section == 0) {
        AddProjectLeaderOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.publicProgectModel = self.publicProgectModel;
        switch (indexPath.row) {
            case 0:{
                cell.titleLabel.text = @"姓名";
                cell.inputContentTextField.text =self.publicProgectModel.businessCenterPublicProgectRealName;
                cell.tag = 0;
            }
                break;
            case 1:{
                
                cell.titleLabel.text = @"身份证号";
                cell.inputContentTextField.text =self.publicProgectModel.businessCenterPublicProgectIdentityCard;
                cell.tag = 1;
            }
                break;
            case 2:{
                
                cell.titleLabel.text = @"联系电话";
                cell.inputContentTextField.text =self.publicProgectModel.businessCenterPublicProgectTelephone;
                cell.tag = 2;

            }
                break;
            default:
                break;
        }
        
        return cell;

        
    }else{
        
        
        if (indexPath.row == 1) {
            AddProjectLeaderOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
            cell.publicProgectModel = self.publicProgectModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"专业";
            cell.tag = 3;
            cell.inputContentTextField.text =self.publicProgectModel.businessCenterPublicProgectMajor;
            return cell;

        }else{
            
            AddProjectLeaderTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.tag = indexPath.row;
            switch (indexPath.row) {
                case 0:{
                    
                    cell.titleLabel.text = @"学校";
                    cell.contentLabel.text =self.publicProgectModel.businessCenterPublicProgectCollege;
                }
                    break;
                case 2:{
                    
                    cell.titleLabel.text = @"学历";
                    cell.contentLabel.text =self.publicProgectModel.businessCenterPublicProgectJob;
                }
                    break;
                case 3:{
                    
                    cell.titleLabel.text = @"毕业时间";
                    cell.contentLabel.text =self.publicProgectModel.businessCenterPublicProgectGraduationtime;
                }
                    break;
                    
                default:
                    break;
            }
            
            return cell;
            
        }
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    weakSelf(weakSelf);
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ///选择学校
            SelectedSchollViewController *selectSchoolVC = [[SelectedSchollViewController alloc] init];
            selectSchoolVC.callBackBlock = ^(CollegeModel  *collegeModel){
                weakSelf.publicProgectModel.businessCenterPublicProgectCollegeId = collegeModel.collegeID;
                weakSelf.publicProgectModel.businessCenterPublicProgectCollege = collegeModel.collegeName;
                [tableView reloadData];
            };
            [self.navigationController pushViewController:selectSchoolVC animated:YES];
        }else if (indexPath.row==2){
            ///学历1 大专  2 本科 3 硕士4 博士 5 博士后 6 其它
            LTPickerView* pickerView = [LTPickerView new];
            pickerView.dataSource = educationArr;//设置要显示的数据
            //pickerView.defaultStr = @"1";//默认选择的数据
            [pickerView show];//显示
            //回调block
            
            pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
                //obj:LTPickerView对象
                //str:选中的字符串
                //num:选中了第几行
                NSLog(@"选择了第%d行的%@",num,str);
                weakSelf.publicProgectModel.businessCenterPublicProgectJob = [educationArr objectAtIndex:num];
                weakSelf.publicProgectModel.businessCenterPublicProgectJobId = [educationIdArr objectAtIndex:num];
                [tableView reloadData];
            };
        }else if (indexPath.row==3){
            ///毕业时间
            ///学历1 大专  2 本科 3 硕士4 博士 5 博士后 6 其它
            LTPickerView* pickerView = [LTPickerView new];
            pickerView.dataSource = graduationtimeArr;//设置要显示的数据
            //pickerView.defaultStr = @"1";//默认选择的数据
            [pickerView show];//显示
            //回调block
            pickerView.block = ^(LTPickerView* obj,NSString* str,int num){
                //obj:LTPickerView对象
                //str:选中的字符串
                //num:选中了第几行
                NSLog(@"选择了第%d行的%@",num,str);
                weakSelf.publicProgectModel.businessCenterPublicProgectGraduationtime = [graduationtimeArr objectAtIndex:num];
                [tableView reloadData];
            };
        }else{
            
        }
        
    }
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
