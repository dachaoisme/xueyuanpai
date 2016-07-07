//
//  TopUpTwoTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  TopUpTwoTableViewCellDelegate <NSObject>

- (void)payStyleAction:(id)sender;

@end

@interface TopUpTwoTableViewCell : UITableViewCell

///支付图片
@property (weak, nonatomic) IBOutlet UIImageView *payImageView;
///支付放式
@property (weak, nonatomic) IBOutlet UILabel *payWay;


///支付状态按钮
@property (weak, nonatomic) IBOutlet UIButton *payStatusButton;


@property (assign,nonatomic)id<TopUpTwoTableViewCellDelegate>delegate;



@end
