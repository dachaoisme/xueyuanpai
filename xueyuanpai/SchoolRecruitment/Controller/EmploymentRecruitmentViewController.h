//
//  EmploymentRecruitmentViewController.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"

@interface EmploymentRecruitmentViewController : BaseViewController
///就业招聘，实现招聘等使用
@property(nonatomic,assign)SchoolRecruitmentType type;
///公司详情点击查看公司更多职位的时候使用
@property(nonatomic,strong)NSString            * companyID;
///职位搜索的时候使用
@property(nonatomic,strong)NSDictionary        * companySearchDic;
@end
