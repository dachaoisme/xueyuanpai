//
//  JMMailDeliveryTwoTypeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMMailDeliveryTwoTypeTableViewCell : UITableViewCell

///寄状态的图片
@property (nonatomic,strong)UIImageView *jiImageView;

///寄的地址label
@property (nonatomic,strong)UILabel *jiAddressLabel;


///取状态的图片
@property (nonatomic,strong)UIImageView *quImageView;


///取的地址label
@property (nonatomic,strong)UILabel *quAddressLabel;




@end
