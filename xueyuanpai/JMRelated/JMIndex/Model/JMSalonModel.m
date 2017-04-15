//
//  JMSalonModel.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/15.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMSalonModel.h"

@implementation JMSalonModel


+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"trainProjectDetailId" : @"id",
              @"trainProjectDescription":@"description"
              };
}

@end
