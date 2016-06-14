//
//  GiftDetailStyleOneTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/23.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "GiftDetailStyleOneTableViewCell.h"
#import "IndexMallModel.h"

@interface GiftDetailStyleOneTableViewCell ()
{
    UILabel *goodsLabel;
    UILabel *jiFenLabel;
    UILabel *shengYuNumberLabel;
}
@end

@implementation GiftDetailStyleOneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //初始化商品名字
        goodsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
//        goodsLabel.backgroundColor = [UIColor redColor];
        goodsLabel.text = @"海飞丝新品试用套装";
        goodsLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:goodsLabel];
        
        
        //显示积分
        jiFenLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(goodsLabel.frame), CGRectGetMaxY(goodsLabel.frame), 100, 30)];

        [self.contentView addSubview:jiFenLabel];
        
        NSString *str1 = @"300";
        NSString *str2 = @"积分";
        
        NSString *string1 = str1;
        NSString *string2 = str2;
        NSString *title = [string1 stringByAppendingString:string2];
        NSRange r1 = [title rangeOfString:string1 options:NSCaseInsensitiveSearch];
        NSRange r2 = [title rangeOfString:string2 options:NSCaseInsensitiveSearch];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:r1];
        [str addAttribute:NSForegroundColorAttributeName value:[CommonUtils colorWithHex:@"c2c3c4"] range:r2];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:18.0] range:r1];
        
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:12] range:r2];
        jiFenLabel.attributedText = str;
        
        
        //显示剩余的份数
        shengYuNumberLabel = [[UILabel  alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, CGRectGetMinY(jiFenLabel.frame), 100, 30)];
        shengYuNumberLabel.font = [UIFont systemFontOfSize:12];
        shengYuNumberLabel.text = @"剩余14份";
        shengYuNumberLabel.textColor = [CommonUtils colorWithHex:@"c2c3c4"];
        [self.contentView addSubview:shengYuNumberLabel];
    }
    
    return self;
}

-(void)setWithContentModel:(IndexMallModel *)mallModel
{
    if (mallModel != nil) {
        goodsLabel.text = mallModel.indexMallTitle;
        
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@积分",mallModel.indexMallPoints]];
        
        NSRange range1=[[hintString string]rangeOfString:mallModel.indexMallPoints];
        
        UIColor *color = [CommonUtils colorWithHex:@"ff6478"];
        [hintString addAttribute:NSForegroundColorAttributeName value:color range:range1];
        
        jiFenLabel.attributedText = hintString;
        
        //礼品的剩余份数没写
        shengYuNumberLabel.text = @"剩余123份";
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
