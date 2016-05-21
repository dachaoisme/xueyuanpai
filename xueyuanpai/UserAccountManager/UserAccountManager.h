//
//  UserAccountManager.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/12.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAccountManager : NSObject

///用户ID 唯一标示
@property (nonatomic, strong) NSString *userId;
///用户手机号
@property (nonatomic, strong) NSString *phoneNum;
//用户密码
@property (nonatomic, strong) NSString *password;

+ (instancetype)sharedInstance;

-(void)saveUserAccountWithUserId:(NSString *)userId withPhoneNum:(NSString *)phoneNum withPassword:(NSString *)password;
-(NSDictionary *)getUserInfo;
-(NSString *)getUserId;
-(NSString *)getUserPhoneNum;
-(NSString *)getUserPassWord;
@end
