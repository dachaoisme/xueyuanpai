//
//  BusinessPublishProjectThreeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JKPlaceholderTextView.h"

@interface BusinessPublishProjectThreeTableViewCell : UITableViewCell

///标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///输入内容的textView

@property (weak, nonatomic) IBOutlet JKPlaceholderTextView *inputContentTextView;




@end
