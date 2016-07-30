//
//  EditorBankInforViewController.h
//  xueyuanpai
//
//  Created by lidachao on 16/7/30.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "BankModel.h"
@interface EditorBankInforViewController : BaseViewController
///输入框中展示的信息
@property (nonatomic,strong)BankModel  *bankModel;
@property (nonatomic,copy)void(^callBackBlock)(BankModel *model);
@end
