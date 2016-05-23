//
//  GiftExchangeViewController.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/23.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "IndexMallModel.h"
@interface GiftExchangeViewController : BaseViewController

@property(nonatomic,strong)IndexMallModel * mallModel;
///剩余积分
@property(nonatomic,strong)NSString * totalPoint;
@end
