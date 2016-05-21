//
//  UserDefaultsDataDeal.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "UserDefaultsDataDeal.h"

@implementation UserDefaultsDataDeal


#pragma mark - 封装的工具

#pragma mark - 常规对象数据类型（NSDictionary、NSArray、NSString）
+(void) saveWithKey:(NSString*) key andValue:(id) value
{
    if (value && key.length > 0)
    {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if (value == nil && key.length > 0 )
    {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
+(id)getForKey:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+(NSDictionary *)getDictionaryForKey:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:key];
}
+(NSArray *)getArrayForKey:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] arrayForKey:key];
}
+(NSString*) getStringForKey:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}
#pragma mark - bool类型的数据
+(void) saveWithKey:(NSString*) key andBoolValue:(BOOL) value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)getBoolForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}
#pragma mark - NSInteger类型的数据
+(void) saveWithKey:(NSString*) key andIntegerValue:(NSInteger) value
{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSInteger)getNSIntegerForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}
#pragma mark - double类型的数据
+(void) saveWithKey:(NSString*) key andDoubleValue:(double) value
{
    [[NSUserDefaults standardUserDefaults] setDouble:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSTimeInterval)getDoubleForKey:(NSString *)key{
    return (NSTimeInterval)[[NSUserDefaults standardUserDefaults] doubleForKey:key];
}
#pragma mark - longlong类型的数据
+(void) saveWithKey:(NSString*) key andlonglongValue:(int64_t) value
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithLongLong:value] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - longlong类型的数据
+(int64_t)getLongLongForKey:(NSString *)key{
    NSNumber *llNumber=[[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (llNumber) {
        return [llNumber longLongValue];
    }
    return 0;
}
#pragma mark - 根据key删除value值
+(void)deleteKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
