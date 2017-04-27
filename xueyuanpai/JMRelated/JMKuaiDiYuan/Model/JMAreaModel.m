//
//  JMAreaModel.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/17.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMAreaModel.h"


@implementation JMSubAreaModel

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"areaId" : @"id",
              };
}

@end


@implementation JMAreaModel

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"areaId" : @"id",
              };
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{ @"children" : [JMSubAreaModel class],
              };
}
@end
