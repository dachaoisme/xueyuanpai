//
//  JMAreaListViewController.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/17.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "JMAreaModel.h"
@interface JMAreaListViewController : BaseViewController

////////////////--创建地址---地区列表////////////////

@property(nonatomic,copy)void(^returnBlock)(JMAreaModel *returnAreaModel);
@end
