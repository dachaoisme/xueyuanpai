//
//  EnumDefine.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#ifndef EnumDefine_h
#define EnumDefine_h

typedef NS_ENUM(NSInteger, ReturnCode){
    Success                   = 10000,
    ParamMistake              = 10001,
    UserNameOrPasswordMistake = 10002,
    ServerAbnormal            = 10003,
    TokenInvalid              = 10004,
    OldPassWordMistake        = 10005,
    UpdateMessageMistake      = 10006,
    UpLoadFileIsEmpty         = 10007,
    SignMistake               = 10008
};




#endif /* EnumDefine_h */
