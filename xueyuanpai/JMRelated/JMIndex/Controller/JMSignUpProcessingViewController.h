//
//  JMSignUpProcessingViewController.h
//  xueyuanpai
//
//  Created by dachao li on 2017/8/6.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "BaseViewController.h"

@interface JMSignUpProcessingViewController : BaseViewController

@property(nonatomic,strong)NSString *entity_type;
@property(nonatomic,strong)NSString *entity_id;

@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *theTitle;
@property(nonatomic,strong)NSString *subTitle;
@property(nonatomic,strong)NSString *colledge_name;
@property(nonatomic,assign)SignupType status;
@end
