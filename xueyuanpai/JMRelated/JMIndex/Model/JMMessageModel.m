//
//  JMMessageModel.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/21.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMMessageModel.h"

@implementation JMMessageUserModel
+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"messageUserId" : @"id",
              };
}


@end
@implementation JMMessageModel

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"messageId" : @"id",
              };
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{ @"user" : [JMMessageUserModel class]
              };
}
@end
