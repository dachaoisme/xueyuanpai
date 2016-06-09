//
//  AddProjectLeaderOneTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/9.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessCenterModel.h"
@interface AddProjectLeaderOneTableViewCell : UITableViewCell<UITextFieldDelegate>

///标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///输入内容的输入框
@property (weak, nonatomic) IBOutlet UITextField *inputContentTextField;

///传入的model
@property(nonatomic,strong)BusinessCenterPublicProgectModel * publicProgectModel;
@end
