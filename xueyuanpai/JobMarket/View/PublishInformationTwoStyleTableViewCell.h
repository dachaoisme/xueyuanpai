//
//  PublishInformationTwoStyleTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/1.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishInformationTwoStyleTableViewCell : UITableViewCell

///标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

///内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

///提示语
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@end
