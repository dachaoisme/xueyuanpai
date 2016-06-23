//
//  AboutUsTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsTableViewCell : UITableViewCell

///内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

///学习图片
@property (weak, nonatomic) IBOutlet UIImageView *studyImageView;

///版本label
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;



@end
