//
//  JobMarketDetailOneStyleTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/1.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "JobMarketDetailOneStyleTableViewCell.h"

@interface JobMarketDetailOneStyleTableViewCell ()

///显示商品图片的数据
@property (nonatomic,strong)UIImageView *goodsImageView;

///显示商品名称的label
@property (nonatomic,strong)UILabel *nameLabel;

///显示当前价格的label
@property (nonatomic,strong)UILabel *currentPriceLabel;


///显示已经弃用价格的label
@property (nonatomic,strong)UILabel *deprecatedPriceLabel;

///发布时间
@property (nonatomic,strong)UILabel *releaseTimeLabel;


@end

@implementation JobMarketDetailOneStyleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createImageView];
    }
    
    return self;

}

- (void)createImageView{
    
    
    //创建用于显示商品名称的Label
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 40, 17)];
    nameLabel.text = @"神州笔记本电脑";
    nameLabel.numberOfLines = 0;
    nameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    
    //创建用于显示价格的label
    UILabel *currentPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame) + 5, 100, 17)];
    currentPriceLabel.text = @"￥1900";
    currentPriceLabel.font = [UIFont systemFontOfSize:12];
    [currentPriceLabel setTextColor:[CommonUtils colorWithHex:@"ff6478"]];
    [self.contentView addSubview:currentPriceLabel];
    self.currentPriceLabel = currentPriceLabel;
    
    
    
    //创建用于显示弃用价格的label
    UILabel *deprecatedPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, CGRectGetMinY(currentPriceLabel.frame), 100, 17)];
    deprecatedPriceLabel.text = @"￥1900";
    deprecatedPriceLabel.font = [UIFont systemFontOfSize:12];
    [deprecatedPriceLabel setTextColor:[CommonUtils colorWithHex:@"c7c6cb"]];
    [self.contentView addSubview:deprecatedPriceLabel];
    self.deprecatedPriceLabel = deprecatedPriceLabel;
    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(deprecatedPriceLabel.frame)+2, CGRectGetMinY(deprecatedPriceLabel.frame)+8, 40, 1)];
//    lineView.backgroundColor = [CommonUtils colorWithHex:@"c7c6cb"];
//    [self.contentView addSubview:lineView];
    
    
    //创建一个发布时间
    UILabel *releaseTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 130, CGRectGetMinY(currentPriceLabel.frame), 140, 17)];
    releaseTimeLabel.text = @"5天前发布";
    releaseTimeLabel.font = [UIFont systemFontOfSize:12];
    [releaseTimeLabel setTextColor:[CommonUtils colorWithHex:@"c7c6cb"]];
    [self.contentView addSubview:releaseTimeLabel];
    self.releaseTimeLabel = releaseTimeLabel;

    
    
}

- (void)bindModel:(JobMarketDetailModel *)model{
    
    
    self.nameLabel.text = model.jobMarketDetailTitle;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.jobMarketDetailSalePrice];
    self.deprecatedPriceLabel.attributedText = [CommonUtils lineStr:[NSString stringWithFormat:@"￥%@",model.jobMarketDetailOrginPrice]];
    
    self.releaseTimeLabel.text = model.jobMarketDetailCreateTime;
    
    

    
}


@end
