//
//  JMExpressCompanyViewController.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/17.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "BaseViewController.h"

@interface JMExpressCompanyViewController : BaseViewController

@property(nonatomic,copy)void(^returnBlock)(NSString *companyName,NSString *companyId);

@end
