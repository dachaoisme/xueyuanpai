//
//  RecruitmentOneStyleTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SchoolRecruitmentModel.h"

@interface RecruitmentOneStyleTableViewCell : UITableViewCell

///公司名称
@property (weak, nonatomic) IBOutlet UILabel *componyName;

///营业执照内容显示
@property (weak, nonatomic) IBOutlet UILabel *licenseTextLabel;


///营业执照的图片
@property (weak, nonatomic) IBOutlet UIImageView *licenseImageView;

///行业
@property (weak, nonatomic) IBOutlet UILabel *industryLabel;


///规模
@property (weak, nonatomic) IBOutlet UILabel *pepoleLabel;

///性质
@property (weak, nonatomic) IBOutlet UILabel *natureLabel;

///地址
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;


- (void)bindModel:(SchoolRecruitmentDetailModel *)model;


@end
