//
//  GiftExchangeViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/23.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "GiftExchangeViewController.h"
#import "IQUIView+IQKeyboardToolbar.h"
@interface GiftExchangeViewController ()

{
    ///共所需积分
    UILabel * needPointValueLable;
    ///积分余额
    UILabel * residualPointValueLable;
    
    UIButton    *leftReduceBtn;///减号
    UITextField *centerTextField;///中间输入框
    UIButton    *rightAddBtn;///加号
}
@end

@implementation GiftExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createLeftBackNavBtn];
    [self setTitle:@"积分兑换"];
    self.view.backgroundColor = [CommonUtils colorWithHex:@"f5f5f5"];
    self.totalPoint = [UserAccountManager sharedInstance].usablePoints;
    self.mallModel.indexMallPoints = @"10";
    [self setcontentView];
}

-(void)setcontentView
{
    float space = 16;
    float height = 44;
    float leftImageWidth = 44;
    float leftImageHeight = 60;
    float headViewHeight = leftImageHeight + space*2;
    float width = SCREEN_WIDTH-2*space;
    float rightWidth = 100;
    
    
    ///头视图
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, NAV_TOP_HEIGHT, SCREEN_WIDTH,headViewHeight)];
    [self.view addSubview:headView];
    
    UIImageView * leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(space, space, leftImageWidth,leftImageHeight)];
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:self.mallModel.indexMallThumbUrl] placeholderImage:[UIImage imageNamed:@"placeHoder.png" ]];
    [headView addSubview:leftImageView];
    
    UILabel * exangeTitleLable = [UIFactory label:14*3 color:@"999999" align:NSTextAlignmentLeft];
    exangeTitleLable.frame = CGRectMake(CGRectGetMaxX(leftImageView.frame)+space, CGRectGetMinY(leftImageView.frame), CGRectGetWidth(headView.frame)-CGRectGetWidth(leftImageView.frame)-3*space, leftImageHeight/3);
    exangeTitleLable.text = @"兑换内容";
    
    [headView addSubview:exangeTitleLable];
    
    UILabel * exangeProductNameLable = [UIFactory label:14*3 color:@"333333" align:NSTextAlignmentLeft];
    exangeProductNameLable.frame = CGRectMake(CGRectGetMinX(exangeTitleLable.frame), CGRectGetMaxY(exangeTitleLable.frame), CGRectGetWidth(headView.frame)-CGRectGetWidth(leftImageView.frame)-3*space, leftImageHeight/3);
    exangeProductNameLable.text = self.mallModel.indexMallTitle;
    [headView addSubview:exangeProductNameLable];
    
    UILabel * pointLable = [UIFactory label:14*3 color:@"333333" align:NSTextAlignmentLeft];
    pointLable.frame = CGRectMake(CGRectGetMinX(exangeTitleLable.frame), CGRectGetMaxY(exangeProductNameLable.frame), CGRectGetWidth(headView.frame)-CGRectGetWidth(leftImageView.frame)-3*space, leftImageHeight/3);
    
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 积分",self.mallModel.indexMallPoints]];
    
    NSRange range1=[[hintString string]rangeOfString:self.mallModel.indexMallPoints];
    
    UIColor *color = [CommonUtils colorWithHex:@"ff6478"];
    [hintString addAttribute:NSForegroundColorAttributeName value:color range:range1];
    
    pointLable.attributedText = hintString;

    [headView addSubview:pointLable];
    
    [UIFactory showLineInView:headView color:@"e5e5e5" rect:CGRectMake(space, CGRectGetHeight(headView.frame)-0.5,CGRectGetWidth(headView.frame)-2*space , 0.5)];
    
    //兑换份数
    UIView * remainderExangePartView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), SCREEN_WIDTH,height)];
    [self.view addSubview:remainderExangePartView];
    
    UILabel * remainderExangePartLable = [UIFactory label:14*3 color:@"333333" align:NSTextAlignmentLeft];
    remainderExangePartLable.frame = CGRectMake(space,0, CGRectGetWidth(remainderExangePartView.frame)-2*space-rightWidth, height);
    remainderExangePartLable.text = @"兑换份数";
    [remainderExangePartView addSubview:remainderExangePartLable];
    
    UIView * rduceAndAddView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(remainderExangePartLable.frame ), 0, rightWidth,height)];
    [remainderExangePartView addSubview:rduceAndAddView];
    [self setStepperViewContentViewWithStepperView:rduceAndAddView];
    
    [UIFactory showLineInView:remainderExangePartView color:@"e5e5e5" rect:CGRectMake(space, CGRectGetHeight(remainderExangePartView.frame)-0.5,CGRectGetWidth(headView.frame)-2*space , 0.5)];
    
    //所需积分
    UIView * needPointView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(remainderExangePartView.frame), SCREEN_WIDTH,height)];
    [self.view addSubview:needPointView];
    
    UILabel * needPointLable = [UIFactory label:14*3 color:@"333333" align:NSTextAlignmentLeft];
    needPointLable.frame = CGRectMake(space,0, CGRectGetWidth(remainderExangePartView.frame)-2*space-rightWidth, height);
    needPointLable.text = @"所需积分";
    [needPointView addSubview:needPointLable];
    
    needPointValueLable = [UIFactory label:14*3 color:@"333333" align:NSTextAlignmentRight];
    needPointValueLable.frame = CGRectMake(CGRectGetMaxX(needPointLable.frame),0, rightWidth, height);
    needPointValueLable.text = @"0";
    [needPointView addSubview:needPointValueLable];
    
    [UIFactory showLineInView:needPointView color:@"333333" rect:CGRectMake(space, CGRectGetHeight(needPointView.frame)-0.5,CGRectGetWidth(headView.frame)-2*space , 0.5)];
    
    //剩余积分
    UIView * residualPointView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(needPointView.frame), SCREEN_WIDTH,height)];
    [self.view addSubview:residualPointView];
    
    UILabel * residualPointLable = [UIFactory label:14*3 color:@"333333" align:NSTextAlignmentLeft];
    residualPointLable.frame = CGRectMake(space,0, CGRectGetWidth(remainderExangePartView.frame)-2*space-rightWidth, height);
    residualPointLable.text = @"积分余额";
    [residualPointView addSubview:residualPointLable];
    
    residualPointValueLable = [UIFactory label:14*3 color:@"333333" align:NSTextAlignmentRight];
    residualPointValueLable.frame = CGRectMake(CGRectGetMaxX(residualPointLable.frame),0, rightWidth, height);
    residualPointValueLable.text =self.totalPoint;
    [residualPointView addSubview:residualPointValueLable];
    
    [UIFactory showLineInView:residualPointView color:@"333333" rect:CGRectMake(space, CGRectGetHeight(residualPointView.frame)-0.5,CGRectGetWidth(headView.frame)-2*space , 0.5)];
    
    
    UIButton * exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exchangeBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    exchangeBtn.tag = 10002;
    exchangeBtn.layer.cornerRadius = 3.0;
    [exchangeBtn setTitleColor:[CommonUtils colorWithHex:@"ffffff"] forState:UIControlStateNormal];
    [exchangeBtn setFrame:CGRectMake(space, CGRectGetMaxY(residualPointView.frame)+space, width, height)];
    [exchangeBtn addTarget:self action:@selector(exchangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [exchangeBtn setTitle:@"兑换" forState:UIControlStateNormal];
    exchangeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:exchangeBtn];
    
}
-(void)setStepperViewContentViewWithStepperView:(UIView *)stepperView
{
    float height = stepperView.frame.size.height;
    float width = stepperView.frame.size.width;
    //左侧减号
    leftReduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftReduceBtn setImage:[UIImage imageNamed:@"bigpie_order_minus_disable"] forState:UIControlStateNormal];
    [leftReduceBtn setImage:[UIImage imageNamed:@"bigpie_order_minus_press@3x"] forState:UIControlStateHighlighted];
    [leftReduceBtn setFrame:CGRectMake(0, 0, width/3, height)];
    leftReduceBtn.tag = 10001;
    [leftReduceBtn addTarget:self action:@selector(changeBuyTicketNumWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [stepperView addSubview:leftReduceBtn];
    //中间输入框
    centerTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftReduceBtn.frame), 0, width/3, height)];
    centerTextField.text = @"0";
    [centerTextField addPreviousNextDoneOnKeyboardWithTarget:self previousAction:nil nextAction:nil doneAction:@selector(doneAction:)];
    centerTextField.font = [UIFont systemFontOfSize:12];
    centerTextField.textAlignment = NSTextAlignmentCenter;
    centerTextField.keyboardType = UIKeyboardTypeNumberPad;
    [centerTextField setFrame:CGRectMake(width/3, 0, width/3, height)];
    [stepperView addSubview:centerTextField];
    //右侧加号按钮
    rightAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([self.totalPoint integerValue]>=[self.mallModel.indexMallPoints integerValue]) {
        [rightAddBtn setImage:[UIImage imageNamed:@"bigpie_order_add"] forState:UIControlStateNormal];
    }else{
        [rightAddBtn setImage:[UIImage imageNamed:@"bigpie_order_add_disable"] forState:UIControlStateNormal];
    }
    [rightAddBtn setImage:[UIImage imageNamed:@"bigpie_order_add_press"] forState:UIControlStateHighlighted];
    rightAddBtn.tag = 10002;
    [rightAddBtn addTarget:self action:@selector(changeBuyTicketNumWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightAddBtn setFrame:CGRectMake(width/3*2, 0, width/3, height)];
    [stepperView addSubview:rightAddBtn];
   
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [centerTextField resignFirstResponder];
    return YES;
}
-(void)doneAction:(UITextField *)textField
{
    if ([centerTextField.text integerValue]>([self.totalPoint integerValue]/[self.mallModel.indexMallPoints integerValue])) {
        [CommonUtils showToastWithStr:@"请输入有效份数"];
        centerTextField.text = @"0";
    }else if ([centerTextField.text integerValue]==([self.totalPoint integerValue]/[self.mallModel.indexMallPoints integerValue])){
        [rightAddBtn setImage:[UIImage imageNamed:@"bigpie_order_add_disable"] forState:UIControlStateNormal];
    }else if ([centerTextField.text integerValue]==([self.totalPoint integerValue]/[self.mallModel.indexMallPoints integerValue])&& [centerTextField.text integerValue]==0){
        [rightAddBtn setImage:[UIImage imageNamed:@"bigpie_order_add_disable"] forState:UIControlStateNormal];
        [leftReduceBtn setImage:[UIImage imageNamed:@"bigpie_order_minus_disable"] forState:UIControlStateNormal];
    }else{
        [leftReduceBtn setImage:[UIImage imageNamed:@"bigpie_order_minus"] forState:UIControlStateNormal];
        [rightAddBtn setImage:[UIImage imageNamed:@"bigpie_order_add"] forState:UIControlStateNormal];
    }
    [centerTextField resignFirstResponder];
    [self updatePointInfo];
}
//#pragma mark - UITouch
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [centerTextField resignFirstResponder];
//}
//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [centerTextField resignFirstResponder];
//}
#pragma mark - 增加和减少购票人人数
-(void)changeBuyTicketNumWithBtn:(UIButton *)sender
{
    if (sender.tag == 10001) {
        //减少
        if ([centerTextField.text intValue]==0) {
            [leftReduceBtn setImage:[UIImage imageNamed:@"bigpie_order_minus_disable"] forState:UIControlStateNormal];
        }else{
            [leftReduceBtn setImage:[UIImage imageNamed:@"bigpie_order_minus"] forState:UIControlStateNormal];
            centerTextField.text = [NSString stringWithFormat:@"%d",[centerTextField.text intValue]-1];
            if ([centerTextField.text intValue]==0) {
                [leftReduceBtn setImage:[UIImage imageNamed:@"bigpie_order_minus_disable"] forState:UIControlStateNormal];
            }
        }
    }else{
        //增加
        if ([[rightAddBtn imageForState:UIControlStateNormal]isEqual:[UIImage imageNamed:@"bigpie_order_add"]]) {
            centerTextField.text = [NSString stringWithFormat:@"%d",[centerTextField.text intValue]+1];
            if (centerTextField.text.intValue<=([self.totalPoint integerValue]/[self.mallModel.indexMallPoints integerValue])) {
                [rightAddBtn setImage:[UIImage imageNamed:@"bigpie_order_add"] forState:UIControlStateNormal];
            }else{
                [rightAddBtn setImage:[UIImage imageNamed:@"bigpie_order_add_disable"] forState:UIControlStateNormal];
            }
            [leftReduceBtn setImage:[UIImage imageNamed:@"bigpie_order_minus"] forState:UIControlStateNormal];
        }else{
            ///如果+号按钮是灰色的，则，什么也不需要做了
            
        }
        
        
    }
    [self updatePointInfo];
}

-(void)updatePointInfo
{
    needPointValueLable.text =[NSString stringWithFormat:@"%ld",[centerTextField.text integerValue]*[self.mallModel.indexMallPoints integerValue]];
    NSInteger residualPoint = [self.totalPoint integerValue]-[needPointValueLable.text integerValue];
    residualPointValueLable.text = [NSString stringWithFormat:@"%ld",residualPoint];
}

#pragma mark - 立即兑换
-(void)exchangeBtn:(UIButton *)sender
{
    /*
     good_id int  必需    商品序号
     points  int  必需    所需积分数
     user_id int  必需    用户序号
     number  int  必需    兑换数量     >0
     */
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.mallModel.indexMallId forKey:@"good_id"];
    [dic setObject:needPointValueLable.text forKey:@"points"];
    [dic setObject:[UserAccountManager sharedInstance].userId forKey:@"user_id"];
    [dic setObject:centerTextField.text forKey:@"number"];
    
    [[HttpClient sharedInstance]exchangeGiftWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        if (model.responseCode==ResponseCodeSuccess) {
            [CommonUtils showToastWithStr:@"兑换成功"];
        }else{
            [CommonUtils showToastWithStr:model.responseMsg];
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
