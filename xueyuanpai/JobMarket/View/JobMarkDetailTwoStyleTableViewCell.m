//
//  JobMarkDetailTwoStyleTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/1.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "JobMarkDetailTwoStyleTableViewCell.h"

@interface JobMarkDetailTwoStyleTableViewCell ()

@property (nonatomic,strong)NSString *phoneNuber;

@end

@implementation JobMarkDetailTwoStyleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)bindModel:(JobMarketDetailModel *)model{
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.jobMarketDetailIcon] placeholderImage:[UIImage imageNamed:@"placeHoder"]];
    
    
    self.nameLabel.text = model.jobMarketDetailUserName;
    
#warning 性别没返回
    
    self.schoolLabel.text = model.jobMarketDetailCollege;
    
    self.phoneNumberLabel.text = model.jobMarketDetailMobile;
}

#pragma mark -

- (IBAction)callAction:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(callAction)]) {
        
        [_delegate callAction];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
