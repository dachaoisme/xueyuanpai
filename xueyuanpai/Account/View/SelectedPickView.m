//
//  SelectedPickView.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SelectedPickView.h"

@interface SelectedPickView ()

{
    NSMutableArray * dataArr;
}

@end
@implementation SelectedPickView


-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSMutableArray *)tempDataArr
{
    self = [super initWithFrame:frame];
    if (self) {
        dataArr = tempDataArr;
        [self setContentViewWithFrame:frame];
    }
    return self;
}

-(void)setContentViewWithFrame:(CGRect)frame
{

    //初始化一个PickerView
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 200)];
    pickerView.tag = 1000;
    //指定Picker的代理
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    //是否要显示选中的指示器(默认值是NO)
    pickerView.showsSelectionIndicator = NO;
    [self addSubview:pickerView];
}

#pragma mark --- 与DataSource有关的代理方法
//返回列数（必须实现）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//返回每列里边的行数（必须实现）
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //如果是第一列
    if (component == 0) {
        //返回姓名数组的个数
        return dataArr.count;
    }
    else
    {
        //返回表情数组的个数
        return 0;
    }
    
}

#pragma mark --- 与处理有关的代理方法
//设置组件的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return 100;
    }
    else
    {
        return 0;
    }
    
}
//设置组件中每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (component == 0) {
        return 60;
    }
    else
    {
        return 0;
    }
}
//设置组件中每行的标题row:行
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return dataArr[row];
    }
    else
    {
        return nil;
    }
}



//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{}

//选中行的事件处理
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        NSLog(@"%@",dataArr[row]);
        [pickerView selectedRowInComponent:0];
        //block返回数据
        self.callBackBlock([dataArr objectAtIndex:row]);
    }
    else
    {
        NSLog(@"%@",dataArr[row]);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
