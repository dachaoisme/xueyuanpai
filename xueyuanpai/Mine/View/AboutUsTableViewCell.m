//
//  AboutUsTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AboutUsTableViewCell.h"

@interface AboutUsTableViewCell ()


///学习图片
@property (weak, nonatomic) IBOutlet UIImageView *studyImageView;

///版本label
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;




@end

@implementation AboutUsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.studyImageView.frame = CGRectMake(SCREEN_WIDTH/2 - 30, 20, 60, 60);
    
    self.versionLabel.frame = CGRectMake(SCREEN_WIDTH/2 - 50, CGRectGetMaxY(self.studyImageView.frame), 100, 100);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
