//
//  RequirementTableViewCell.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequirementTableViewCell : UITableViewCell

///显示标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///显示内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;



@end
