//
//  JMAdressListModel.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/17.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMAdressListModel : NSObject

/*
 "id": 1,
 "user_name": "sss",
 "telphone": "13718360863",
 "province": "北京市",
 "city": "济南市",
 "addr": "ddddsee"
 
 */

@property(nonatomic,strong)NSString *adressId;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *telphone;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *addr;

@end
