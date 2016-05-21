//
//  StarCommunityTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/21.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "StarCommunityTableViewCell.h"

@implementation StarCommunityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建显示图片imageView
        UIImageView *showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        showImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:showImageView];
        
        
        //创建显示图片名称的lable
        UILabel *showLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(showImageView.frame) + 10, CGRectGetMinY(showImageView.frame), 200, 20)];
        showLable.textColor = [UIColor blackColor];
        showLable.font = [UIFont systemFontOfSize:18];
        showLable.text = @"吉他社";
        [self.contentView addSubview:showLable];
        
        //创建图片显示详情的lable
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(showLable.frame), CGRectGetMaxY(showLable.frame)+10, 200, 20)];
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.textColor = [CommonUtils colorWithHex:@"e5e5e5"];
        detailLabel.text = @"吉他社";
        [self.contentView addSubview:detailLabel];

        
        
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
