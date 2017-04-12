//
//  JMHomePageModel.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/10.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMHomePageModel.h"

@implementation JMHomePageModel

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"bannerId" : @"id",
              };
}
@end

@implementation JMTrainProjectModel

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"trainProjectId" : @"id",
              @"trainProjectDescription" : @"description"
              };
}
@end

////////////////实训项目相关
@implementation JMTrainProjectPeopleModel

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"trainProjectPeopleId" : @"id",
              };
}

@end@implementation JMTrainProjectDetailModel

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"trainProjectDetailId" : @"id",
              @"trainProjectDescription":@"description"
              };
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{ @"members" : [JMTrainProjectPeopleModel class]
              };
}
@end
