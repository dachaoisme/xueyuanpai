//
//  SystemMessageDetailViewController.h
//  xueyuanpai
//
//  Created by 王园园 on 16/7/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "JMMessageModel.h"
@interface SystemMessageDetailViewController : BaseViewController


@property (nonatomic,strong)NSString *messageID;
@property (nonatomic,strong)JMMessageModel *messageModel;

@end
