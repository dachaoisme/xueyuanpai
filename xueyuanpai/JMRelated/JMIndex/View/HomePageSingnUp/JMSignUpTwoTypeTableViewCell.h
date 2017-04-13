//
//  JMSignUpTwoTypeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/12.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMSignUpTwoTypeTableViewCellDelegate <NSObject>

-(void)inputEndWithText:(NSString *)text withRow:(NSInteger)row;

@end

@interface JMSignUpTwoTypeTableViewCell : UITableViewCell<UITextFieldDelegate>

///左侧的标题
@property (nonatomic,strong)UILabel *leftTitleLabel;


///右侧的输入框
@property (nonatomic,strong)UITextField *rightTextFeild;
@property (nonatomic,assign)id<JMSignUpTwoTypeTableViewCellDelegate>delegate;
@end
