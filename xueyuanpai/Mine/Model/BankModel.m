//
//  BankModel.m
//  xueyuanpai
//
//  Created by lidachao on 16/7/30.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BankModel.h"

@implementation BankModel


/*
 user_id      int          必需    用户序号
 name         string       必需    姓名
 bank_id      int          必需    银行序号
 branch_bank  string       必需    支行名称
 card_no      string       必需    银行卡号
 
 */
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {

        self.userId           = [dic stringForKey:@"user_id"];
        self.name             = [dic stringForKey:@"name"];
        self.bankId           = [dic stringForKey:@"bank_id"];
        self.branchBankName     = [dic stringForKey:@"branch_bank"];
        self.bankNum          = [dic stringForKey:@"card_no"];
        self.bankName         =[dic stringForKey:@"bank_name"];
    }
    return self;
}

@end


///我的积分
@implementation BankListModel

/*
 "id": 2,
 "name": "中国农业银行",
 "en": "z",
 "hot": 1,
 "ord": 1,
 "create_at": "2016-07-26 17:50:40"
 */
-(id)initWithDic:(NSDictionary *)dic
{
    
    self = [super init];
    if (self) {

        self.bankId           = [dic stringForKey:@"id"];
        self.bankName         = [dic stringForKey:@"name"];
        self.bankTag          = [dic stringForKey:@"en"];
        self.bankHot          = [dic stringForKey:@"hot"];
        self.bankOid          = [dic stringForKey:@"ord"];
        self.bankCreateTime   = [dic stringForKey:@"create_at"];
    }
    return self;
}

@end