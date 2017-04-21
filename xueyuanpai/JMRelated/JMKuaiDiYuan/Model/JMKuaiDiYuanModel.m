//
//  JMKuaiDiYuanModel.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMKuaiDiYuanModel.h"


/////////////////////收到的快递/////////////////////

@implementation JMKuaiDiYuanReceiveLogModel



@end

@implementation JMKuaiDiYuanReceiveModel


+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{ @"logs" : [JMKuaiDiYuanReceiveLogModel class],
              };
}

@end





/////////////////////寄出的快递/////////////////////


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
