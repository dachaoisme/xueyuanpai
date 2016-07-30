//
//  BankModel.h
//  xueyuanpai
//
//  Created by lidachao on 16/7/30.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

///用户的银行卡信息
@interface BankModel : NSObject
/*
 user_id      int          必需    用户序号
 name         string       必需    姓名
 bank_id      int          必需    银行序号
 branch_bank  string       必需    支行名称
 card_no      string       必需    银行卡号

 */

///用户id
@property (nonatomic,strong)NSString  *userId;
///用户名
@property(nonatomic,strong)NSString  *name;
///银行序号
@property(nonatomic,strong)NSString  *bankId;
///银行名称
@property(nonatomic,strong)NSString  *bankName;
///银行支行名称
@property(nonatomic,strong)NSString  *branchBankName;
///银行卡号
@property(nonatomic,strong)NSString  *bankNum;

-(id)initWithDic:(NSDictionary *)dic;

@end

///银行列表
@interface BankListModel : NSObject

/*
 "id": 2,
 "name": "中国农业银行",
 "en": "z",
 "hot": 1,
 "ord": 1,
 "create_at": "2016-07-26 17:50:40"
 */
///银行id
@property(nonatomic,strong)NSString  *bankId;
///银行名字
@property(nonatomic,strong)NSString  *bankName;
///银行的第一个字母
@property(nonatomic,strong)NSString  *bankTag;
///银行是不是热门
@property(nonatomic,strong)NSString  *bankHot;
///银行的排序
@property(nonatomic,strong)NSString  *bankOid;
///银行创建时间
@property(nonatomic,strong)NSString  *bankCreateTime;
-(id)initWithDic:(NSDictionary *)dic;
@end