//
//  JMSignUpProcessingLogModel.h
//  xueyuanpai
//
//  Created by dachao li on 2017/8/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMSignUpProcessingLogModel : NSObject

/*
 "time": "2017-08-06 13:29:14",
 "msg": "您已经提交报名申请，等待系统审核确认",
 "id": "1"
 */

@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *logId;
@end
