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
 addr = 12345;
 "address_id" = 9;
 city = "";
 province = "";
 telphone = 13718360863;
 "user_name" = sss;
 
 */

@property(nonatomic,strong)NSString *address_id;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *telphone;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *addr;

@end
