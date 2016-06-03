//
//  MyPickView.h
//  DatePicker
//
//  Created by dida on 16/3/24.
//  Copyright © 2016年 Amiee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectedTimeBlock)(BOOL yesIsSure,NSString * selectedDate,NSInteger noonIndex);

@protocol MyPickViewDelegate <NSObject>

-(void)selectedTime;

@end

@interface MyPickView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

//选中日期时间
@property (nonatomic,copy)NSString *selectedDate;

-(void)myPickView:(UIPickerView *)pickView yearArray:(NSArray *)yearArr monthArray:(NSArray *)monthArr  hourArray:(NSArray *)hourArr minuArr:(NSArray *)minuArr;
///选中的是上午还是下午
@property(nonatomic,assign)NSInteger selectedNoonIndex;
@property(nonatomic,strong)id<MyPickViewDelegate>delegate;

@property(nonatomic,strong)SelectedTimeBlock selectedBlock;

@end
