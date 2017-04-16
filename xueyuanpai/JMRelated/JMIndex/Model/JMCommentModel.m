//
//  JMCommentModel.m
//  xueyuanpai
//
//  Created by dachao li on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCommentModel.h"

@implementation JMCommentUserModel
+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"commentUserId" : @"id",
              };
}


@end

@implementation JMCommentModel
+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{ @"commentId" : @"id",
              };
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{ @"user" : [JMCommentUserModel class]
              };
}
@end

