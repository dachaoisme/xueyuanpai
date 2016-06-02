//
//  MyPickView.m
//  DatePicker
//
//  Created by dida on 16/3/24.
//  Copyright © 2016年 Amiee. All rights reserved.
//

#import "MyPickView.h"
#import "PickerCell.h"

#define screenWidth     [[UIScreen mainScreen]bounds].size.width
#define screenHeight    [[UIScreen mainScreen]bounds].size.height
@interface MyPickView ()

//@property(nonatomic,strong)UIPickerView *myPic;

///外层传入的数据源
@property (nonatomic,strong)NSArray *yearArr;
@property (nonatomic,strong)NSArray *monthArr;
@property (nonatomic,strong)NSMutableArray *daysArr;
@property (nonatomic,strong)NSArray *hourArr;
///指定日期的月份有多少天
@property (nonatomic,assign)NSInteger  currentDays;

///选中的日期的字符串
@property (nonatomic,copy)NSString *yearString;
@property (nonatomic,copy)NSString *monthString;
@property (nonatomic,copy)NSString *dayString;
@property (nonatomic,copy)NSString *hourString;

//当前月份
@property (nonatomic,copy)NSString * currentYearStr;
//当前月份
@property (nonatomic,copy)NSString * currentMonthStr;
//当前日期
@property (nonatomic,copy)NSString * currentDayStr;
//当前小时
@property (nonatomic,copy)NSString * currentHourStr;


@property (nonatomic,weak)PickerCell *selectedCell;

@property (nonatomic,assign)NSInteger  selectedRow;

@property (nonatomic,assign)NSInteger  selectedCom;

@property (nonatomic,assign)NSInteger currentYear;
@property (nonatomic,assign)NSInteger currentMonth;
@property (nonatomic,assign)NSInteger currentDay;
@property (nonatomic,assign)NSInteger  currentHour;

@property (nonatomic,strong)UIPickerView *myPickerView;

@end

@implementation MyPickView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcontentViewWithFrame:frame];
    }
    return self;
}

-(void)setcontentViewWithFrame:(CGRect)frame
{
    
    UIView * toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 60)];
    toolView.backgroundColor =[UIColor whiteColor];
    [self addSubview:toolView];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(16, 0, screenWidth/3, 60)];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.tag = 10001;
    [cancelBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [toolView addSubview:cancelBtn];
    
    UIButton * selectedTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectedTimeBtn setFrame:CGRectMake(screenWidth/3, 0, screenWidth/3, 60)];
    [selectedTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectedTimeBtn setTitle:@"请选择时间" forState:UIControlStateNormal];
    [toolView addSubview:selectedTimeBtn];
    
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setFrame:CGRectMake(CGRectGetWidth(toolView.frame)-screenWidth/3-16, 0, screenWidth/3, 60)];
    sureBtn.tag = 10002;
    [sureBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [toolView addSubview:sureBtn];
    
    
    _myPickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(toolView.frame), screenWidth, frame.size.height-60)];
    _myPickerView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_myPickerView];
    
}
-(void)buttonAction:(UIButton *)sender
{
    if (sender.tag == 10001) {
        //取消
        self.selectedBlock(NO,self.selectedDate,self.selectedNoonIndex);
        [self removeFromSuperview];
        
    }else{
        self.selectedBlock(YES,self.selectedDate,self.selectedNoonIndex);
        //确定
        if ([self.delegate respondsToSelector:@selector(selectedTime)]) {
            [self.delegate selectedTime];
            [self removeFromSuperview];
        }
    }
}
-(void)myPickView:(UIPickerView *)pickView yearArray:(NSArray *)yearArr monthArray:(NSArray *)monthArr  hourArray:(NSArray *)hourArr minuArr:(NSArray *)minuArr
{
    //_myPic           =pickView;
    _yearArr         =yearArr;
    _monthArr        =monthArr;
    _hourArr         =hourArr;
    _daysArr         =[NSMutableArray array];
    _myPickerView.delegate  =self;
    _myPickerView.dataSource=self;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour  fromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    ///获取当前年、月、日、时
    _currentYear  =dateComponents.year;
    _currentMonth =dateComponents.month;
    _currentDay   =dateComponents.day;
    _currentHour  =dateComponents.hour;

    //把当前年月日转换成 字符串获取当前的年，月，日，时
    _yearString      =[NSString stringWithFormat:@"%ld",dateComponents.year];
    _currentYearStr  =[NSString stringWithFormat:@"%ld",dateComponents.year];
    _currentMonthStr =[NSString stringWithFormat:@"%ld",dateComponents.month];
    _currentDayStr   =[NSString stringWithFormat:@"%ld",dateComponents.day];
    _currentHourStr  =[NSString stringWithFormat:@"%ld",dateComponents.hour];
    
    NSDate *date     =[NSDate date];
    self.currentDays =[self getDaysNumOfMonth:date];
    
    [self SelectCurrentDate];
    
    self.selectedDate =[self currentDate];


}

