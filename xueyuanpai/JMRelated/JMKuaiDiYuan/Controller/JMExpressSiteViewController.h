//
//  JMExpressSiteViewController.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/17.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "JMExpressSiteModel.h"
@interface JMExpressSiteViewController : BaseViewController


////////////////站点列表////////////////

@property(nonatomic,copy)void(^returnBlock)(JMExpressSiteModel *returnExpressSiteModel);

@end