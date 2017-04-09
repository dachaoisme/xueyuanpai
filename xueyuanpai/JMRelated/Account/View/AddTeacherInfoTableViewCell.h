//
//  AddTeacherInfoTableViewCell.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddTeacherInfoTableViewCellDelegate <NSObject>

-(void)updateInputInfoWithIndex:(NSInteger)index withTextFieldText:(NSString *)text;

@end


@interface AddTeacherInfoTableViewCell : UITableViewCell

@property(nonatomic,strong)UITextField * textField;
@property(nonatomic,strong)UILabel * titleLable;

@property(nonatomic,assign)id<AddTeacherInfoTableViewCellDelegate>delegate;
@end
