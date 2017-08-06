//
//  JMEditNickNameTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/8/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMEditNickNameTableViewCell : UITableViewCell<UITextFieldDelegate>


///标题
@property (strong, nonatomic) UILabel *titleLabel;


///文本输入框
@property (strong, nonatomic) UITextField *inputTextField;



@end
