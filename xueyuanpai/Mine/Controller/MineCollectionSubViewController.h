//
//  MineCollectionSubViewController.h
//  xueyuanpai
//
//  Created by lidachao on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "MineModel.h"
#import "TimeBankModel.h"
#import "BusinessCenterTableViewCell.h"
@interface MineCollectionSubViewController : BaseViewController

@property(nonatomic,assign)MineType mineType;
@property(nonatomic,strong)BaseViewController * superViewController;
@end
