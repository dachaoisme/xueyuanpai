//
//  StarCommunityTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/21.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "StarCommunityTableViewCell.h"

#import "HotActivityModel.h"

@interface StarCommunityTableViewCell ()

///显示图片imageView
@property (nonatomic,strong)UIImageView *showImageView;

///显示图片名称的lable
@property (nonatomic,strong)UILabel *showTitleLable;

///显示详情的label
@property (nonatomic,strong)UILabel *detailLabel;





@end

@implementation StarCommunityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建显示图片imageView
        UIImageView *showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        showImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:showImageView];
        self.showImageView = showImageView;
        
        
        //创建显示图片名称的lable
        UILabel *showTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(showImageView.frame) + 10, CGRectGetMinY(showImageView.frame), 200, 20)];
        showTitleLable.textColor = [UIColor blackColor];
        showTitleLable.font = [UIFont systemFontOfSize:18];
//        showLable.text = @"吉他社";
        [self.contentView addSubview:showTitleLable];
        self.showTitleLable = showTitleLable;
        
        
        //创建图片显示详情的lable
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(showTitleLable.frame), CGRectGetMaxY(showTitleLable.frame)+10, 200, 20)];
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.textColor = [CommonUtils colorWithHex:@"e5e5e5"];
//        detailLabel.text = @"吉他社";
        [self.contentView addSubview:detailLabel];
        self.detailLabel = detailLabel;

        
        
    }
    return self;
}

- (void)bindModel:(HotActivityModel *)model{
    
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:@"test1.jpg"]];
    self.showTitleLable.text = model.title;
    self.detailLabel.text = model.content;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
