//
//  BusinessProjectDetailFiveTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BusinessCenterModel.h"


@protocol BusinessProjectDetailFiveTableViewCellDelegate <NSObject>

//拨打电话
- (void)callPhoneNumberAction;

@end

@interface BusinessProjectDetailFiveTableViewCell : UITableViewCell

///姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

///电话
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

///学校
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;


///学历
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;

///毕业时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)bindModel:(BusinessCenterProgectDetailChiefModel *)model;



@property (nonatomic,assign)id<BusinessProjectDetailFiveTableViewCellDelegate>delegate;

@end
