//
//  JMMailDeliveryOneTypeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMMailDeliveryOneTypeTableViewCell : UITableViewCell

///订单号
@property (nonatomic,strong)UILabel *showOrderNumberLabel;


///订单状态
@property (nonatomic,strong)UILabel *showStatuesLabel;


///日期的label
@property (nonatomic,strong)UILabel *showDateLabel;


///等待寄出剩余时间
@property (nonatomic,strong)UILabel *showWaitTimeLabel;

@end
