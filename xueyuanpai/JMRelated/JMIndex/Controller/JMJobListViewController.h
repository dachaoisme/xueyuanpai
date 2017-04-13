//
//  JMJobListViewController.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "BaseViewController.h"

@interface JMJobListViewController : BaseViewController

//////////////////////////////招聘的岗位列表//////////////////////////////
@property(nonatomic,strong)NSString *trainProjectId;
@property(nonatomic,copy)void(^returnBlock)(NSString *returnBlock);
@end
