//
//  UserDefaultsDataDeal.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsDataDeal : NSObject

+(void) saveWithKey:(NSString*) key andValue:(id) value;

+(id)getForKey:(NSString*) key;

+(NSDictionary *)getDictionaryForKey:(NSString*) key;

+(NSArray *)getArrayForKey:(NSString*) key;

+(NSString*) getStringForKey:(NSString*) key;


+(void) saveWithKey:(NSString*) key andBoolValue:(BOOL) value;

+(BOOL)getBoolForKey:(NSString *)key;

+(void) saveWithKey:(NSString*) key andIntegerValue:(NSInteger) value;

+(NSInteger)getNSIntegerForKey:(NSString *)key;

+(void) saveWithKey:(NSString*) key andDoubleValue:(double) value;

+(NSTimeInterval)getDoubleForKey:(NSString *)key;

+(void) saveWithKey:(NSString*) key andlonglongValue:(int64_t) value;

+(int64_t)getLongLongForKey:(NSString *)key;

+(void)deleteKey:(NSString*)key;

@end
