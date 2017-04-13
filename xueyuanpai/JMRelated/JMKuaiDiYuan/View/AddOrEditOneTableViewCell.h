//
//  AddOrEditOneTableViewCell.h
//  KLRecreationFamily
//
//  Created by 王园园 on 16/7/26.
//  Copyright © 2016年 Wangyuanyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddOrEditOneTableViewCell : UITableViewCell<UITextFieldDelegate>

///左侧title的label
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;


///右侧内容的label
@property (weak, nonatomic) IBOutlet UITextField *rightInputContentTextField;



@end