//获取当前时间
-(NSString *)currentDate{
    
    NSDate *currentDate=[NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString=[dateFormatter stringFromDate:currentDate];
    return dateString;
}

//解决获取的时间与实际相差8个小时
-(NSDate *)localeDate:(NSDate *)date{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];

    return localeDate;
}

//设置选中状态为当前时间
-(void)SelectCurrentDate{
    [_myPickerView selectRow:_currentYear-1 inComponent:0 animated:YES];
    [_myPickerView selectRow:_currentMonth-1 inComponent:0 animated:YES];
    [_myPickerView selectRow:_currentDay-1 inComponent:1 animated:YES];
    [_myPickerView selectRow:_currentHour inComponent:2 animated:YES];
    
    _yearString = _currentYearStr;
    _monthString=_currentMonthStr;
    _dayString=_currentDayStr;
    _hourString=_currentHourStr;
}

//字符串转换成日期
-(NSDate *)pickDateFromString:(NSString *)string
{
    NSDate *date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    date = [formatter dateFromString:string];
    
    return date;
}

//字符串转换成详细时间
-(NSDate *)pickTimeFromString:(NSString *)string
{
    NSDate *date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    date = [formatter dateFromString:string];
    
    NSDate *forDate=[self localeDate:date];
    
    return forDate;
}


//指定日期的月份有多少天
-(NSInteger)getDaysNumOfMonth:(NSDate *)date
{
    NSInteger days;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    days = range.length;
    
    return days;
    
}


-(void)setCurrentDays:(NSInteger)currentDays
{
    _currentDays = currentDays;
    
    [_daysArr removeAllObjects];
    
    for (int i = 0; i < _currentDays; i ++)
    {
        [_daysArr addObject:[NSString stringWithFormat:@"%.2i",i + 1]];
    }
    
}



#pragma mark UIPickerViewDataSource,UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return _yearArr.count;
    }
    else if(component == 1)
    {
        return _monthArr.count;
        
    }
    else if (component==2)
    {
        return _daysArr.count ;
        
    }else
    {
        return _hourArr.count ;
        
    }
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    return (screenWidth)/4;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    PickerCell *cell = [[PickerCell alloc]initWithFrame:CGRectMake(0, 0, screenWidth/3, 49)];
    if (component == 0)
    {
        cell.titleLabel.text =[NSString stringWithFormat:@"%@月",_yearArr[row]];
       
    }
    else if (component == 1)
    {
        cell.titleLabel.text =[NSString stringWithFormat:@"%@月",_monthArr[row]];
    }
    else if(component==2)
    {
        cell.titleLabel.text= [NSString stringWithFormat:@"%@日", _daysArr[row]];
    }else
    {
        cell.titleLabel.text=[NSString stringWithFormat:@"%@",_hourArr[row]];
        
    }
    
    
    return cell;
    
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        _yearString = _yearArr[row];
    }else if(component==1)
    {
        _monthString = _monthArr[row];
    }
    else if (component == 2)
    {
        _dayString=_daysArr[row];
    }else{
        self.selectedNoonIndex = row;
        _hourString=_hourArr[row];
    }
    
    NSString *selectedDate = [NSString stringWithFormat:@"%@-%@-%@",_yearString,_monthString,_dayString];
    
    self.currentDays = [self getDaysNumOfMonth:[self pickDateFromString:selectedDate]];
    
    [pickerView reloadComponent:1];
    
    _selectedDate=[NSString stringWithFormat:@"%@ %@",selectedDate,_hourString];
    
    //选中时间小于当前时间
    if ([[self pickTimeFromString:_selectedDate] compare:[self localeDate:[NSDate date]]] == NSOrderedAscending)
    {
        //滚动到当前时间
        [self SelectCurrentDate];
        _selectedDate=[self currentDate];
        
    }
    
    _selectedCell = (PickerCell *)[pickerView viewForRow:row forComponent:component];
    
    _selectedRow = row + 1;
    
    _selectedCom = component + 1;
    
    if (_selectedCell && _selectedCom && _selectedRow)
    {
        PickerCell *cell1 = (PickerCell *)[pickerView viewForRow:0  forComponent:_selectedCom - 1];
        
        cell1.titleLabel.textColor = [UIColor blackColor];
        
    }
    
}


@end
