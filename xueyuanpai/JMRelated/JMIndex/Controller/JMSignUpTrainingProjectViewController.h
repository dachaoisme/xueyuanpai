//
//  JMSignUpTrainingProjectViewController.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/12.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "BaseViewController.h"

@interface JMSignUpTrainingProjectViewController : BaseViewController

///////////////////////////报名实训项目///////////////////////////

///当前项目的id
@property (nonatomic,strong)NSString *entity_id;
@property (nonatomic,strong)NSString *entity_type;
@property(nonatomic,copy)void(^returnBlock)();
@end
