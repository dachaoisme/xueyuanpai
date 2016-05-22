//
//  AddTeacherInfoTypeTwoTableViewCell.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddTeacherInfoTypeTwoTableViewCellDelegate <NSObject>

-(void)updateInputInfoTypeTwoWithIndex:(NSInteger)index withTextFieldText:(NSString *)text;

@end

@interface AddTeacherInfoTypeTwoTableViewCell : UITableViewCell

@property(nonatomic,strong)UITextView * textView ;//UITextField * textField;
@property(nonatomic,strong)UILabel * titleLable;

@property(nonatomic,assign)id<AddTeacherInfoTypeTwoTableViewCellDelegate>delegate;
@end
