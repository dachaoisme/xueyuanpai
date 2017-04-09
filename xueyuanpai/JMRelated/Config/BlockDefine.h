//
//  BlockDefine.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "CollegeModel.h"

#ifndef BlockDefine_h
#define BlockDefine_h


//注册的时候，选择的性别
typedef void(^SelectedSexBlock)(NSString * sex);
//注册的时候，选择的头像
typedef void(^SelectedImageBlock)(UIImage * image);
//注册的时候，选择的学校
typedef void(^SelectedSchollBlock)(CollegeModel  *collegeModel);

#endif /* BlockDefine_h */
