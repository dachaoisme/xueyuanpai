//
//  TopUpTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopUpTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *yuanLabel;


///输入框
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;


///标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
