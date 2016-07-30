//
//  SelectedBankViewController.h
//  xueyuanpai
//
//  Created by lidachao on 16/7/30.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "BankModel.h"
@interface SelectedBankViewController : BaseViewController
@property (nonatomic,copy)void(^callBackBlock)(BankListModel *model);
@property (nonatomic,strong)BankListModel  *bankListModel;
@end
