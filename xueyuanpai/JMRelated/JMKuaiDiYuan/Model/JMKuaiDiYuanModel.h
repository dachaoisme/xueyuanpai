//
//  JMKuaiDiYuanModel.h
//  xueyuanpai
//
//  Created by dachao li on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>





/////////////////////收到的快递/////////////////////

@interface JMKuaiDiYuanReceiveLogModel : NSObject

@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *order_sn;
@property(nonatomic,strong)NSString *create_time;


@end

@interface JMKuaiDiYuanReceiveModel : NSObject

@property(nonatomic,strong)NSString *order_sn;
@property(nonatomic,strong)NSString *express_compay;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSArray <JMKuaiDiYuanReceiveLogModel *> *logs;

@end












/////////////////////寄出的快递/////////////////////
@interface JMKuaiDiYuanReceiverAdressModel : NSObject

@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *telphone;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *addr;
@end


@interface JMKuaiDiYuanSenderAdressModel : NSObject

@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *telphone;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *addr;
@end


/*
 "order_id": "2017041615234913943",  //订单序号
 "create_time": "2017-04-16 15:23:49", //创建时间
 "site_name": "dsd",                   //站点名称
 "express_name": "圆通快递",            //快递公司
 "sender_addr": {
     "user_name": "sss",               //发件人姓名
     "telphone": "13718360863",        //发件人手机号
     "province": "北京市",              //发件人所在省
     "city": "济南市",                  //发件人所在城市
     "addr": "ddddsee"                 //发件人详细地址
     },
 "receiver_addr": {                    //收件人
     "user_name": "sss",
     "telphone": "13718360863",
     "province": "北京市",
     "city": "济南市",
     "addr": "ddddsee"
 },
 "status": 0                         //订单状态 0 等待寄出 1 已寄出 2 未寄出失败
 */
@interface JMKuaiDiYuanModel : NSObject

@property(nonatomic,strong)NSString *order_id;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *site_name;
@property(nonatomic,strong)NSString *express_name;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)JMKuaiDiYuanSenderAdressModel *sender_addr;
@property(nonatomic,strong)JMKuaiDiYuanReceiverAdressModel *receiver_addr;

@end

