//
//  HotActivityTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/21.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "HotActivityTableViewCell.h"

@implementation HotActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [CommonUtils colorWithHex:@"e5e5e5"];
        
        
        //添加背景视图
        UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 280 - 10)];
        backGroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backGroundView];
        
        
        //显示图片的imageView
        UIImageView *showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
        showImageView.backgroundColor = [UIColor yellowColor];
        [backGroundView addSubview:showImageView];
        
        
        //显示标题的lable
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(showImageView.frame) + 10, [UIScreen mainScreen].bounds.size.width - 10, 20)];
        titleLable.text = @"情暖人心公益活动";
        [backGroundView addSubview:titleLable];
        
        //显示钟表的背景图片
        UIImageView * timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(titleLable.frame.origin.x, CGRectGetMaxY(titleLable.frame) + 10, 16, 16)];
        timeImageView.image = [UIImage imageNamed:@"shetuan_icon_time"];
        [backGroundView addSubview:timeImageView];
        
        //显示时间的lable
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(titleLable.frame) + 10, 160, 20)];
        timeLabel.font = [UIFont systemFontOfSize:14.0];
        timeLabel.textColor = [CommonUtils colorWithHex:@"c2c3c4"];
        timeLabel.text = @"2016/4/24 17:00";
        [backGroundView addSubview:timeLabel];
        
        
        //显示食堂的背景图片
        UIImageView *locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame), CGRectGetMaxY(titleLable.frame) + 10, 16, 16)];
        locationImageView.image = [UIImage imageNamed:@"shetuan_icon_location"];
        [backGroundView addSubview:locationImageView];
        
        //显示食堂位置的lable
        UILabel *locationLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(locationImageView.frame) + 5, CGRectGetMaxY(titleLable.frame) + 10, 160, 20)];
        locationLable.font = [UIFont systemFontOfSize:14.0];
        locationLable.textColor = [CommonUtils colorWithHex:@"c2c3c4"];
        locationLable.text = @"一楼食堂";
        [backGroundView addSubview:locationLable];
        
        
        //显示详情的lable
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLable.frame.origin.x, CGRectGetMaxY(timeImageView.frame) + 5, 200, 30)];
        detailLabel.font = [UIFont systemFontOfSize:14.0];
        detailLabel.text = @"我是好人好人好人";
        detailLabel.textColor = [CommonUtils colorWithHex:@"c2c3c4"];
        [backGroundView addSubview:detailLabel];

        
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
