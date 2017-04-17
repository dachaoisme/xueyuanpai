//
//  JMSelectAddressViewController.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "JMAdressListModel.h"
@interface JMSelectAddressViewController : BaseViewController

@property(nonatomic,copy)void(^returnBlock)(JMAdressListModel *returnAddressModel);

@end
