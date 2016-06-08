//
//  CommonTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/8.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKPlaceholderTextView.h"

@interface CommonTableViewCell : UITableViewCell

///标题
@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *rightLabel;

///textView输入内容
@property (nonatomic,strong)JKPlaceholderTextView *textView;

@end
