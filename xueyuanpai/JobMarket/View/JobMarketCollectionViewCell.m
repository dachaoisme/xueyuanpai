//
//  JobMarketCollectionViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/30.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "JobMarketCollectionViewCell.h"

@interface JobMarketCollectionViewCell ()

///显示商品图片的数据
@property (nonatomic,strong)UIImageView *goodsImageView;

///显示商品名称的label
@property (nonatomic,strong)UILabel *nameLabel;

///显示当前价格的label
@property (nonatomic,strong)UILabel *currentPriceLabel;


///显示已经弃用价格的label
@property (nonatomic,strong)UILabel *deprecatedPriceLabel;



@end

@implementation JobMarketCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self createImageView];
    }
    
    return self;
}

- (void)createImageView{
    
    //创建imageView用于显示数据
    UIImageView *imageView = [UIFactory imageView:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-40) viewMode:UIViewContentModeScaleToFill image:nil];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    imageView.image = [UIImage imageNamed:@"test1.jpg"];
    [self addSubview:imageView];
    self.goodsImageView = imageView;
    
    
    //创建用于显示商品名称的Label
    UILabel *nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, CGRectGetWidth(imageView.frame), 20)];
    nameLabel.text = @"苹果产品";
    nameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    
    //创建用于显示价格的label
    UILabel *currentPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame), CGRectGetWidth(imageView.frame), 17)];
    currentPriceLabel.text = @"15555";
    currentPriceLabel.font = [UIFont systemFontOfSize:12];
    [currentPriceLabel setTextColor:[CommonUtils colorWithHex:@"ff6478"]];
    [self.contentView addSubview:currentPriceLabel];
    self.currentPriceLabel = currentPriceLabel;

    
    
    //创建用于显示弃用价格的label
    UILabel *deprecatedPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, CGRectGetMinY(currentPriceLabel.frame), CGRectGetWidth(imageView.frame), 17)];
    deprecatedPriceLabel.text = @"1233";
    deprecatedPriceLabel.font = [UIFont systemFontOfSize:12];
    [deprecatedPriceLabel setTextColor:[CommonUtils colorWithHex:@"c7c6cb"]];
    [self.contentView addSubview:deprecatedPriceLabel];
    self.deprecatedPriceLabel = deprecatedPriceLabel;
    
    

    
}

-(void)setContentWithModel:(JobMarketModel *)model
{
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.jobMarketIdThumbUrl] placeholderImage:[UIImage imageNamed:@"test.jpg"]];
    
    self.nameLabel.numberOfLines = 0;
    [CommonUtils getTextSizeWithText:model.jobMarketTitle WithFont:14 WithTextWidth:CGRectGetWidth(self.frame)];
    
    self.nameLabel.text = model.jobMarketTitle;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.jobMarketSalePrice];
    self.deprecatedPriceLabel.attributedText = [CommonUtils lineStr:[NSString stringWithFormat:@"￥%@",model.jobMarketOriginPrice]];
    
}


@end
