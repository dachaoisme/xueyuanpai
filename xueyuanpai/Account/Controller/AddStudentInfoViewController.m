//
//  AddStudentInfoViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AddStudentInfoViewController.h"

@interface AddStudentInfoViewController ()

@end

@implementation AddStudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"设置资料"];
    self.view.backgroundColor = [CommonUtils colorWithHex:@"e5e5e5"];
    
    [self setContentView];
    
    
}
-(void)setContentView
{
    float space = 16;
    float headImageheight = 60;
    float headImageWidth = 60;
    float height = 44;
    float width = SCREEN_WIDTH-2*space;
    float arrowWidth = 20;
    ///选择头像
    UIButton * headImageSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [headImageSelectedBtn setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [headImageSelectedBtn setImage:[UIImage imageNamed:@"avatar_upload"] forState:UIControlStateNormal];
    [headImageSelectedBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [headImageSelectedBtn setFrame:CGRectMake((SCREEN_WIDTH-headImageWidth)/2, space+NAV_TOP_HEIGHT, headImageWidth,headImageheight)];
    [headImageSelectedBtn addTarget:self action:@selector(selectedImageFromPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headImageSelectedBtn];
    ///输入昵称
    UIView *nickNameView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headImageSelectedBtn.frame)+space, SCREEN_WIDTH, height)];
    nickNameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nickNameView];
    UITextField * nickNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(space, 0, width, height)];
    nickNameTextField.backgroundColor = [UIColor whiteColor];
    nickNameTextField.placeholder = @"设置昵称(4-10个字符)";
    [nickNameView addSubview:nickNameTextField];
    
    ///选择性别
    UIView *sexView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nickNameView.frame), SCREEN_WIDTH, height)];
    sexView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sexView];
    UIButton * sexBtn = [UIFactory button:nil sel:nil titleColor:@"c2c3c4" title:@"选择性别" fontSize:15 frame:CGRectMake(space,0 , width-arrowWidth, CGRectGetHeight(sexView.frame))];
    [sexBtn setBackgroundColor:[UIColor whiteColor]];
    sexBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [sexBtn addTarget:self action:@selector(selectedSxe:) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:sexBtn];
    
    UIImageView * arrowImageView = [UIFactory imageView:CGRectMake(CGRectGetMaxX(sexBtn.frame), 0, arrowWidth, height) viewMode:UIViewContentModeCenter image:@"arrow"];
    [arrowImageView setBackgroundColor:[UIColor whiteColor]];
    [sexView addSubview:arrowImageView];

    ///选择学校
    UIView *schoolView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sexView.frame), SCREEN_WIDTH, height)];
    [schoolView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:schoolView];
    UIButton * schoolBtn = [UIFactory button:nil sel:nil titleColor:@"c2c3c4" title:@"选择学校" fontSize:15 frame:CGRectMake(space, 0, width-arrowWidth, height)];
    [schoolBtn setBackgroundColor:[UIColor whiteColor]];
    schoolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [schoolBtn addTarget:self action:@selector(selectedSchool:) forControlEvents:UIControlEventTouchUpInside];
    [schoolView addSubview:schoolBtn];
    
    UIImageView * schoolArrowImageView = [UIFactory imageView:CGRectMake(CGRectGetMaxX(schoolBtn.frame), 0, arrowWidth, height) viewMode:UIViewContentModeCenter image:@"arrow"];
    [schoolArrowImageView setBackgroundColor:[UIColor whiteColor]];
    [schoolView addSubview:schoolArrowImageView];
    ///提交
    UIButton * submitBtn = [UIFactory button:nil sel:nil titleColor:@"f5f5f5" title:@"提交" fontSize:15 frame:CGRectMake(space, CGRectGetMaxY(schoolView.frame)+space, width, height)];
    [submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [self.view addSubview:submitBtn];
    ///稍后完善
    UIButton * unperfectBtn = [UIFactory button:nil sel:nil titleColor:@"00beaf" title:@"稍后完善" fontSize:15 frame:CGRectMake(space, CGRectGetMaxY(submitBtn.frame)+space, width, height)];
    [unperfectBtn addTarget:self action:@selector(unperfect:) forControlEvents:UIControlEventTouchUpInside];
    [unperfectBtn setBackgroundColor:[CommonUtils colorWithHex:@"f5f5f5"]];
    unperfectBtn.layer.borderColor = [CommonUtils colorWithHex:@"00beaf"].CGColor;
    unperfectBtn.layer.borderWidth = 0.5;
    [self.view addSubview:unperfectBtn];
    
    float linHeight = 0.5;
    [UIFactory showLineInView:nickNameView color:@"e5e5e5" rect:CGRectMake(space, CGRectGetHeight(nickNameView.frame)-linHeight, CGRectGetWidth(nickNameView.frame)-space, linHeight)];
    [UIFactory showLineInView:sexView color:@"e5e5e5" rect:CGRectMake(space, CGRectGetHeight(sexView.frame)-linHeight, CGRectGetWidth(sexView.frame)-space, linHeight)];
    [UIFactory showLineInView:schoolView color:@"e5e5e5" rect:CGRectMake(space, CGRectGetHeight(schoolView.frame)-linHeight, CGRectGetWidth(schoolView.frame)-space, linHeight)];
    
}

#pragma mark - 从相册中选择图片
-(void)selectedImageFromPhotoAlbum:(UIButton *)sender
{
    
}

#pragma mark - 选择性别
-(void)selectedSxe:(UIButton *)sender
{
    
}
#pragma mark - 选择学校
-(void)selectedSchool:(UIButton *)sender
{
    
}
#pragma mark - 提交
-(void)submit:(UIButton *)sender
{
    
}
#pragma mark - 稍后完善
-(void)unperfect:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
