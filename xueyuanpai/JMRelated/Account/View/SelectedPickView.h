//
//  SelectedPickView.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSMutableArray *)tempDataArr;

///选择性别的block
@property(nonatomic,copy)SelectedSexBlock callBackBlock;
@end
