//
//  JMCourseModel.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/15.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCourseModel.h"

@implementation JMCourseModel


+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"courseItemId" : @"id",
              @"courseDescription":@"description"
              };
}

@end
