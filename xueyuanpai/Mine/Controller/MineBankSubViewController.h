//
//  MineBankSubViewController.h
//  xueyuanpai
//
//  Created by lidachao on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "TimeBankTableViewCell.h"
#import "TimeBankDetailViewController.h"
#import "TimeBankModel.h"
@interface MineBankSubViewController : BaseViewController
@property(nonatomic,assign)MineTimeBankStatus mineTimeBankStatus;
@property(nonatomic,strong)BaseViewController * superViewController;


@end
