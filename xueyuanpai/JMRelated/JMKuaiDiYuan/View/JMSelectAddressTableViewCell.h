//
//  JMSelectAddressTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMSelectAddressTableViewCell : UITableViewCell

///姓名 + 电话号码的label
@property (nonatomic,strong)UILabel *nameAndPhoneLabel;

///地址信息的label
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UIButton *editBtn;
@end
