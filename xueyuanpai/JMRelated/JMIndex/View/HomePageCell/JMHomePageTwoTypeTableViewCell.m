//
//  JMHomePageTwoTypeTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 17/4/10.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMHomePageTwoTypeTableViewCell.h"

@implementation JMHomePageTwoTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        [self initContentCell];
    }
    return self;
}


- (void)initContentCell{
    
    
    //创建左侧正在招募实训
    UILabel *showTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 200, 15)];
    showTextLabel.text = @"正在招募实训项目";
    showTextLabel.textColor = [CommonUtils colorWithHex:NORMAL_TITLE_BLACK_COLOR];
    showTextLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:showTextLabel];
    
    
    //创建查看更多的按钮
    UIButton *seeMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seeMoreBtn setTitle:@"查看全部  " forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"list_arrow"];
    [seeMoreBtn setImage:image forState:UIControlStateNormal];
    [seeMoreBtn setTitleColor:[CommonUtils colorWithHex:NORMAL_TITLE_BLACK_COLOR] forState:UIControlStateNormal];
    seeMoreBtn.titleLabel.font = [UIFont systemFontOfSize:12];

    CGFloat text_true_width = [CommonUtils getTextSizeWithText:@"查看全部  " WithFont:12 WithTextheight:14].width;
    [seeMoreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
    [seeMoreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, text_true_width, 0, -text_true_width)];
    
    seeMoreBtn.frame = CGRectMake(SCREEN_WIDTH - 12 - 70, 14, 70, 14);
    
    [seeMoreBtn addTarget:self action:@selector(seeMoreAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:seeMoreBtn];
    
    
}

#pragma mark - 查看更多
- (void)seeMoreAction{
    
    if ([_delegate respondsToSelector:@selector(seeMoreProjectAction)]) {
        [_delegate seeMoreProjectAction];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
