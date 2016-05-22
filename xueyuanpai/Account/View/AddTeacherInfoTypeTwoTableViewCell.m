//
//  AddTeacherInfoTypeTwoTableViewCell.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AddTeacherInfoTypeTwoTableViewCell.h"

@interface AddTeacherInfoTypeTwoTableViewCell ()<UITextViewDelegate>
{
    
    UITextField * titleTextField;
}
@end

@implementation AddTeacherInfoTypeTwoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setContentView];
    }
    return self;
    
}

-(void)setContentView
{
    float leftWidth = 60;
    float space = 16;
    float rightWidth = 30;
    float centerWidth = SCREEN_WIDTH-leftWidth-rightWidth-2*space;
    float height = CGRectGetHeight(self.frame);
    
    _titleLable = [UIFactory label:12*3 color:@"999999" align:NSTextAlignmentLeft];
    _titleLable.frame = CGRectMake(space, 0, leftWidth, height) ;
    [self.contentView addSubview:_titleLable];
    
    UILabel * tipsLable = [UIFactory label:12*3 color:@"999999" align:NSTextAlignmentLeft];
    tipsLable.frame = CGRectMake(CGRectGetWidth(self.frame)-space-rightWidth,0 , rightWidth, height) ;
    tipsLable.text = @"必填";
    [self addSubview:tipsLable];
    
//    //请输入手机号
//    titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(space,CGRectGetMaxY(_titleLable.frame), SCREEN_WIDTH-2*space, height)];
//    titleTextField.tag = 2;
//    titleTextField.delegate = self;
//    [titleTextField setBackgroundColor:[CommonUtils colorWithHex:@"ffffff"]];
//    titleTextField.textAlignment = NSTextAlignmentLeft;
//    titleTextField.borderStyle   = UITextBorderStyleNone;
//    //myTextField.clearsOnBeginEditing = YES;//设置为YES当用点触文本字段时，字段内容会被清除
//    titleTextField.adjustsFontSizeToFitWidth = YES;
//    titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    titleTextField.leftViewMode    = UITextFieldViewModeAlways;
//    titleTextField.rightViewMode   = UITextFieldViewModeAlways;
//    [self.contentView addSubview:titleTextField];
    
    //请输入手机号
    UITextView * textView =[[UITextView alloc] initWithFrame:CGRectMake(space,CGRectGetMaxY(_titleLable.frame), SCREEN_WIDTH-2*space, height)] ; //初始化大小并自动释放
    textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    textView.font = [UIFont fontWithName:@"Arial" size:18.0];//设置字体名字和字体大小
    textView.delegate = self;//设置它的委托方法
    textView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textView.scrollEnabled = YES;//是否可以拖动
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    [self.contentView addSubview: textView];//加入到整个页面中
    self.textView = textView;
    
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:doneButton,nil];
    [topView setItems:buttonsArray];
    [textView setInputAccessoryView:topView];

    
}
-(void)dismissKeyBoard
{
    [_textView resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
