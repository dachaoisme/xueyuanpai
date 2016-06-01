//
//  PublishInformationOneStyleTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/1.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishInformationOneStyleTableViewCell : UITableViewCell

///显示标题的

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


///输入内容的textField
@property (weak, nonatomic) IBOutlet UITextField *inputContentTextField;

///显示元的label
@property (weak, nonatomic) IBOutlet UILabel *yuanLabel;



@end
