//
//  RequirementTableViewCell.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RequirementTableViewCell : UITableViewCell<UITextFieldDelegate>

///显示标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///输入内容的textField
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;


@end
