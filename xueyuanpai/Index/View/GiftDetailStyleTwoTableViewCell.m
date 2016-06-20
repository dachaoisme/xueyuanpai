//
//  GiftDetailStyleTwoTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/23.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "GiftDetailStyleTwoTableViewCell.h"

@implementation GiftDetailStyleTwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 18, 5, 15)];
        view.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
        [self.contentView addSubview:view];
        
        UILabel *introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view.frame) + 5, 10, 300, 30)];
        introduceLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:introduceLabel];
        self.introduceLabel = introduceLabel;
        
        
        
        UILabel *detailContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(introduceLabel.frame) + 5, [[UIScreen mainScreen] bounds].size.width - 20, 30)];
        detailContentLabel.textColor = [CommonUtils colorWithHex:@"c2c3c4"];
        detailContentLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:detailContentLabel];
        
        self.detailContentLabel = detailContentLabel;
        
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
