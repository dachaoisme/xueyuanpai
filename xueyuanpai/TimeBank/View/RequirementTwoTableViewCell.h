//
//  RequirementTwoTableViewCell.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RequirementTwoTableViewCellDelegate <NSObject>

-(void)selectedContentWithwithTag:(NSInteger )tag withBtn:(UIButton *)sender;

@end

@interface RequirementTwoTableViewCell : UITableViewCell


///标题
@property (weak, nonatomic) IBOutlet UILabel *showTextLabel;

///选择按钮
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property(nonatomic,strong)id<RequirementTwoTableViewCellDelegate>delegate;


@end
