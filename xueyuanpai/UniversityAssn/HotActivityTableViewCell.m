//
//  HotActivityTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/21.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "HotActivityTableViewCell.h"
#import "HotActivityModel.h"

@interface HotActivityTableViewCell ()

///显示图片的imageView
@property (nonatomic,strong)UIImageView *showImageView;

///显示标题的lable
@property (nonatomic,strong)UILabel *titleLable;

///显示时间的lable
@property (nonatomic,strong)UILabel *timeLabel;

///显示食堂位置的lable
@property (nonatomic,strong)UILabel *locationLable;

@end

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
        [backGroundView addSubview:showImageView];
        self.showImageView = showImageView;
        
        
        //显示标题的lable
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(showImageView.frame) + 10, [UIScreen mainScreen].bounds.size.width - 10, 40)];
        titleLable.textColor = [CommonUtils colorWithHex:@"333333"];
        titleLable.font = [UIFont systemFontOfSize:16];
        titleLable.numberOfLines = 0;
//        titleLable.text = @"情暖人心公益活动";
        [backGroundView addSubview:titleLable];
        self.titleLable = titleLable;
        
        //显示钟表的背景图片
        UIImageView * timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(titleLable.frame.origin.x, CGRectGetMaxY(titleLable.frame) + 10, 16, 16)];
        timeImageView.image = [UIImage imageNamed:@"shetuan_icon_time"];
        [backGroundView addSubview:timeImageView];
        
        //显示时间的lable
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(titleLable.frame) + 10, 160, 20)];
        timeLabel.font = [UIFont systemFontOfSize:12.0];
        timeLabel.textColor = [CommonUtils colorWithHex:@"666666"];
//        timeLabel.text = @"2016/4/24 17:00";
        [backGroundView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        
        //显示食堂的背景图片
        UIImageView *locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame), CGRectGetMaxY(titleLable.frame) + 10, 16, 16)];
        locationImageView.image = [UIImage imageNamed:@"shetuan_icon_location"];
        [backGroundView addSubview:locationImageView];
        
        //显示食堂位置的lable
        UILabel *locationLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(locationImageView.frame) + 5, CGRectGetMaxY(titleLable.frame) + 10, 160, 20)];
        locationLable.font = [UIFont systemFontOfSize:12.0];
        locationLable.textColor = [CommonUtils colorWithHex:@"666666"];
//        locationLable.text = @"一楼食堂";
        [backGroundView addSubview:locationLable];
        self.locationLable = locationLable;
        
        
        //显示详情的lable
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLable.frame.origin.x, CGRectGetMaxY(timeImageView.frame) + 5, SCREEN_WIDTH - titleLable.frame.origin.x, 30)];
        detailLabel.font = [UIFont systemFontOfSize:12.0];
//        detailLabel.text = @"我是好人好人好人";
        detailLabel.textColor = [CommonUtils colorWithHex:@"999999"];
        detailLabel.numberOfLines = 0;
        [backGroundView addSubview:detailLabel];
        self.detailLabel = detailLabel;

        
    }
    return self;
}

#pragma mark - 处理model数据
- (void)bindModel:(HotActivityModel *)model{
    
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:[CommonUtils getEffectiveUrlWithUrl:model.logoUrl withType:1]] placeholderImage:[UIImage imageNamed:@"placeHoder.png"]];
    self.titleLable.text = model.title;
    self.timeLabel.text = model.createTime;
    self.locationLable.text = model.place;
    self.detailLabel.text = model.brief;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
