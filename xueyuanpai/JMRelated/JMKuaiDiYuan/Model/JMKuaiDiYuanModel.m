//
//  JMKuaiDiYuanModel.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMKuaiDiYuanModel.h"

@implementation JMKuaiDiYuanReceiverAdressModel



@end

@implementation JMKuaiDiYuanSenderAdressModel



@end

@implementation JMKuaiDiYuanModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{ @"sender_addr" : [JMKuaiDiYuanSenderAdressModel class],
              @"receiver_addr" : [JMKuaiDiYuanReceiverAdressModel class]
              };
}

@end
